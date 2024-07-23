// // ignore_for_file: use_build_context_synchronously
//
// import 'dart:async';
//
// import 'package:Soulna/models/user_model.dart';
// import 'package:Soulna/utils/theme_setting.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:Soulna/manager/notification_manager.dart';
// import 'package:Soulna/manager/social_manager.dart';
// import 'package:Soulna/utils/package_exporter.dart';
//
// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});
//
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   late SocialManager sm = SocialManager.getInstance();
//   late AppInfoModel appInfoModel;
//
//   String appVersion = '';
//
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
//     _controller.forward();
//     _controller.addListener(() {
//       setState(() {});
//     });
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _controller.stop();
//       }
//     });
//     NotificationManager.init();
//     _initLocalNotification();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     loginProcess();
//   }
//
//   Future<void> loginProcess() async {
//     NetworkManager().setLocale(context.locale);
//     await getAppVersionInfo();
//     checkLogin();
//   }
//
//   Future<void> checkLogin() async {
//     // SharedPreferencesManager.deleteAllKeys("SplashPage == checkLogin");
//     User? userInfo = await sm.tryAutoLogin();
//     if (userInfo == null) {
//       try {
//         // await setFirebaseToken();
//
//         if (mounted) {
//           context.goNamed('OnboardingPage');
//         }
//       } catch (e) {
//         if (mounted) {
//           SocialManager().deleteSharedData("SplashPage == checkLogin");
//           sm.loggedIn.value = true;
//           sm.loading.value = false;
//           sm.isTempLogin.value = true;
//         }
//       }
//     } else {
//       if (mounted) {
//         String? accessToken = await userInfo.getIdToken();
//         NetworkManager().saveTokens(accessToken!, accessToken);
//         dynamic response = await ApiCalls().getUserData();
//         Map<String, dynamic> userData = response as Map<String, dynamic>;
//         if (userData.containsKey("user_data")) {
//           Map<String, dynamic> user = userData["user_data"];
//           if (!user.containsKey("personal_info")) {
//             context.goNamed('UserInfoInputPage');
//           }
//           if (!user.containsKey("s3_voice_recording_url")) {
//             String onboardingText = await GetIt.I.get<UserInfoData>().onboardingData.onboardingLetter;
//             context.goNamed("RecordingVoicePage", queryParameters: {
//               "onboardingText": onboardingText,
//             });
//           }
//
//           if (!user.containsKey("notification_preferences")) {
//             String onboardingText = await GetIt.I.get<UserInfoData>().onboardingData.onboardingLetter;
//             context.goNamed("RecordingCompletePage", queryParameters: {
//               "onboardingText": onboardingText,
//               "voiceUrl": "",
//             });
//           } else {
//             UserModel userModel = UserModel.fromJson(user);
//             GetIt.I.get<UserInfoData>().updateUserInfo(userModel);
//             context.goNamed('MainPage');
//           }
//         } else {
//           context.goNamed('OnboardingPage');
//         }
//       }
//     }
//   }
//
//   Future<void> _checkLoginStatus() async {
//     final user = await sm.tryAutoLogin();
//     setState(() {
//       sm.loggedIn.value = user != null;
//     });
//   }
//
//   Future<bool> versionCheck() async {
//     dynamic appInfoResponse = await NetworkManager().postVersionRequest(appVersion);
//     appInfoModel = AppInfoModel.fromJson(appInfoResponse);
//
//     GetIt.instance.get<AppInfoData>().updateAppInfo(appInfoModel);
//
//     return appInfoModel.isUpdate;
//   }
//
//   Future<void> getAppVersionInfo() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     setState(() {
//       appVersion = packageInfo.version;
//       kAppVersion = appVersion;
//     });
//   }
//
//   Future<void> _initLocalNotification() async {
//     FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();
//     AndroidInitializationSettings initSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
//     DarwinInitializationSettings initSettingsIOS = const DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );
//     InitializationSettings initSettings = InitializationSettings(
//       android: initSettingsAndroid,
//       iOS: initSettingsIOS,
//     );
//     await localNotification.initialize(initSettings);
//   }
//
//   Future<void> setFirebaseToken() async {
//     // bool isToken = await SharedPreferencesManager.hasStringData(key: kNotificationTokenSPKey);
//     {
//       // await ApiCalls().updateNotificationToken(NotificationManager.firebaseToken);
//       // debugPrint("11111111 _firebaseMessaging device token: ${NotificationManager.firebaseToken}");
//     }
//     // debugPrint("2222222 _firebaseMessaging device token: ${NotificationManager.firebaseToken}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: ThemeSetting.of(context).primary,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: ThemeSetting.of(context).primary,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(),
//                   Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       Image.asset(
//                         'assets/appicon/appicon.png',
//                         width: 128,
//                         fit: BoxFit.cover,
//                       ),
//                       // Lottie.asset(
//                       //   "assets/lottie/splash_animation.json",
//                       //   width: 220.w,
//                       //   repeat: false,
//                       //   frameRate: FrameRate.max,
//                       //   controller: _controller,
//                       // ),
//                     ],
//                   ),
//                   const Spacer(),
//                   Text("Dear Me", style: ThemeSetting.of(context).displayMedium),
//                   const SizedBox(height: 16.0),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }