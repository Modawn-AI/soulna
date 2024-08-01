import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

enum SocialType {
  googleLogin('GOOGLE'),
  appleLogin('APPLE'),
  none('NONE');

  final String value;

  const SocialType(this.value);

  static void setSocialType({required SocialType type}) {
    SocialManager.socialType = type;
    SharedPreferencesManager.setString(
      key: kSocialTypeSPKey,
      value: type.value,
    );
  }
}

const List<String> scopes = <String>[
  'email',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);

class SocialManager extends ChangeNotifier {
  static SocialType socialType = SocialType.none;
  static final SocialManager _instance = SocialManager._internal();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  factory SocialManager() => _instance;

  SocialManager._internal();

  static SocialManager getInstance() {
    return _instance;
  }

  final ValueNotifier<bool> _loading = ValueNotifier(false);
  final ValueNotifier<bool> _loggedIn = ValueNotifier(false);
  final ValueNotifier<bool> _isFirst = ValueNotifier(true);
  final ValueNotifier<bool> _isTempLogin = ValueNotifier(true);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> get loggedIn => _loggedIn;
  ValueNotifier<bool> get isFirst => _isFirst;
  ValueNotifier<bool> get isTempLogin => _isTempLogin;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String?> getAccessToken() async {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      final IdTokenResult tokenResult = await user.getIdTokenResult();
      return tokenResult.token;
    }
    return null;
  }

  Future<User?> refreshAccessToken() async {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.getIdToken(true);
      return user;
    }
    return null;
  }

  bool isAccessTokenExpired(String accessToken) {
    try {
      Map<String, dynamic> payload = JwtDecoder.decode(accessToken);
      int exp = payload['exp'];
      int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return exp < currentTime;
    } catch (e) {
      debugPrint(e.toString());
      return true; // 만료 여부를 확인할 수 없는 경우 만료된 것으로 처리
    }
  }

  Future<User?> tryAutoLogin() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        final accessToken = await getAccessToken();
        if (accessToken != null && !isAccessTokenExpired(accessToken)) {
          return currentUser;
        }
        await refreshAccessToken();
        final newAccessToken = await getAccessToken();
        if (newAccessToken != null && !isAccessTokenExpired(newAccessToken)) {
          return currentUser;
        }
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> loginWithGoogle({required Function(dynamic) callback}) async {
    try {
      String? googleAccessToken;
      IdTokenResult googleIdToken;
      _googleSignIn.isSignedIn().then((isLogin) async {
        if (!isLogin) {
          await _googleSignIn.signIn().then((result) async {
            if (result != null) {
              GoogleSignInAuthentication authentication = await result.authentication;
              OAuthCredential googleCredential = GoogleAuthProvider.credential(
                idToken: authentication.idToken,
                accessToken: authentication.accessToken,
              );
              UserCredential credential = await _firebaseAuth.signInWithCredential(googleCredential);
              final User? googleUser;
              if (credential.user != null) {
                googleUser = credential.user;
                logger.e(googleUser);
                googleUser!.reload();
                if (authentication.accessToken != null) {
                  googleAccessToken = authentication.accessToken;
                  googleIdToken = await credential.user!.getIdTokenResult();
                  logger.d("googleAccessToken =  $googleAccessToken");
                  logger.d("googleIdToken =  $googleIdToken");
                  NetworkManager().saveTokens(googleIdToken.token!, googleIdToken.token!);
                  await ApiCalls().googleLogin(googleIdToken.token!).then((value) {
                    debugPrint('googleLogin: $value');
                    SocialType.setSocialType(type: SocialType.googleLogin);
                    callback(value);
                  });
                }
              }
            }
          }).catchError((err) {
            logger.d('Err$err');
          });
        } else {
          googleAccessToken = await SharedPreferencesManager.getString(key: kGoogleAccessTokenSPKey);
          if (googleAccessToken == null) {
            googleLogout(callback: () async {});
          }
        }
      });
      isTempLogin.value = false;
    } catch (error) {
      logger.d(error);
    }
  }

  Future<void> googleLogout({required Function() callback}) async {
    _googleSignIn.isSignedIn().then((isLogin) async {
      if (isLogin) {
        await _googleSignIn.signOut();
      }
    });
    _firebaseAuth.signOut();
    _firebaseAuth.currentUser!.delete();
    await deleteSharedData("googleLogout");
    logger.d('google logout');
    callback();
  }

  Future<void> loginWithApple({required Function(dynamic) callback}) async {
    final clientState = const Uuid().v4();
    if (await SignInWithApple.isAvailable()) {
      try {
        final appleIdCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'soulna.modawn.com',
            redirectUri: Uri.parse(
              'https://app.soulna.kr/oauth/apple',
            ),
          ),
          state: clientState,
        );

        final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
        final AuthCredential credential = oAuthProvider.credential(
          idToken: appleIdCredential.identityToken,
          accessToken: appleIdCredential.authorizationCode,
        );

        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;
        if (user != null) {
          final appleIdToken = await user.getIdTokenResult();
          logger.d('appleIdToken = $appleIdToken');
          NetworkManager().saveTokens(appleIdToken.token!, appleIdToken.token!);
          await ApiCalls().appleLogin(appleIdToken.token!).then((value) {
            debugPrint('appleLogin: $value');
            SocialType.setSocialType(type: SocialType.appleLogin);
            callback(value);
          });
        }

        isTempLogin.value = false;
      } catch (e) {
        logger.d('error = $e');
      }
    }
  }

  Future<void> appleLoginCheck({required Function(dynamic) callback}) async {
    String? credentialId = await SharedPreferencesManager.getString(key: kAppleUserIdentifierSPKey);
    dynamic responseData;
    if (credentialId == null) {
      logger.d("not apple login");
      await loginWithApple(callback: callback);
    } else {
      final credentialState = await SignInWithApple.getCredentialState(credentialId);
      switch (credentialState) {
        case CredentialState.authorized:
          {
            logger.d('appleLoginCheck --- authorized');
            responseData = await snsLogin();
            await callback(responseData);
            break;
          }
        case CredentialState.notFound:
          debugPrint('notFound');
          break;
        case CredentialState.revoked:
          debugPrint('revoked');
          break;
      }
    }
  }

  void appleLogout({required Function() callback}) async {
    _firebaseAuth.signOut();
    _firebaseAuth.currentUser!.delete();
    await deleteSharedData("appleLogout");
    callback();
  }

  Future<void> socialLogin({required Function(dynamic) callback}) async {
    final type = await SharedPreferencesManager.getString(key: kSocialTypeSPKey);
    logger.d("SocialType === $type");
    switch (type) {
      case 'GOOGLE':
        await loginWithGoogle(callback: callback);
        break;
      case 'APPLE':
        await appleLoginCheck(callback: callback);
        break;
      case 'NONE':
        break;
    }
  }

  Future<void> socialLogout({required Function() callback}) async {
    final type = await SharedPreferencesManager.getString(key: kSocialTypeSPKey);
    switch (type) {
      case 'GOOGLE':
        googleLogout(callback: callback);
        break;
      case 'APPLE':
        appleLogout(callback: callback);
        break;
      case 'NONE':
      default:
        _firebaseAuth.signOut();
        _firebaseAuth.currentUser!.delete();
        break;
    }
  }

  Future<bool> isSocialLogin() async {
    bool isLogin = false;
    final type = await SharedPreferencesManager.getString(key: kSocialTypeSPKey);
    switch (type) {
      case 'GOOGLE':
        isLogin = await SharedPreferencesManager.hasStringData(key: kGoogleAccessTokenSPKey);
        break;
      case 'APPLE':
        isLogin = await SharedPreferencesManager.hasStringData(key: kAppleAuthorizationCodeSPKey);
        break;
      case 'NONE':
        break;
    }
    debugPrint("------------ isLogin -> $isLogin");

    if (isLogin) {
      String? accessToken;
      String? refreshToken;
      accessToken = await SharedPreferencesManager.getString(key: kAccessTokenSPKey);
      refreshToken = await SharedPreferencesManager.getString(key: kRefreshTokenSPKey);
      NetworkManager().saveTokens(accessToken!, refreshToken!);

      logger.d('accessToken = $accessToken');
      logger.d('refreshToken = $refreshToken');
    }

    return isLogin;
  }

  Future<dynamic> snsLogin() async {
    try {
      // final response = await ApiCalls().snsLogin();
      // return response!;
    } catch (e) {
      CustomException exception = e as CustomException;
      if (exception.code == ErrorCode.validUser_1) {
        deleteSharedData("snsLogin == validUser_1");
        return exception.code;
      }
      if (exception.code == ErrorCode.refreshToken_1) {
        deleteSharedData("snsLogin == refreshToken_1");
        return exception.code;
      }
    }
  }

  Future<void> deleteSharedData(String location) async {
    SharedPreferencesManager.deleteAllKeys(location);
    SocialType.setSocialType(type: SocialType.none);
  }
}
