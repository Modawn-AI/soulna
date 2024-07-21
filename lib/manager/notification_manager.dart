import 'dart:convert';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Soulna/utils/package_exporter.dart';

import '../firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (message.notification != null) {
    debugPrint("Notification Received!");
  }
}

//푸시 알림 메시지와 상호작용을 정의합니다.
Future<void> setupInteractedMessage() async {
  //앱이 종료된 상태에서 열릴 때 getInitialMessage 호출
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }
  //앱이 백그라운드 상태일 때, 푸시 알림을 탭할 때 RemoteMessage 처리
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

//FCM에서 전송한 data를 처리합니다. /message 페이지로 이동하면서 해당 데이터를 화면에 보여줍니다.
void _handleMessage(RemoteMessage message) {
  String payloadData = jsonEncode(message.data);
  debugPrint('Got a message in onMessageOpenedApp');
  if (message.notification != null) {
    //flutter_local_notifications 패키지 사용
    NotificationManager.showSimpleNotification(
      title: message.notification!.title!,
      body: message.notification!.body!,
      payload: payloadData,
    );
  }
}

class NotificationManager {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static String? _token;

  static get firebaseToken => _token;

  // 권한 요청 및 초기화
  static Future init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    if (Platform.isIOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        await _firebaseMessaging.subscribeToTopic("personID");
      } else {
        await Future<void>.delayed(
          const Duration(
            seconds: 3,
          ),
        );
        apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null) {
          await _firebaseMessaging.subscribeToTopic("personID");
        }
      }
    } else {
      await _firebaseMessaging.subscribeToTopic("personID");
    }

    // get the device fcm token
    _token = await _firebaseMessaging.getToken(); //토큰 얻기
    GetIt.I.get<UserInfoData>().updatePushToken(_token!);
    debugPrint("FirebaseMessaging token: $_token");

    //flutter_local_notifications 패키지 관련 초기화
    await localNotiInit();

    //백그라운드 알림 수신 리스너
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //포그라운드 알림 수신 리스너
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);
      debugPrint('Got a message in foreground');
      if (message.notification != null) {
        //flutter_local_notifications 패키지 사용
        NotificationManager.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData,
        );
        // final notificationProvider = Provider.of<ContentProvider>(navigatorKey.currentContext!, listen: false);
        // notificationProvider.updatePayload(payloadData);
      }
    });

    //메시지 상호작용 함수 호출
    await setupInteractedMessage();
  }

  static Future<bool> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      return true;
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
      return true;
    } else {
      if (Platform.isAndroid) {
        final int sdkInt = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
        if (sdkInt >= 33) {
          Permission.notification.request();
          return false;
        }
      }
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      debugPrint('User declined or has not accepted permission');
      return false;
    }
  }

  //flutter_local_notifications 패키지 관련 초기화
  static Future localNotiInit() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onNotificationTap, onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  //포그라운드로 알림을 받아서 알림을 탭했을 때 페이지 이동
  static void onNotificationTap(NotificationResponse notificationResponse) {
    // TODO: Implement navigation or desired action on notification tap
    // App.navigatorKey.currentState!.pushNamed('/message', arguments: notificationResponse);
    debugPrint('Notification tapped on: ${notificationResponse.payload}');
  }

  //포그라운드에서 푸시 알림을 전송받기 위한 패키지 푸시 알림 발송
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('pomo_timer_alarm_1', 'pomo_timer_alarm', channelDescription: '', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
  }
}
