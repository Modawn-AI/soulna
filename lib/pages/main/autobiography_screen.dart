import 'package:Soulna/bottomsheet/update_delete_diary_bottomSheet.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/custom_hashtag_function.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// This file defines the AutobiographyScreen widget, which is used for displaying autobiographies.
// MainScreen -> card 2 -> select photos -> create diary

class AutobiographyScreen extends StatefulWidget {
  const AutobiographyScreen({super.key});

  @override
  State<AutobiographyScreen> createState() => _AutobiographyScreenState();
}

class _AutobiographyScreenState extends State<AutobiographyScreen> {
  bool showHeader = false;
  int currentIndex = 0;
  final ItemScrollController _itemScrollController = ItemScrollController();

  List text = [
    "Today was a dreamy day. I started the day with dessert in the morning and filled my stomach, and from the afternoon I met with my friends and explored the Hyundai Outlet.",
    "I went to Gangneung Gongneung Coffee where I filled my stomach hard. I ate brunch, cake, and americano here.",
    "Afterwards, I took pictures at a dock with a view of the sea and took selfies with my friends. This will be an unforgettable memory.",
    "Today was a dreamy day. I started the day with dessert in the morning and filled my stomach, and from the afternoon I met with my friends and explored the Hyundai Outlet.",
    "Afterwards, I took pictures at a dock with a view of the sea and took selfies with my friends. This will be an unforgettable memory.",
    "I went to Gangneung Gongneung Coffee where I filled my stomach hard. I ate brunch, cake, and americano here.",
    "I went to Gangneung Gongneung Coffee where I filled my stomach hard. I ate brunch, cake, and americano here.",
    "I went to Gangneung Gongneung Coffee where I filled my stomach hard. I ate brunch, cake, and americano here.",
    "I went to Gangneung Gongneung Coffee where I filled my stomach hard. I ate brunch, cake, and americano here.",
    "I went to Gangneung Gongneung Coffee where I filled my stomach hard. I ate brunch, cake, and americano here.",
  ];

  List<String> hashTag = [
    "dreamy",
    "Hyundai Outlet",
    "sea",
    "cake",
    "americano",
    "Gongneung Coffee"
  ];


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:   ThemeSetting.isLightTheme(context)
          ? ThemeSetting.of(context).secondaryBackground
          : ThemeSetting.of(context).common2,
    ));
    return SafeArea(
      child: Scaffold(
          backgroundColor: ThemeSetting.isLightTheme(context)
              ? ThemeSetting.of(context).secondaryBackground
              : ThemeSetting.of(context).common2,
          body: showHeader == false
              ? autoBiographyList()
              : autoBiographyScroll()),
    );
  }

  autoBiographyList() {
    return ListView(
      children: [
        HeaderWidget.headerWithAction(
          context: context,
          showMoreIconOnTap: () {
            UpdateDeleteDiaryBottomSheet.updateDeleteDiaryBottomSheet(
                context: context);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 39,
          margin: const EdgeInsets.only(right: 148, left: 149),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border:
                Border.all(color: ThemeSetting.of(context).tertiary1, width: 1),
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
          height: 5,
        ),
        Text(
          'I went on an eating trip to Gangneung!',
          textAlign: TextAlign.center,
          style: ThemeSetting.of(context).labelMedium,
        ),
        const SizedBox(
          height: 40,
        ),
        carouselSlider(
          scrollPhysics: const NeverScrollableScrollPhysics(),
          onPageChanged: (p0, p1) {
            setState(() {
              showHeader = true;
            });
          },
        ),
        const SizedBox(
          height: 40,
        ),
        showDescriptionList(showKeyword: true),
      ],
    );
  }

  autoBiographyScroll() {
    return Column(
      children: [
        HeaderWidget.headerWithAction(
          context: context,
          title: 'July 8',
          showMoreIconOnTap: () {
            UpdateDeleteDiaryBottomSheet.updateDeleteDiaryBottomSheet(
                context: context);
          },
        ),
        const SizedBox(
          height: 40,
        ),
        carouselSlider(onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
            _itemScrollController.scrollTo(
                index: index, duration: const Duration(milliseconds: 400));
          });
        }),
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: showDescriptionList(showKeyword: false),
        ),
      ],
    );
  }

  showDescriptionList({required bool showKeyword}) {
    return Container(
      color: ThemeSetting.isLightTheme(context)
          ? ThemeSetting.of(context).common0.withOpacity(0.3)
          : ThemeSetting.of(context).tertiary,
      child: ScrollablePositionedList.builder(
        shrinkWrap: true,
        itemScrollController: _itemScrollController,
        itemCount: text.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            // height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  // padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ThemeSetting.of(context).primaryText,
                    ),
                    color: ThemeSetting.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text('${index + 1}',
                      style: ThemeSetting.of(context).bodySmall),
                ),
                const SizedBox(
                  height: 10,
                ),
                // RichText(
                //   text: TextSpan(
                //     children:
                //     text[index].split(' ').map((word) {
                //       if (word.startsWith('#')) {
                //         return TextSpan(
                //           text: '$word ',
                //           style: ThemeSetting.of(context).bodyLarge.copyWith(
                //             fontWeight: FontWeight.w500,
                //             color: Colors.blue, // Change this to your desired hashtag color
                //           ),
                //         );
                //       } else {
                //         return TextSpan(
                //           text: '$word ',
                //           style: ThemeSetting.of(context).bodyLarge.copyWith(
                //             fontWeight: FontWeight.w500,
                //             color: Colors.red, // Change this to your desired text color
                //           ),
                //         );
                //       }
                //     }).toList(),
                //   ),
                // ),
                RichText(
                  text: CustomHashtagFunction.getStyledText(
                      text: text[index], keywords: hashTag, context: context),
                ),

                if (currentIndex == 0 && index == text.length-1 )
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        LocaleKeys.today_keyword.tr(),
                        style: ThemeSetting.of(context).headlineLarge.copyWith(
                            color: ThemeSetting.of(context).primaryText),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          hashTag.length,
                          (index) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: ThemeSetting.of(context).alternate,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "#${hashTag[index]}",
                              style: ThemeSetting.of(context)
                                  .bodyMedium
                                  .copyWith(
                                      color:
                                          ThemeSetting.of(context).secondary),
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
                      ButtonWidget.gradientButtonWithImage(
                          context: context,
                          text: LocaleKeys.share.tr(),
                          imageString: AppAssets.heart),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  carouselSlider(
      {ScrollPhysics? scrollPhysics,
      dynamic Function(int, CarouselPageChangedReason)? onPageChanged}) {
    return SizedBox(
        height: 230,
        child: CarouselSlider.builder(
          itemCount: 10,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  showHeader = !showHeader;
                });
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    width: 310,
                    height: 230,
                    margin: const EdgeInsets.only(right: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: ThemeSetting.isLightTheme(context)
                              ? ThemeSetting.of(context).black1
                              : ThemeSetting.of(context).tertiary1),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AppAssets.rectangle))),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 25,
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      // padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ThemeSetting.of(context).black1,
                        ),
                        color: ThemeSetting.of(context).white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('${index + 1}',
                          style: ThemeSetting.of(context).bodySmall.copyWith(
                              color: ThemeSetting.of(context).black2)),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            viewportFraction: 0.9,
            disableCenter: true,
            enableInfiniteScroll: false,
            reverse: false,
            padEnds: true,
            aspectRatio: 0.9,
            height: 500,

            scrollPhysics:
                scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
            // onPageChanged: (index, reason) {
            //   setState(() {
            //     showHeader = true;
            //     currentIndex = index;
            //     _itemScrollController.scrollTo(
            //         index: index,
            //         duration: const Duration(milliseconds: 400));
            //   });
            // }
          ),
        ));
  }
}