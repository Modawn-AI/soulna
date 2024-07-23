import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:Soulna/auth/firebase_user_provider.dart';
import 'package:Soulna/firebase_options.dart';
import 'package:Soulna/manager/social_manager.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:Soulna/utils/custom_timeago_messages.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    // 화면 세로모드 고정
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  clearSecureStorageOnReinstall();
  setupLocator();

  //await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        supportedLocales: const [Locale('ko'), Locale('en')],
        path: 'assets/translations',
        assetLoader: const CodegenLoader(),
        fallbackLocale: const Locale('en'),
        child: MyApp(socialManager: socialManager),
      ),
    ),
  );
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
  ThemeMode _themeMode = ThemeSetting.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  late Stream<BaseAuthUser> userStream;

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
        return MaterialApp.router(
          title: 'Soulna',
          theme: ThemeData(brightness: Brightness.light),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: _themeMode,
         // themeMode: ThemeMode.light,
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          key: navigatorKey,
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