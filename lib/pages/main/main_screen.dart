import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:Soulna/bottomsheet/subscription_bottomsheet.dart';
import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/manager/social_manager.dart';
import 'package:Soulna/models/auto_biography_model.dart';
import 'package:Soulna/models/image_model.dart';
import 'package:Soulna/models/saju_daily_model.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:Soulna/pages/drawer/drawer_screen.dart';
import 'package:Soulna/pages/main/animation_screen.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 이 파일은 애플리케이션의 메인 화면인 MainScreen 위젯을 정의합니다.

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int currentIndex = 0;
  int previousIndex = 0;

  List<ImageModel> images = [];
  List recommendedFortune = [];

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  late AnimationController _logoAniCon;
  late Animation<double> _logoAnimation;

  late UserInfoData userInfoData;
  bool isUserInfo = false;

  // 첫 로딩 시 유저 정보가 없을 경우를 대비한 변수
  UserInfoData? user;
  final authCon = Get.put(AuthController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final CarouselSliderController _controller = CarouselSliderController();

  bool isInstaConnected = false;

  final random = Random();

  // **추가된 부분: 세 번째 아이템에 사용할 랜덤 이미지 경로**
  late String randomImageForThirdItem;

  @override
  void initState() {
    super.initState();

    // **추가된 부분: 랜덤 이미지 초기화**
    randomImageForThirdItem = "assets/images/picture_${random.nextInt(8) + 1}.png";

    getSharedPrefData();
    if (SocialManager().isUserInfo.value) {
      isUserInfo = true;
      userInfoData = GetIt.I.get<UserInfoData>();
    }

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _logoAniCon = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _logoAnimation = Tween<double>(begin: 0, end: 0).animate(_logoAniCon);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Timer(
        const Duration(milliseconds: 400),
        () async {
          await _animationController.forward();
          if (!authCon.isPremium.value) {
            bool shouldShow = await shouldShowSubscription();
            if (shouldShow) {
              Subscription.subscriptionWidget(context: context);
            }
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _logoAniCon.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateUserData();
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateUserData();
  }

  void _updateUserData() {
    final newUser = GetIt.I.get<UserInfoData>();
    if (newUser.userModel != null) {
      setState(() {
        user = newUser;
        userInfoData = newUser;
        isUserInfo = true;
      });
    }
  }

  getSharedPrefData() async {
    final prefs = await SharedPreferences.getInstance();
    isInstaConnected = prefs.containsKey(kInstagramTokenSP);
  }

  Future<bool> shouldShowSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    final lastShown = prefs.getInt('lastSubscriptionShown') ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (now - lastShown >= 7 * 24 * 60 * 60 * 1000) {
      // 7일을 밀리초로 계산
      await prefs.setInt('lastSubscriptionShown', now);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    recommendedFortune = [
      {
        'title': LocaleKeys.fortune_from_the_heavens.tr(),
        'color': ThemeSetting.of(context).tertiary2,
      },
      {
        'title': LocaleKeys.fortune_from_the_heavens.tr(),
        'color': ThemeSetting.of(context).lightGreen,
      },
    ];

    List<String> myParts = user?.userModel?.tenTwelve?.picture?.split("_") ?? [];
    String myElementName = myParts.isNotEmpty ? myParts[2] : '';

    images = [
      ImageModel(
        linear1: Utils.getElementToColor(context, myElementName),
        linear2: ThemeSetting.of(context).black1,
        image: isUserInfo ? "$kCardResource3DUrl${userInfoData.userModel.tenTwelve.picture}" : AppAssets.image1,
        text: LocaleKeys.check_your_fortune_for_today.tr(),
        buttonText: LocaleKeys.daily_vibe_check.tr(),
        route: dateOfBirthMain,
      ),
      ImageModel(
        linear1: ThemeSetting.of(context).linearContainer3,
        linear2: ThemeSetting.of(context).linearContainer4,
        image: AppAssets.image2,
        text: LocaleKeys.create_today_journal.tr(),
        buttonText: LocaleKeys.create_text.tr(),
        route: selectPhotoFromDevice,
      ),
      ImageModel(
        linear1: ThemeSetting.of(context).linearContainer5,
        linear2: ThemeSetting.of(context).linearContainer6,
        // **변경된 부분: 랜덤 이미지를 사용**
        image: randomImageForThirdItem,
        text: LocaleKeys.create_your_autoBiography.tr(),
        buttonText: LocaleKeys.create_text.tr(),
        route: createAutoBiography,
      ),
    ];

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: ThemeSetting.of(context).secondaryBackground));
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      key: scaffoldKey,
      appBar: HeaderWidget.headerWithLogoAndInstagram(
        context: context,
        title: AnimatedBuilder(
          animation: _logoAniCon,
          builder: (context, child) {
            return Transform.rotate(
              angle: _logoAnimation.value * 2 * 3.141592653589793,
              child: child,
            );
          },
          child: Image.asset(
            AppAssets.logo,
            height: 38,
            width: 38,
          ),
        ),
        instagramLogin: isInstaConnected,
        actionOnTap: () async {
          // 동적 응답 처리 부분 주석 처리됨
        },
        leadingOnTap: () => scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: DrawerScreen.drawerWidget(
        context: context,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 32,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isUserInfo ? LocaleKeys.hey_name.tr(namedArgs: {"name": userInfoData.userModel!.name}) : LocaleKeys.hey_name.tr(namedArgs: {"name": 'jane doe'}),
                  style: ThemeSetting.of(context).labelLarge,
                ),
                Text(
                  LocaleKeys.hows_you_day_going.tr(),
                  style: ThemeSetting.of(context).labelLarge,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 39,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: ThemeSetting.of(context).tertiary1, width: 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: ThemeSetting.of(context).tertiary1, width: 1),
                        borderRadius: BorderRadius.circular(50),
                        color: ThemeSetting.of(context).tertiary1,
                      ),
                      child: Text(
                        Utils.getTodayMDYFormatted(),
                        style: ThemeSetting.of(context).bodyMedium.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: AnimatedBuilder(
                animation: _slideAnimation,
                builder: (context, child) {
                  return SlideTransition(
                    position: _slideAnimation,
                    child: child,
                  );
                },
                child: CarouselSlider(
                  items: images.asMap().entries.map(
                    (e) {
                      ImageModel image = e.value;
                      return GestureDetector(
                        onTap: () {
                          if (isUserInfo && e.key == 0) {
                            _callApiSajuDaily();
                          } else if (e.key == 2) {
                            _callApiAutoBiography();
                          } else {
                            debugPrint('Key ${e.key}');
                            UserInfoData userData = GetIt.I.get<UserInfoData>();
                            if (userData.userModel != null) {
                              if (userData.userModel!.tenTwelve != null && e.key == 0) {
                                _callApiSajuDaily();
                              } else {
                                SharedPreferencesManager.setString(key: SharedprefString.cardNumber, value: e.key.toString());
                                context.pushNamed(image.route);
                              }
                            } else {
                              SharedPreferencesManager.setString(key: SharedprefString.cardNumber, value: e.key.toString());
                              context.pushNamed(image.route);
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 00),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [image.linear1, image.linear2],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            border: Border.all(color: ThemeSetting.of(context).black2),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 20),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: ThemeSetting.of(context).common0, width: 1.5),
                                        left: BorderSide(color: ThemeSetting.of(context).common0, width: 1.5),
                                        top: BorderSide(color: ThemeSetting.of(context).common0, width: 1.5),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                  // **변경된 부분: 세 번째 아이템에만 라운드 적용 및 랜덤 이미지 사용**
                                  if (e.key == 2) // 세 번째 아이템일 경우
                                    Positioned.fill(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 22),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20), // 라운드 코너 적용
                                          child: Image.asset(
                                            image.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  else if (isUserInfo && e.key == 0)
                                    Positioned.fill(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 22),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.asset(
                                            image.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 40),
                                      child: Image.asset(
                                        image.image,
                                        width: 165,
                                        height: 195,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  if (e.key != 0 || isUserInfo == false)
                                    Positioned(
                                      top: 16,
                                      left: 20,
                                      right: 20,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: ThemeSetting.of(context).black2.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          image.text,
                                          style: ThemeSetting.of(context).titleMedium.copyWith(
                                                color: ThemeSetting.of(context).white,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: ThemeSetting.of(context).black2,
                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          image.buttonText,
                                          style: ThemeSetting.of(context).headlineLarge.copyWith(color: ThemeSetting.of(context).common0),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset(
                                          AppAssets.start,
                                          height: 14,
                                          width: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                    viewportFraction: 0.8,
                    disableCenter: true,
                    enableInfiniteScroll: false,
                    reverse: false,
                    padEnds: true,
                    aspectRatio: 0.7,
                    height: 500,
                    onPageChanged: (index, reason) {
                      setState(() {
                        if (index > previousIndex) {
                          _logoAnimation = Tween<double>(begin: _logoAnimation.value, end: _logoAnimation.value + 0.25).animate(_logoAniCon);
                        } else {
                          _logoAnimation = Tween<double>(begin: _logoAnimation.value, end: _logoAnimation.value - 0.25).animate(_logoAniCon);
                        }
                        _logoAniCon.forward(from: 0);
                        previousIndex = index;

                        currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AnimatedBuilder(
                animation: _slideAnimation,
                builder: (context, child) {
                  return SlideTransition(
                    position: _slideAnimation,
                    child: child,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.asMap().entries.map((entry) {
                    return GestureDetector(
                      // onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 90,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(3),
                          ),
                          color: currentIndex == entry.key ? ThemeSetting.of(context).primary : ThemeSetting.of(context).common1,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomDividerWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 10),
              child: Text(
                LocaleKeys.recommended_fortune.tr(),
                style: ThemeSetting.of(context).captionLarge,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 18),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: recommendedFortune.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(right: 17),
                    decoration: BoxDecoration(
                      color: recommendedFortune[index]['color'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text(
                                  LocaleKeys.fortune_from_the_heavens.tr(),
                                  style: ThemeSetting.of(context).bodyMedium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ThemeSetting.of(context).black1,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Flexible(
                                child: Row(
                                  children: [
                                    Text(
                                      LocaleKeys.check_text.tr(),
                                      style: ThemeSetting.of(context).captionLarge.copyWith(color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Image.asset(AppAssets.next, height: 14, width: 14, color: Colors.black),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAssets.star,
                              height: 20,
                              width: 20,
                            ),
                            Image.asset(
                              AppAssets.character,
                              height: 52,
                              width: 57,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  String generateUserJson() {
    Map<String, dynamic> userMap = {
      "name": userInfoData.userModel.name,
      "birthdate": userInfoData.userModel.birthdate,
      "time_of_birth": userInfoData.userModel.timeOfBirth,
      "gender": userInfoData.userModel.gender,
      "language": userInfoData.userModel.language,
    };

    return jsonEncode(userMap);
  }

  Future<void> _callApiSajuDaily() async {
    final apiCallFuture = _getSajuDailyApiCall();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimationScreen(
          apiFuture: apiCallFuture,
          onApiComplete: (bool result) {
            if (result) {
              context.pushReplacementNamed(sajuDailyScreen);
            }
          },
          useLottieAnimation: true,
        ),
      ),
    );
  }

  Future<bool> _getSajuDailyApiCall() async {
    try {
      dynamic response = await ApiCalls().sajuDailyCall();
      if (response == null) {
        throw Exception('API 호출 실패');
      }
      if (response['status'] == 'success') {
        SajuDailyModel model = SajuDailyModel.fromJson(response['daily']);
        GetIt.I.get<SajuDailyService>().setSajuDailyInfo(model);
      } else {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _callApiAutoBiography() async {
    final apiCallFuture = _getAutoBiographyApiCall();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimationScreen(
          apiFuture: apiCallFuture,
          onApiComplete: (bool result) {
            if (result) {
              context.pushReplacementNamed(autobiographyScreen);
            } else {
              context.pushReplacementNamed(createAutoBiography);
            }
          },
          useLottieAnimation: false,
        ),
      ),
    );
  }

  Future<bool> _getAutoBiographyApiCall() async {
    try {
      dynamic response = await ApiCalls().getAutoBiographyData();
      if (response == null) {
        throw Exception('API 호출 실패');
      }
      if (response['autobiography']['2024-08-11'] != null) {
        AutoBiographyModelModel model = AutoBiographyModelModel.fromJson(response['autobiography']['2024-08-11']);
        GetIt.I.get<AutoBiographyService>().updateAutoBiography(model);
      } else {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
