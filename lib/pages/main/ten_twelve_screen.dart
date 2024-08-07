import 'package:Soulna/models/bookDetail/book_detail_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

// Same as book details screen with some changes

class TenTwelveScreen extends StatefulWidget {
  const TenTwelveScreen({super.key});

  @override
  State<TenTwelveScreen> createState() => _TenTwelveScreenState();
}

class _TenTwelveScreenState extends State<TenTwelveScreen> {
  List hashTag = ['#dreamy', '#Hyundai Outlet'];

  List<BookDetailModel> overAllList = [];
  List<BookDetailModel> thingsList = [];

  @override
  Widget build(BuildContext context) {
    thingsList = [
      BookDetailModel(
        title: LocaleKeys.green_color.tr(),
        backgroundColor: ThemeSetting.of(context).tertiary,
        image: AppAssets.one,
      ),
      BookDetailModel(
        title: LocaleKeys.french_cuisine.tr(),
        backgroundColor: ThemeSetting.of(context).lightGreen,
        image: AppAssets.two,
      ),
      BookDetailModel(
        title: LocaleKeys.relatives.tr(),
        backgroundColor: ThemeSetting.of(context).common1,
        image: AppAssets.three,
      ),
      BookDetailModel(
        title: '2,4',
        backgroundColor: ThemeSetting.of(context).extraGray,
        image: AppAssets.four,
      ),
      BookDetailModel(
        title: LocaleKeys.camera.tr(),
        backgroundColor: ThemeSetting.of(context).lightPurple,
        image: AppAssets.five,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.isLightTheme(context)
            ? ThemeSetting.of(context).redAccent
            : ThemeSetting.of(context).common2,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              HeaderWidget.headerBack(
                  context: context,
                  backgroundColor: ThemeSetting.of(context).redAccent),
              Image.asset(
                AppAssets.logo,
                height: 37,
                width: 37,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'October 7, 2024',
                  style: ThemeSetting.of(context)
                      .headlineMedium
                      .copyWith(color: ThemeSetting.of(context).primaryText),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  LocaleKeys.a_day_of_learning_and_mastering_new_things.tr(),
                  style: ThemeSetting.of(context).labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    height: 260,
                    width: 212,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: ThemeSetting.of(context).redBorder)),
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(AppAssets.bookImage),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: ThemeSetting.of(context).secondaryBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Flexible(
                            child: Image.asset(
                              AppAssets.dotLine,
                              color: ThemeSetting.of(context).primaryText,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 30,
                            width: 67,
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                AppAssets.result,
                              ),
                            )),
                            child: Center(
                              child: Text(
                                LocaleKeys.result.tr(),
                                style: ThemeSetting.of(context).captionMedium,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Image.asset(
                              AppAssets.dotLine,
                              color: ThemeSetting.of(context).primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomDividerWidget(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: ThemeSetting.of(context).common2,
                      child: Image.asset(
                        ThemeSetting.isLightTheme(context)
                            ? AppAssets.character
                            : AppAssets.characterDark,
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      LocaleKeys.outfit_that_brings_luck_and_love.tr(),
                      style: ThemeSetting.of(context).titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        LocaleKeys.outfit_that_brings_luck_and_love_des.tr(),
                        style: ThemeSetting.of(context).captionLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                        spacing: 5,
                        children: List.generate(
                          hashTag.length,
                          (index) {
                            return ButtonWidget.roundedButtonOrange(
                                context: context,
                                text: hashTag[index],
                                height: 30,
                                color: ThemeSetting.of(context).alternate,
                                textStyle: ThemeSetting.of(context)
                                    .captionLarge
                                    .copyWith(
                                        color:
                                            ThemeSetting.of(context).primary));
                          },
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomDividerWidget(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        LocaleKeys.things_that_bring_me_luck_today.tr(),
                        style: ThemeSetting.of(context).titleLarge),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          alignment: WrapAlignment.center,
                          children: List.generate(
                            thingsList.length,
                            (index) {
                              BookDetailModel detail = thingsList[index];
                              return Chip(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.all(2),
                                avatar: Image.asset(
                                  detail.image!,
                                  height: 30,
                                ),
                                backgroundColor: ThemeSetting.of(context)
                                    .secondaryBackground,
                                label: Text(
                                  detail.title,
                                  style: ThemeSetting.of(context).captionLarge,
                                ),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: ThemeSetting.of(context).common2,
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                              );
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      LocaleKeys.share_my_ai_diary_to_your_friend.tr(),
                      style: ThemeSetting.of(context).captionLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ButtonWidget.gradientButtonWithImage(
                          context: context,
                          text: LocaleKeys.share.tr(),
                          imageString: AppAssets.heart,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return showLinksDialog();
                              },
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showLinksDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: ThemeSetting.of(context).secondaryBackground,
          borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(15), left: Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.share_link.tr(),
            style: ThemeSetting.of(context).bodyMedium,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            LocaleKeys.share_instagram.tr(),
            style: ThemeSetting.of(context).bodyMedium,
          )
        ],
      ),
    );
  }
}