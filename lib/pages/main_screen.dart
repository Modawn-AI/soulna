import 'dart:async';

import 'package:Soulna/models/image_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<ImageModel> images = [];
  bool showBottomSheet = false;

  @override
  void initState() {
    Timer(
      Duration(seconds: 1),
      () => showBottomSheet = true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    images = [
      ImageModel(
          linear1: ThemeSetting.of(context).linearContainer1,
          linear2: ThemeSetting.of(context).linearContainer2,
          image: AppAssets.image1,
          text: LocaleKeys.check_your_fortune_for_today.tr()),
      ImageModel(
          linear1: ThemeSetting.of(context).linearContainer3,
          linear2: ThemeSetting.of(context).linearContainer4,
          image: AppAssets.image2,
          text: LocaleKeys.create_today_diary.tr()),
      ImageModel(
          linear1: ThemeSetting.of(context).linearContainer5,
          linear2: ThemeSetting.of(context).linearContainer6,
          image: AppAssets.image3,
          text: LocaleKeys.create_your_journal.tr()),
    ];

    return SafeArea(
        child: Scaffold(
      bottomSheet: bottomSheetWidget(context),
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      body: ListView(
        children: [
          HeaderWidget.headerWithLogoAndInstagram(context: context),
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
            child: CarouselSlider(
              items: images.map((e) {
                ImageModel image = e;
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 300,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [image.linear1, image.linear2],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        border: Border.all(
                            color: ThemeSetting.of(context).primaryText),
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 22),
                          margin:
                              const EdgeInsets.only(top: 8, left: 8, right: 8),
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
                            style: ThemeSetting.of(context).titleLarge.copyWith(
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
                                style: ThemeSetting.of(context).headlineLarge,
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
                    ));
              }).toList(),
              carouselController: CarouselController(),
              options: CarouselOptions(
                  viewportFraction: 0.8,
                  disableCenter: true,
                  reverse: false,
                  padEnds: true,
                  aspectRatio: 0.9,
                  height: 500,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
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
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(3),
                          ),
                          color: currentIndex == entry.key
                              ? ThemeSetting.of(context).primary
                              : ThemeSetting.of(context).common1)),
                );
              }).toList(),
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
    ));
  }

  bottomSheetWidget(BuildContext context) {
    // return  ListView(
    //   padding: EdgeInsets.only(top: 30, right: 25, left: 25),
    //   children: [
    //     Image.asset(
    //       AppAssets.logo,
    //       height: 37,
    //       width: 37,
    //     ),
    //     Padding(
    //       padding: EdgeInsets.only(left: 31, right: 30, top: 30),
    //       child: Text(
    //         AppString.title,
    //         textAlign: TextAlign.center,
    //         style: Theme.of(context).textTheme.labelLarge,
    //       ),
    //     ),
    //     SizedBox(
    //       height: 40,
    //     ),
    //     MainScreenWidget.rawWidget(text: AppString.bodyText1),
    //     Config.sizedBox(
    //       height: 10,
    //     ),
    //     MainScreenWidget.rawWidget(text: AppString.bodyText2),
    //     Config.sizedBox(
    //       height: 10,
    //     ),
    //     MainScreenWidget.rawWidget(text: AppString.bodyText3),
    //     Config.sizedBox(
    //       height: 31,
    //     ),
    //     Stack(
    //       children: [
    //         Container(
    //           margin: Config.kScreenPaddingOnly(top: 11),
    //           padding: Config.kScreenPaddingOnly(
    //               left: 15, right: 15, top: 20, bottom: 19),
    //           decoration: BoxDecoration(
    //               border: Border.all(color: AppColor.black),
    //               color: AppColor.primaryColor,
    //               borderRadius:
    //               BorderRadius.circular(Config.kBorderRadius12)),
    //           height: 80.h,
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 AppString.yearly,
    //                 style: Theme.of(context).textTheme.headlineMedium,
    //               ),
    //               Flexible(
    //                   flex: 5,
    //                   child: Column(
    //                     children: [
    //                       Text(
    //                         '\$39.99',
    //                         style: Theme.of(context)
    //                             .textTheme
    //                             .headlineMedium
    //                             ?.copyWith(fontWeight: AppFonts.semiBoldFont),
    //                       ),
    //                       Text(
    //                         '\$3.33/month',
    //                         style: Theme.of(context)
    //                             .textTheme
    //                             .displayMedium
    //                             ?.copyWith(color: AppColor.grey),
    //                       ),
    //                     ],
    //                   ))
    //             ],
    //           ),
    //         ),
    //         Config.sizedBox(height: 1.h),
    //         Container(
    //           height: 23.h,
    //           width: 61.w,
    //           margin: Config.kScreenPaddingOnly(left: 14),
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //               color: AppColor.black,
    //               borderRadius:
    //               BorderRadius.circular(Config.kBorderRadius25)),
    //           child: Text(
    //             'Save 72%',
    //             style: Theme.of(context).textTheme.displaySmall,
    //           ),
    //         ),
    //       ],
    //     ),
    //     Config.sizedBox(height: 10),
    //     Container(
    //       padding: Config.kScreenPaddingOnly(left: 15, right: 15),
    //       decoration: BoxDecoration(
    //           color: AppColor.white,
    //           borderRadius: BorderRadius.circular(Config.kBorderRadius12)),
    //       height: 70.h,
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             AppString.monthly,
    //             style: Theme.of(context).textTheme.headlineLarge,
    //           ),
    //           Text(
    //             '\$11.99/month',
    //             style: Theme.of(context).textTheme.headlineLarge,
    //           ),
    //         ],
    //       ),
    //     ),
    //     Config.sizedBox(height: 30),
    //     GestureDetector(
    //       onTap: () => Get.toNamed(NavigationScreen.settingsScreen),
    //       child: Container(
    //         height: 56.h,
    //         decoration: BoxDecoration(
    //             gradient: const LinearGradient(
    //                 colors: [AppColor.blackLinear1, AppColor.black]),
    //             borderRadius: BorderRadius.circular(Config.kBorderRadius50)),
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               AppString.start,
    //               style: Theme.of(context).textTheme.headlineLarge,
    //             ),
    //             Padding(
    //               padding: Config.kScreenPaddingOnly(left: 5),
    //               child: Image.asset(
    //                 AppImage.star,
    //                 height: 14,
    //                 width: 14,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     Config.sizedBox(height: 30),
    //     Center(
    //       child: Text(
    //         AppString.restorePurchases,
    //         style: Theme.of(context).textTheme.displayMedium,
    //       ),
    //     ),
    //     Config.sizedBox(height: 5),
    //     Center(
    //       child: Text(
    //         AppString.purchasesDes,
    //         style: Theme.of(context).textTheme.displaySmall,
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //     Config.sizedBox(height: 40)
    //   ],
    // );
  }
}