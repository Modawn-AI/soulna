import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:Soulna/auth/firebase_user_provider.dart';
import 'package:Soulna/firebase_options.dart';
import 'package:Soulna/manager/social_manager.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:Soulna/pages/letter_list_page.dart';
import 'package:Soulna/pages/main_page.dart';
import 'package:Soulna/pages/profile_page.dart';
import 'package:Soulna/provider/base_auth_user_provider.dart';
import 'package:Soulna/utils/custom_timeago_messages.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/shared_preference.dart';
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

  await dotenv.load(fileName: ".env");
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
          title: 'Dear Me',
          theme: ThemeData(brightness: Brightness.light),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: _themeMode,
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

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page, this.initialId});

  final String? initialPage;
  final Widget? page;
  final String? initialId;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> with SingleTickerProviderStateMixin {
  String _currentPageName = 'MainPage';
  late Widget? _currentPage;
  String? id = '';
  int currentIndex = 1;

  late AnimationController? _controller;
  late Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
    id = widget.initialId;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeInOut),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      _controller!.forward().then((_) => _controller!.reverse());
      HapticFeedback.lightImpact();
    });
  }

  Widget _buildAnimatedIcon(String activePath, String inactivePath, int index) {
    bool isActive = currentIndex == index;
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Transform.scale(
          scale: isActive ? _animation!.value : 1.0,
          child: Image.asset(
            isActive ? activePath : inactivePath,
            width: isActive ? 24.0 : 20.0,
            height: isActive ? 24.0 : 20.0,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'LetterListPage': const LetterListPage(),
      'MainPage': const MainPage(),
      'ProfilePage': ProfilePage(initialId: id),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      extendBody: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 4.w),
        decoration: BoxDecoration(
          color: ThemeSetting.of(context).primaryBackground,
          border: Border(
            top: BorderSide(
              color: ThemeSetting.of(context).primary,
              width: 1.h,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: ThemeSetting.of(context).primaryBackground,
          elevation: 0,
          currentIndex: currentIndex,
          selectedFontSize: 10.sp,
          unselectedFontSize: 10.sp,
          unselectedLabelStyle: ThemeSetting.of(context).bodyLarge,
          selectedLabelStyle: ThemeSetting.of(context).bodyLarge,
          selectedItemColor: ThemeSetting.of(context).primaryText,
          unselectedItemColor: ThemeSetting.of(context).secondaryText,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _onItemTapped(index);
            _currentPage = null;
            _currentPageName = tabs.keys.toList()[index];
            id = null;
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 4.h),
                child: _buildAnimatedIcon(
                  'assets/icons/icon_play_active.png',
                  'assets/icons/icon_play_inactive.png',
                  0,
                ),
              ),
              label: "List",
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 4.h),
                child: _buildAnimatedIcon(
                  'assets/icons/icon_store_active.png',
                  'assets/icons/icon_store_inactive.png',
                  1,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 4.h),
                child: _buildAnimatedIcon(
                  'assets/icons/icon_my_active.png',
                  'assets/icons/icon_my_inactive.png',
                  2,
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
