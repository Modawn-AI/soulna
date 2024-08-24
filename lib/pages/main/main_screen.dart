import 'dart:async';
import 'dart:convert';
import 'dart:developer';

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

// This file defines the MainScreen widget, which is the main screen of the application.

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

  UserInfoData? user;
  final authCon = Get.put(AuthController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    super.initState();

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
        () {
          _animationController.forward().whenComplete(
                (authCon.isPremium.value == false)
                    ? () {
                        return Subscription.subscriptionWidget(context: context);
                      }
                    : () {},
              );
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
    user = GetIt.I.get<UserInfoData>();
  }

  @override
  Widget build(BuildContext context) {
    recommendedFortune = [
      {
        'title': LocaleKeys.natural_born_fortune_from_the_heavens.tr(),
        'color': ThemeSetting.of(context).tertiary2,
      },
      {
        'title': LocaleKeys.natural_born_fortune_from_the_heavens.tr(),
        'color': ThemeSetting.of(context).lightGreen,
      },
    ];

    List<String> myParts = user?.userModel?.tenTwelve?.picture?.split("_") ?? [];
    String myElementName = myParts.isNotEmpty ? myParts[2] : '';

    images = [
      ImageModel(
        linear1: Utils.getElementToColor(context, myElementName),
        linear2: ThemeSetting.of(context).black1,
        image: isUserInfo ? "assets/tarot/${userInfoData.userModel.tenTwelve.picture}" : AppAssets.image1,
        text: LocaleKeys.check_your_fortune_for_today.tr(),
        route: dateOfBirthMain,
      ),
      ImageModel(
        linear1: ThemeSetting.of(context).linearContainer3,
        linear2: ThemeSetting.of(context).linearContainer4,
        image: AppAssets.image2,
        text: LocaleKeys.create_today_diary.tr(),
        route: selectPhotoFromDevice,
      ),
      ImageModel(
        linear1: ThemeSetting.of(context).linearContainer5,
        linear2: ThemeSetting.of(context).linearContainer6,
        image: AppAssets.image3,
        text: LocaleKeys.create_your_autoBiography.tr(),
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
            height: 37,
            width: 37,
          ),
        ),
        actionOnTap: () async {
          // dynamic response = await ApiCalls().getUserData();

          // if(response['status'] == 'success') {
          //   SajuDailyInfo model = SajuDailyInfo.fromJson(response['daily']);
          //   print(model);
          // }
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
                  isUserInfo ? '${LocaleKeys.hey.tr()} ${userInfoData.userModel!.name}' : '${LocaleKeys.hey.tr()} jane doe',
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
            Container(
              height: 39,
              margin: const EdgeInsets.only(right: 148, left: 149),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: ThemeSetting.of(context).tertiary1, width: 1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: ThemeSetting.of(context).tertiary1, width: 1),
                  borderRadius: BorderRadius.circular(50),
                  color: ThemeSetting.of(context).tertiary1,
                ),
                child: Text(
                  Utils.getTodayMDFormatted(),
                  style: ThemeSetting.of(context).bodyMedium.copyWith(fontWeight: FontWeight.w600),
                ),
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
                  items: images.asMap().entries.map((e) {
                    ImageModel image = e.value;
                    return GestureDetector(
                      onTap: () {
                        if (isUserInfo && e.key == 0) {
                          _callApiSajuDaily();
                        } else if (e.key == 2) {
                          _callApiAutoBiography();
                        } else {
                          log('Key ${e.key}');
                          SharedPreferencesManager.setString(key: SharedprefString.cardNumber, value: e.key.toString());
                          context.pushNamed(image.route);
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
                                    padding: const EdgeInsets.only(top: 22),
                                    margin: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 20),
                                    decoration: BoxDecoration(
                                      border: Border(right: BorderSide(color: ThemeSetting.of(context).common0, width: 1.5), left: BorderSide(color: ThemeSetting.of(context).common0, width: 1.5), top: BorderSide(color: ThemeSetting.of(context).common0, width: 1.5)),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      image.text,
                                      style: ThemeSetting.of(context).titleLarge.copyWith(
                                            color: ThemeSetting.of(context).white,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  if (isUserInfo && e.key == 0)
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
                                          LocaleKeys.create.tr(),
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
                          )),
                    );
                  }).toList(),
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
                      }),
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
                      //onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                          width: 90,
                          height: 4,
                          // margin: const EdgeInsets .symmetric(
                          //     vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(3),
                              ),
                              color: currentIndex == entry.key ? ThemeSetting.of(context).primary : ThemeSetting.of(context).common1)),
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
                                  LocaleKeys.natural_born_fortune_from_the_heavens.tr(),
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
                                      LocaleKeys.check.tr(),
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
        throw Exception('API call failed');
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
        throw Exception('API call failed');
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
