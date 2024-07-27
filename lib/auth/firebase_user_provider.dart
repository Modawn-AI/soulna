import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../provider/base_auth_user_provider.dart';

export '../provider/base_auth_user_provider.dart';

class DearMeFirebaseUser extends BaseAuthUser {
  DearMeFirebaseUser(this.user);
  User? user;
  @override
  bool get loggedIn => user != null;

  @override
  AuthUserInfo get authUserInfo => AuthUserInfo(
        uid: user?.uid,
        email: user?.email,
        displayName: user?.displayName,
        photoUrl: user?.photoURL,
        phoneNumber: user?.phoneNumber,
      );

  @override
  Future? delete() => user?.delete();

  @override
  Future? updateEmail(String email) async {
    try {
      await user?.updateEmail(email);
    } catch (_) {
      await user?.verifyBeforeUpdateEmail(email);
    }
  }

  @override
  Future? sendEmailVerification() => user?.sendEmailVerification();

  @override
  bool get emailVerified {
    // Reloads the user when checking in order to get the most up to date
    // email verified status.
    if (loggedIn && !user!.emailVerified) {
      refreshUser();
    }
    return user?.emailVerified ?? false;
  }

  @override
  Future refreshUser() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload().then((_) => user = FirebaseAuth.instance.currentUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-token-expired') {
        await _refreshToken();
      } else {
        rethrow;
      }
    }
  }

  Future<void> _refreshToken() async {
    try {
      // 현재 사용자의 ID 토큰을 강제로 새로고침
      await user?.getIdToken(true);
      // 사용자 정보 다시 로드
      await refreshUser();
    } catch (e) {
      // 토큰 갱신 실패 시 로그아웃 처리
      await FirebaseAuth.instance.signOut();
      user = null;
    }
  }

  Future<void> forceRefreshIdToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        IdTokenResult tokenResult = await user.getIdTokenResult(true);
        print("Token refreshed. New expiration: ${tokenResult.expirationTime}");
      } catch (e) {
        print("Error refreshing token: $e");
      }
    }
  }

  static BaseAuthUser fromUserCredential(UserCredential userCredential) => fromFirebaseUser(userCredential.user);
  static BaseAuthUser fromFirebaseUser(User? user) => DearMeFirebaseUser(user);
}

Stream<BaseAuthUser> dearMeFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn ? TimerStream(true, const Duration(seconds: 1)) : Stream.value(user))
        .flatMap((user) => Stream.fromFuture(() async {
              final authUser = DearMeFirebaseUser(user);
              if (user != null) {
                try {
                  await authUser.refreshUser();
                } catch (e) {
                  print('Error refreshing user: $e');
                  // 에러 발생 시 null 반환하여 로그아웃 상태로 처리
                  return null;
                }
              }
              return authUser;
            }()))
        .map<BaseAuthUser>((user) {
      currentUser = user;
      return currentUser!;
    });