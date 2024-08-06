import 'dart:developer';

import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/custom_hashtag_function.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// This file defines the JournalScreen widget, which is used for displaying journals.
//Main screen -> create journal -> select album screen  -> click on create journal
class AutobiographyScreen extends StatefulWidget {
  const AutobiographyScreen({super.key});

  @override
  State<AutobiographyScreen> createState() => _AutobiographyScreenState();
}

class _AutobiographyScreenState extends State<AutobiographyScreen> {
  bool showHeader = false;
  final ItemScrollController _itemScrollController = ItemScrollController();
  List<String> hashTag = ["dreamy", "Hyundai Outlet", "sea", "cake", "americano", "Gongneung Coffee"];

  List chapter = [
    "Ch. 1",
    "Ch. 2",
    "Ch. 3",
  ];

  int chapterIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: ThemeSetting.of(context).secondaryBackground));
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      body: showHeader == false ? journalList() : journalScroll(),
    );
  }

  journalList() {
    return ListView(
      children: [
        HeaderWidget.headerSettings(context: context, actionIcon: AppAssets.share, onTapOnMenu: () => context.pop(), onTap: () {}),
        const SizedBox(
          height: 20,
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 18,vertical: 12),
        //   decoration: BoxDecoration(color: ThemeSetting.of(context).common0),child: Row(children: [
        //   Image.asset(AppAssets.logo,height: 17,),
        //   SizedBox(width: 10,),
        //   Text(LocaleKeys.its_been_a_month_since_the_update.tr(), style: ThemeSetting.of(context).captionMedium,)
        // ],),),
        // const SizedBox(
        //   height: 50,
        // ),
        Center(
          child: Text(
            ' July 8, 2024 ~ July 30, 2024 ',
            style: ThemeSetting.of(context).headlineMedium.copyWith(color: ThemeSetting.of(context).primary),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            LocaleKeys.the_life_story_of_hopeful_stella.tr(),
            style: ThemeSetting.of(context).labelLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        showList(),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            LocaleKeys.my_journal_keyword.tr(),
            style: ThemeSetting.of(context).headlineLarge.copyWith(color: ThemeSetting.of(context).primaryText),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              hashTag.length,
              (index) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: ThemeSetting.of(context).alternate,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "#${hashTag[index]}",
                  style: ThemeSetting.of(context).bodyMedium.copyWith(color: ThemeSetting.of(context).secondary),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        CustomDividerWidget(),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            LocaleKeys.share_my_ai_diary_to_your_friend.tr(),
            style: ThemeSetting.of(context).captionLarge,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ButtonWidget.gradientButtonWithImage(context: context, text: LocaleKeys.share.tr(), imageString: AppAssets.heart),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 18),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: ButtonWidget.gradientButtonWithImage(
        //           context: context,
        //           text: LocaleKeys.share.tr(),
        //           imageString: AppAssets.start,
        //         ),
        //       ),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Expanded(
        //         flex: 2,
        //         child: ButtonWidget.gradientButtonWithImage(
        //             context: context,
        //             text: LocaleKeys.update.tr(),
        //             color1: ThemeSetting.of(context).container1,
        //             color2: ThemeSetting.of(context).container2),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  journalScroll() {
    return Column(
      children: [
        HeaderWidget.headerWithAction(context: context, title: LocaleKeys.the_life_story_of_hopeful_stella.tr(), showMoreIcon: false),
        const SizedBox(
          height: 10,
        ),
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          percent: (chapterIndex + 1) / chapter.length,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: ScrollablePositionedList.builder(
            shrinkWrap: true,
            //initialScrollIndex: chapterIndex,
            //itemScrollController: _itemScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: chapter.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    chapterIndex = index;
                  });
                  _itemScrollController.scrollTo(index: index, duration: const Duration(milliseconds: 400));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Chip(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(side: BorderSide(color: chapterIndex == index ? Colors.transparent : ThemeSetting.of(context).common0), borderRadius: BorderRadius.circular(50)),
                      color: WidgetStatePropertyAll(
                        chapterIndex == index ? ThemeSetting.of(context).primary : ThemeSetting.of(context).secondaryBackground,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text(
                        chapter[index].toString(),
                        style: ThemeSetting.of(context).headlineMedium.copyWith(
                            color: chapterIndex == index
                                ? ThemeSetting.isLightTheme(context)
                                    ? ThemeSetting.of(context).secondaryBackground
                                    : ThemeSetting.of(context).primaryText
                                : ThemeSetting.of(context).primaryText),
                      )),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: showList(),
        )
      ],
    );
  }

  showList() {
    return Container(
      child: ScrollablePositionedList.builder(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemScrollController: _itemScrollController,
        itemCount: chapter.length,
        initialScrollIndex: chapterIndex,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                chapterIndex = index;
                showHeader = !showHeader;
                _itemScrollController.scrollTo(index: chapterIndex, duration: const Duration(milliseconds: 400));
              });
            },
            child: Column(
              children: [
                if (index != 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.18),
                    child: Image.asset(
                      ThemeSetting.isLightTheme(context) ? AppAssets.character : AppAssets.characterDark,
                      width: 65,
                      height: 59,
                    ),
                  ),
                if (index != 0)
                  const SizedBox(
                    height: 30,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: index != 0 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: index != 0 ? MainAxisAlignment.center : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(AppAssets.star, width: 16, height: 16),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Ch.${index + 1}',
                                style: ThemeSetting.of(context).headlineMedium.copyWith(color: ThemeSetting.of(context).primary),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'The Beginning of the hope',
                            style: ThemeSetting.of(context).headlineMedium.copyWith(color: ThemeSetting.of(context).primary),
                          ),
                          if (index != 0)
                            const SizedBox(
                              height: 20,
                            ),
                        ],
                      ),
                    ),
                    if (index == 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 6.18),
                        child: Image.asset(
                          ThemeSetting.isLightTheme(context) ? AppAssets.character : AppAssets.characterDark,
                          width: 65,
                          height: 59,
                        ),
                      )
                  ],
                ),
                showImage(image: AppAssets.rectangle, index: index),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: CustomHashtagFunction.getStyledText(text: 'Today was a dreamy day. I started the day with dessert in the morning and filled my stomach, and from the afternoon I met with my friends and explored the Hyundai Outlet.', keywords: hashTag, context: context),
                ),
                const SizedBox(
                  height: 55,
                ),
                showImage(image: AppAssets.rectangle, index: index),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: CustomHashtagFunction.getStyledText(text: 'I went to Gangneung Gongneung Coffee where I filled my stomach hard. I ate brunch, cake, and americano here.', keywords: hashTag, context: context),
                ),
                const SizedBox(
                  height: 55,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  showImage({required String image, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          log('Index $index');

          showHeader = !showHeader;

          if (showHeader == true) {
            chapterIndex = index;
            _itemScrollController.scrollTo(index: index, duration: const Duration(milliseconds: 400));
          }
        });
      },
      child: Container(
        height: 230,
        decoration: BoxDecoration(
          color: ThemeSetting.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ThemeSetting.of(context).primaryText, width: 2),
        ),
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image))),
        ),
      ),
    );
  }
}
