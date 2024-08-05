import 'dart:async';

import 'package:Soulna/manager/social_manager.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:Soulna/utils/package_exporter.dart';

import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late SocialManager sm = SocialManager.getInstance();
  late AppInfoModel appInfoModel;

  String appVersion = '';

  late AnimationController _controller;

  @override
  void initState() {
    // Timer(
    //   const Duration(seconds: 3),
    //   () => context.goNamed(authScreen),
    // );

    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      }
    });
    // NotificationManager.init();
    // _initLocalNotification();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginProcess();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loginProcess() async {
    NetworkManager().setLocale(context.locale);
    await getAppVersionInfo();
    checkLogin();
  }

  Future<void> checkLogin() async {
    // SharedPreferencesManager.deleteAllKeys("SplashPage == checkLogin");
    // SocialManager().appleLogout(callback: () {});
    User? userInfo = await sm.tryAutoLogin();
    if (userInfo == null) {
      try {
        if (mounted) {
          context.goNamed(authScreen);
        }
      } catch (e) {
        if (mounted) {
          SocialManager().deleteSharedData("SplashPage == checkLogin");
          sm.loggedIn.value = true;
          sm.loading.value = false;
        }
      }
    } else {
      if (mounted) {
        String? accessToken = await userInfo.getIdToken();
        NetworkManager().saveTokens(accessToken!, accessToken);
        dynamic response = await ApiCalls().getUserData();
        if(response == null) {

        }
        if(response['status'] == 'success') {
          if(response['message'] == 'none') {
            // user info not found
            sm.isUserInfo.value = false;
          }
          else {
            sm.isUserInfo.value = true;
            UserModel model = UserModel.fromJson(response['data']);
            GetIt.I.get<UserInfoData>().updateUserInfo(model);
          }

        }

        context.goNamed(mainScreen);
      }
    }
  }

  Future<void> _checkLoginStatus() async {
    final user = await sm.tryAutoLogin();
    setState(() {
      sm.loggedIn.value = user != null;
    });
  }

  Future<bool> versionCheck() async {
    dynamic appInfoResponse = await NetworkManager().postVersionRequest(appVersion);
    appInfoModel = AppInfoModel.fromJson(appInfoResponse);

    GetIt.instance.get<AppInfoData>().updateAppInfo(appInfoModel);

    return appInfoModel.isUpdate;
  }

  Future<void> getAppVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
      kAppVersion = appVersion;
    });
  }

  Future<void> _initLocalNotification() async {
    FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initSettingsIOS = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );
    await localNotification.initialize(initSettings);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeSetting.of(context).tertiary,
    ));
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).tertiary,
      body: Center(
          child: Image.asset(
        AppAssets.logo,
        height: 90,
        width: 90,
      )),
    );
  }
}
