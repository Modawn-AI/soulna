import 'dart:async';
import 'package:Soulna/models/image_model.dart';
import 'package:Soulna/pages/drawer/drawer_screen.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int currentIndex = 0;
  bool isPremium = true;
  int previousIndex = 0;
  List<ImageModel> images = [];
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  late AnimationController _logoAniCon;
  late Animation<double> _logoAnimation;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
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
            () {
              return showModalBottomSheet(
                elevation: 0,
                isScrollControlled: true,
                //isDismissible: false,
                backgroundColor:
                    ThemeSetting.of(context).primaryText.withOpacity(0.5),
                context: context,
                builder: (context) {
                  return bottomSheetWidget(context);
                },
              );
            },
          );
        },
      );
    });
  }

  void dispose() {
    _animationController.dispose();
    _logoAniCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    images = [
      ImageModel(
          linear1: ThemeSetting.of(context).linearContainer1,
          linear2: ThemeSetting.of(context).linearContainer2,
          image: AppAssets.image1,
          text: LocaleKeys.check_your_fortune_for_today.tr(),
          route: dateOfBirthMain),
      ImageModel(
          linear1: ThemeSetting.of(context).linearContainer3,
          linear2: ThemeSetting.of(context).linearContainer4,
          image: AppAssets.image2,
          text: LocaleKeys.create_today_diary.tr(),
          route: selectPhotoScreen),
      ImageModel(
          linear1: ThemeSetting.of(context).linearContainer5,
          linear2: ThemeSetting.of(context).linearContainer6,
          image: AppAssets.image3,
          text: LocaleKeys.create_your_journal.tr(),
          route: createJournal),
    ];

    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerScreen.drawerWidget(context: context),
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      body: ListView(
        children: [
          HeaderWidget.headerWithLogoAndInstagram(
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
              onTap: () => scaffoldKey.currentState?.openDrawer()),
          const SizedBox(
            height: 32,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${LocaleKeys.hey.tr()} Stella,',
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
              border: Border.all(
                  color: ThemeSetting.of(context).tertiary1, width: 1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ThemeSetting.of(context).tertiary1, width: 1),
                  borderRadius: BorderRadius.circular(50),
                  color: ThemeSetting.of(context).tertiary1),
              child: Text(
                'July 8',
                style: ThemeSetting.of(context)
                    .bodyMedium
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 350,
            width: 202,
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
                    onTap: () => context.pushNamed("${image.route}"),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [image.linear1, image.linear2],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          border: Border.all(
                              color: ThemeSetting.of(context).primaryText),
                          borderRadius: BorderRadius.circular(20),
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
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: ThemeSetting.of(context)
                                                  .secondaryBackground,
                                              width: 1.5),
                                          left: BorderSide(
                                              color: ThemeSetting.of(context)
                                                  .secondaryBackground,
                                              width: 1.5),
                                          top: BorderSide(
                                              color: ThemeSetting.of(context)
                                                  .secondaryBackground,
                                              width: 1.5)),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Text(
                                    image.text,
                                    style: ThemeSetting.of(context)
                                        .titleLarge
                                        .copyWith(
                                            color: ThemeSetting.of(context)
                                                .secondaryBackground),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                                    color: ThemeSetting.of(context).primaryText,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        LocaleKeys.create.tr(),
                                        style: ThemeSetting.of(context)
                                            .headlineLarge,
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
                           if(!isPremium ) Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ThemeSetting.of(context)
                                      .primaryText
                                      .withOpacity(0.8)),
                            ),
                            if(!isPremium ) Positioned(
                              top: 110,
                              child: Image.asset(
                                AppAssets.lock,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            if(!isPremium ) SizedBox(
                              height: 10,
                            ),
                            if(!isPremium )  Positioned(
                              top: 170,
                              child: Text(
                                LocaleKeys.to_unlock_please_subscribe.tr(),
                                textAlign: TextAlign.center,
                                style: ThemeSetting.of(context)
                                    .bodyMedium
                                    .copyWith(
                                        color: ThemeSetting.of(context)
                                            .secondaryBackground),
                              ),
                            )
                          ],
                        )),
                  );
                }).toList(),
                carouselController: CarouselController(),
                options: CarouselOptions(
                    viewportFraction: 0.8,
                    disableCenter: true,
                    enableInfiniteScroll: false,
                    scrollPhysics: isPremium == true
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    reverse: false,
                    padEnds: true,
                    aspectRatio: 0.7,
                    height: 500,
                    onPageChanged: (index, reason) {
                      setState(() {
                        if (index > previousIndex) {
                          _logoAnimation = Tween<double>(
                                  begin: _logoAnimation.value,
                                  end: _logoAnimation.value + 0.25)
                              .animate(_logoAniCon);
                        } else {
                          _logoAnimation = Tween<double>(
                                  begin: _logoAnimation.value,
                                  end: _logoAnimation.value - 0.25)
                              .animate(_logoAniCon);
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
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: child,
              );
            },
            child: SizedBox(
              width: 202,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  return GestureDetector(
                    //onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                        width: 85,
                        height: 4,
                        // margin: const EdgeInsets.symmetric(
                        //     vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(3),
                            ),
                            color: currentIndex == entry.key
                                ? ThemeSetting.of(context).primary
                                : ThemeSetting.of(context).common1)),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: ThemeSetting.of(context).common2,
            thickness: 3,
          ),
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
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 17),
            decoration: BoxDecoration(
                color: ThemeSetting.of(context).tertiary2,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.natural_born_fortune_from_the_heavens.tr(),
                      style: ThemeSetting.of(context)
                          .bodyMedium
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          LocaleKeys.check.tr(),
                          style: ThemeSetting.of(context).captionLarge,
                        ),
                        Image.asset(
                          AppAssets.next,
                          height: 14,
                          width: 14,
                        ),
                      ],
                    ),
                  ],
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
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  bottomSheetWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))],
        color: ThemeSetting.of(context).tertiary,
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 30, right: 25, left: 25),
        children: [
          Image.asset(
            AppAssets.logo,
            height: 37,
            width: 37,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 31, right: 30, top: 30),
            child: Text(
              LocaleKeys.enjoy_all_of_soluna_features_freely.tr(),
              textAlign: TextAlign.center,
              style: ThemeSetting.of(context).labelLarge,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          rawWidget(text: LocaleKeys.check_your_fortune_for_today_n.tr()),
          const SizedBox(
            height: 10,
          ),
          rawWidget(text: LocaleKeys.check_today_diary.tr()),
          const SizedBox(
            height: 10,
          ),
          rawWidget(text: LocaleKeys.check_your_Journal.tr()),
          const SizedBox(
            height: 31,
          ),
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 11),
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: ThemeSetting.of(context).primaryText),
                    color: ThemeSetting.of(context).primary,
                    borderRadius: BorderRadius.circular(12)),
                height: 80.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.yearly.tr(),
                        style: ThemeSetting.of(context).headlineLarge),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\$39.99',
                            style: ThemeSetting.of(context).headlineLarge),
                        Text(
                          '\$3.33/month',
                          style: ThemeSetting.of(context).captionLarge.copyWith(
                              color: ThemeSetting.of(context)
                                  .secondaryBackground
                                  .withOpacity(0.5)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                height: 23.h,
                width: 61.w,
                margin: const EdgeInsets.only(left: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ThemeSetting.of(context).primaryText,
                    borderRadius: BorderRadius.circular(25)),
                child: Text('Save 72%',
                    style: ThemeSetting.of(context).bodySmall.copyWith(
                          color: ThemeSetting.of(context).secondaryBackground,
                        )),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                color: ThemeSetting.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(12)),
            height: 70.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.monthly.tr(),
                  style: ThemeSetting.of(context)
                      .headlineLarge
                      .copyWith(color: ThemeSetting.of(context).primaryText),
                ),
                Text('\$11.99/month',
                    style: ThemeSetting.of(context)
                        .headlineLarge
                        .copyWith(color: ThemeSetting.of(context).primaryText)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ButtonWidget.gradientButtonWithImage(
              context: context,
              text: LocaleKeys.start.tr(),
              onTap: () {
                context.pop();
                // _animationController = AnimationController(
                //   duration: const Duration(milliseconds: 500),
                //   vsync: this,
                // );
                // _slideAnimation = Tween<Offset>(
                //   begin: const Offset(1, 0),
                //   end: Offset.zero,
                // ).animate(CurvedAnimation(
                //   parent: _animationController,
                //   curve: Curves.easeInOut,
                // ));

                // _animationController.forward();
              }),
          const SizedBox(height: 30),
          Center(
            child: Text(
              LocaleKeys.restore_purchases.tr(),
              style: ThemeSetting.of(context).captionMedium,
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              LocaleKeys.purchases_des.tr(),
              style: ThemeSetting.of(context).displaySmall.copyWith(
                  color: ThemeSetting.of(context).primaryText.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40)
        ],
      ),
    );
  }

  rawWidget({required String text}) {
    return Row(
      children: [
        Image.asset(
          AppAssets.check,
          width: 14,
          height: 14,
          color: ThemeSetting.of(context).primaryText,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: ThemeSetting.of(context).bodyMedium,
        ),
      ],
    );
  }
}