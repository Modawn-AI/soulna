import 'package:Soulna/models/saju_daily_model.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:Soulna/auth/firebase_user_provider.dart';
import 'package:Soulna/manager/social_manager.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:Soulna/utils/custom_timeago_messages.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'bindings/master_bindings.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _prefs = await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations([
    // 화면 세로모드 고정
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  clearSecureStorageOnReinstall();
  setupLocator();

  //await dotenv.load(fileName: ".env");
  await _initializeFirebase();

  final socialManager = SocialManager.getInstance();
  timeago.setLocaleMessages("ko", KoCustomMessages());
  await EasyLocalization.ensureInitialized();
  ThemeSetting.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SocialManager>(create: (_) => socialManager),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        assetLoader: const CodegenLoader(),
        fallbackLocale: const Locale('en'),
        child: MyApp(socialManager: socialManager),
      ),
    ),
  );
}

Future<void> _initializeFirebase() async {
  try {
    // Check if Firebase app is already initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (e) {
    print('Firebase initialization error: $e');
  }
}

Future clearSecureStorageOnReinstall() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isRunBefore = preferences.getBool(kHasRunBeforeSPKey) ?? false;
  if (!isRunBefore) {
    SharedPreferencesManager.deleteAllKeys("app clearSecureStorageOnReinstall");
    preferences.setBool(kHasRunBeforeSPKey, true);
  }
}

void setupLocator() {
  if (!GetIt.I.isRegistered<AppInfoData>()) {
    GetIt.I.registerSingleton<AppInfoData>(AppInfoData());
  }
  if (!GetIt.I.isRegistered<UserInfoData>()) {
    GetIt.I.registerSingleton<UserInfoData>(UserInfoData());
  }
  if (!GetIt.I.isRegistered<SajuDailyService>()) {
    GetIt.I.registerSingleton<SajuDailyService>(SajuDailyService());
  }
}

String? _currentJwtToken;
String get currentJwtToken => _currentJwtToken ?? '';
final jwtTokenStream = FirebaseAuth.instance.idTokenChanges().map((user) async => _currentJwtToken = await user?.getIdToken()).asBroadcastStream();

class MyApp extends StatefulWidget {
  final SocialManager socialManager;

  const MyApp({super.key, required this.socialManager});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  String authStatus = 'Unknown';
  // ThemeMode _themeMode = ThemeSetting.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  late Stream<BaseAuthUser> userStream;

  ThemeMode _themeMode = _prefs?.getBool(kThemeModeKey) ?? false ? ThemeMode.dark : ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      _prefs?.setBool(kThemeModeKey, _themeMode == ThemeMode.dark);
    });
  }

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier, widget.socialManager);
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) => initPlugin());

    userStream = dearMeFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});

    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        ThemeSetting.saveThemeMode(mode);
      });

  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinksPlatform.instance.getInitialLink();
    if (initialLink != null) {
      // final Uri deepLink = initialLink.link;
    }
    FirebaseDynamicLinksPlatform.instance.onLink.listen((dynamicLinkData) {}).onError((error) {
      // Handle errors
    });
  }

  Future<void> initPlugin() async {
    final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
    setState(() => authStatus = '$status');
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      final TrackingStatus status = await AppTrackingTransparency.requestTrackingAuthorization();
      setState(() => authStatus = '$status');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    debugPrint("UUID: $uuid");
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp.router(
          title: 'Soulna',
          theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: ThemeSetting.of(context).secondaryBackground,
              appBarTheme: AppBarTheme(
                  elevation: 00, systemOverlayStyle: SystemUiOverlayStyle.dark, actionsIconTheme: IconThemeData(color: ThemeSetting.of(context).primaryText), iconTheme: IconThemeData(color: ThemeSetting.of(context).primaryText), backgroundColor: Colors.transparent, scrolledUnderElevation: 00)),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: ThemeSetting.of(context).secondaryBackground,
              appBarTheme: AppBarTheme(
                  elevation: 00, systemOverlayStyle: SystemUiOverlayStyle.dark, actionsIconTheme: IconThemeData(color: ThemeSetting.of(context).primaryText), iconTheme: IconThemeData(color: ThemeSetting.of(context).primaryText), backgroundColor: Colors.transparent, scrolledUnderElevation: 00)),
          themeMode: _themeMode,
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          key: navigatorKey,
          initialBinding: MasterBindings(),
          builder: (context, child) {
            AlertManager().initialize(context);
            // init 호출을 main.dart에서 한 번만 수행
            return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: BotToastInit()(context, child));
          },
        );
      },
    );
  }
}
