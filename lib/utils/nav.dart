import 'dart:async';
import 'dart:developer';
import 'package:Soulna/manager/social_manager.dart';
import 'package:Soulna/pages/auth/auth_screen.dart';
import 'package:Soulna/pages/auth/find_password.dart';
import 'package:Soulna/pages/auth/login_screen.dart';
import 'package:Soulna/pages/auth/new_password_screen.dart';
import 'package:Soulna/pages/auth/signUp_additionalInfo.dart';
import 'package:Soulna/pages/auth/signUp_agree.dart';
import 'package:Soulna/pages/auth/signUp_email.dart';
import 'package:Soulna/pages/auth/signUp_password.dart';
import 'package:Soulna/pages/auth/splash_screen.dart';
import 'package:Soulna/pages/drawer/awaiting_response_screen.dart';
import 'package:Soulna/pages/drawer/customer_service.dart';
import 'package:Soulna/pages/drawer/notice_screen.dart';
import 'package:Soulna/pages/drawer/one_to_one_screen.dart';
import 'package:Soulna/pages/drawer/past_diary.dart';
import 'package:Soulna/pages/drawer/past_fortune_screen.dart';
import 'package:Soulna/pages/drawer/privacy_policy_update_notice_screen.dart';
import 'package:Soulna/pages/drawer/response_completed_screen.dart';
import 'package:Soulna/pages/drawer/terms_and_conditions.dart';
import 'package:Soulna/pages/main/instagram_view.dart';
import 'package:Soulna/pages/main/main.dart';
import 'package:Soulna/pages/main/saju_daily_screen.dart';
import 'package:Soulna/pages/main/ten_twelve_screen.dart';
import 'package:Soulna/pages/notification/notification_settings.dart';
import 'package:Soulna/pages/profile/edit_profile.dart';
import 'package:Soulna/pages/profile/profile_settings_screen.dart';
import 'package:Soulna/pages/settings/account_setting_screen.dart';
import 'package:Soulna/pages/settings/date_of_birth_screen.dart';
import 'package:Soulna/pages/settings/settings_screen.dart';
import 'package:Soulna/provider/base_auth_user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Soulna/utils/serialization_util.dart';

export 'package:go_router/go_router.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._() {
    initialUser = null;
    user = null;
    showSplashImage = true;
    _redirectLocation = null;
    notifyOnAuthChange = true;
  }

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = false;
  String? _redirectLocation;

  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) async {
    final shouldUpdate = user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;

    // Attempt to refresh the authentication token
    try {
      await user?.refreshUser();
      // If refresh is successful, update the loading state
      showSplashImage = false;
    } catch (e) {
      print('Error refreshing token: $e');
      // Handle token refresh error (e.g., log out the user)
      user = null;
      showSplashImage = false;
    }

    // Notify listeners after attempting to refresh the token
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    updateNotifyOnAuthChange(true);
  }

  void handleAuthError() {
    user = null;
    showSplashImage = false;
    notifyListeners();
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

String splashScreen = 'SplashScreen';
String authScreen = 'AuthScreen';
String loginScreen = 'LoginScreen';
String findPassword = 'FindPassword';
String editProfile = 'EditProfile';
String notificationSettings = 'NotificationSettings';
String signUpAgree = 'SignUpAgree';
String signUpEmail = 'SignUpEmail';
String signUpPassword = 'SignUpPassword';
String signUpAdditionalInfo = 'SignUpAdditionalInfo';
String mainScreen = 'MainScreen';
String settingsScreen = 'SettingsScreen';
String accountSettingScreen = 'AccountSettingScreen';
String newPasswordScreen = 'NewPasswordScreen';
String dateOfBirthScreen = 'DateOfBirthScreen';
String dateOfBirthMain = 'DateOfBirthMain';
String bookDetailScreen = 'BookDetailScreen';
String pastFortuneScreen = 'PastFortuneScreen';
String pastDiary = 'PastDiary';
String noticeScreen = 'NoticeScreen';
String customerService = 'CustomerService';
String termAndConditions = 'TermAndConditions';
String privacyPolicyUpdateNoticeScreen = 'PrivacyPolicyUpdateNoticeScreen';
String responseCompletedScreen = 'ResponseCompletedScreen';
String awaitingResponseScreen = 'AwaitingResponseScreen';
String oneToOneScreen = 'OneToOneScreen';
String selectPhotoFromDevice = 'SelectPhotoFromDevice';
String selectPhotoFromInstagram = 'SelectPhotoFromInstagram';
String autobiographyScreen = 'AutobiographyScreen';
String animationScreen = 'AnimationScreen';
String journalScreen = 'JournalScreen';
String createJournal = 'CreateJournal';
String tenTwelveScreen = 'TenTwelveScreen';
String sajuDailyScreen = 'sajuDailyScreen';
String profileSettingsScreen = 'ProfileSettingsScreen';
String instagramView = 'InstagramView';

GoRouter createRouter(AppStateNotifier appStateNotifier, SocialManager socialManager) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, _) => const SplashScreen(),
      redirect: (context, state) {
        // final loggedIn = context.read<SocialManager>().loggedIn.value;
        // final isFirst = context.read<SocialManager>().isFirst.value;
        // final isGuestLogin = context.read<SocialManager>().isTempLogin.value;

        return null;
      },
      routes: [
        FFRoute(
          name: 'initialize',
          path: '/',
          builder: (context, params) => const SplashScreen(),
        ),
        FFRoute(
          name: authScreen,
          builder: (context, params) => const AuthScreen(),
        ),
        FFRoute(
          name: loginScreen,
          builder: (context, params) => const LoginScreen(),
        ),
        FFRoute(
          name: findPassword,
          builder: (context, params) => const FindPassword(),
        ),
        FFRoute(
          name: editProfile,
          builder: (context, params) => const EditProfile(),
        ),
        FFRoute(
          name: notificationSettings,
          builder: (context, params) => const NotificationSettings(),
        ),
        FFRoute(
          name: signUpAgree,
          builder: (context, params) => const SignupAgree(),
        ),
        FFRoute(
          name: signUpEmail,
          builder: (context, params) => const SignupEmail(),
        ),
        FFRoute(
          name: signUpPassword,
          builder: (context, params) => const SignUpPassword(),
        ),
        FFRoute(
          name: signUpAdditionalInfo,
          builder: (context, params) => const SignUpAdditionalInfo(),
        ),
        FFRoute(
          name: mainScreen,
          builder: (context, params) => const MainScreen(),
        ),
        FFRoute(
          name: settingsScreen,
          builder: (context, params) => const SettingsScreen(),
        ),
        FFRoute(
          name: accountSettingScreen,
          builder: (context, params) => const AccountSettingScreen(),
        ),
        FFRoute(
          name: newPasswordScreen,
          builder: (context, params) => const NewPasswordScreen(),
        ),
        FFRoute(
          name: dateOfBirthScreen,
          builder: (context, params) => const DateOfBirthScreen(),
        ),
        FFRoute(
          name: dateOfBirthMain,
          builder: (context, params) => const DateOfBirthMain(),
        ),
        FFRoute(
          name: bookDetailScreen,
          builder: (context, params) => const BookDetailsScreen(),
        ),
        FFRoute(
          name: tenTwelveScreen,
          builder: (context, params) => const TenTwelveScreen(),
        ),
        FFRoute(
          name: pastFortuneScreen,
          builder: (context, params) => const PastFortuneScreen(),
        ),
        FFRoute(
          name: pastDiary,
          builder: (context, params) => const PastDiary(),
        ),
        FFRoute(
          name: noticeScreen,
          builder: (context, params) => NoticeScreen(),
        ),
        FFRoute(
          name: customerService,
          builder: (context, params) => const CustomerService(),
        ),
        FFRoute(
          name: termAndConditions,
          builder: (context, params) => const TermsAndCondition(),
        ),
        FFRoute(
          name: selectPhotoFromDevice,
          builder: (context, params) => const SelectPhotoFromDevice(),
        ),
        FFRoute(
          name: selectPhotoFromInstagram,
          builder: (context, params) => const SelectPhotoFromInstagram(),
        ),
        FFRoute(
          name: autobiographyScreen,
          builder: (context, params) => const AutobiographyScreen(),
        ),
        FFRoute(
          name: animationScreen,
          builder: (context, params) => AnimationScreen(
            apiFuture: Future.value(true),
            screenName: '',
          ),
        ),
        FFRoute(
          name: privacyPolicyUpdateNoticeScreen,
          builder: (context, params) => const PrivacyPolicyUpdateNoticeScreen(),
        ),
        FFRoute(
          name: awaitingResponseScreen,
          builder: (context, params) => const AwaitingResponseScreen(),
        ),
        FFRoute(
          name: responseCompletedScreen,
          builder: (context, params) => const ResponseCompletedScreen(),
        ),
        FFRoute(
          name: oneToOneScreen,
          builder: (context, params) => const OneToOneScreen(),
        ),
        FFRoute(
          name: journalScreen,
          builder: (context, params) => const JournalScreen(),
        ),
        FFRoute(
          name: createJournal,
          builder: (context, params) => const CreateJournal(),
        ),
        FFRoute(
          name: profileSettingsScreen,
          builder: (context, params) => const ProfileSettingsScreen(),
        ),
        FFRoute(
          name: sajuDailyScreen,
          builder: (context, params) => const SajuDailyScreen(),
        ),
        FFRoute(
          name: instagramView,
          builder: (context, params) => const InstagramView(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries.where((e) => e.value != null).map((e) => MapEntry(e.key, e.value!)),
      );
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap => extra != null ? extra as Map<String, dynamic> : {};

  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);

  TransitionInfo get transitionInfo => TransitionInfo.appDefault();
  // TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
  //     ? extraMap[kTransitionInfoKey] as TransitionInfo
  //     : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty => state.allParams.isEmpty || (state.extraMap.length == 1 && state.extraMap.containsKey(kTransitionInfoKey));

  bool isAsyncParam(MapEntry<String, dynamic> param) => asyncParams.containsKey(param.key) && param.value is String;

  bool get hasFutures => state.allParams.entries.any(isAsyncParam);

  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value).onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String? path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path ?? '/$name',
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          log('Transition info: ${transitionInfo.hasTransition}');
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: child,
            transitionDuration: Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child),
          );
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.rightToLeft,
    this.duration = const Duration(microseconds: 400),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: true, transitionType: PageTransitionType.rightToLeft, duration: Duration(seconds: 1));
}
