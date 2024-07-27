import 'dart:developer';

import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_checkbox_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectPhotoScreen extends StatefulWidget {
  const SelectPhotoScreen({super.key});

  @override
  State<SelectPhotoScreen> createState() => _SelectPhotoScreenState();
}

class _SelectPhotoScreenState extends State<SelectPhotoScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'date': DateTime.now(),
      'images': [
        {'path': AppAssets.rectangle1, 'selected': false},
        {'path': AppAssets.rectangle1, 'selected': false},
        {'path': AppAssets.rectangle1, 'selected': false},
        {'path': AppAssets.rectangle1, 'selected': false}
      ]
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'images': [
        {'path': AppAssets.rectangle1, 'selected': false},
        {'path': AppAssets.rectangle1, 'selected': false},
      ]
    },
    // Add more items here
  ];

  List<Map<String, dynamic>> selectedImages = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // //use this function to select 1,2,3,4,5 any order
  // int _getSelectedIndex(int itemIndex, int imageIndex) {
  //   int selectedIndex = 0;
  //   for (int i = 0; i < itemIndex; i++) {
  //     selectedIndex += (items[i]['images'] as List<Map<String, dynamic>>)
  //         .where((img) => img['selected'] as bool)
  //         .length;
  //   }
  //   selectedIndex += (items[itemIndex]['images'] as List<Map<String, dynamic>>)
  //       .sublist(0, imageIndex)
  //       .where((img) => img['selected'] as bool)
  //       .length;
  //   return selectedIndex + 1;
  // }

  void _updateSelectedIndexes(BuildContext context) {
    if (selectedImages.length > 1) {
      showModalBottomSheet(
        elevation: 0,
        context: context,
        builder: (context) {
          return bottomSheet();
        },
      );
    }
    for (int i = 0; i < selectedImages.length; i++) {
      selectedImages[i]['index'] = i + 1;
    }
  }

  num getTotalImages() {
    num totalImages = 0;
    for (var item in items) {
      totalImages += item['images'].length;
    }
    return totalImages;
  }

  Widget bottomSheetForCreateDiary() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
          color: ThemeSetting.of(context).info,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15))),
      child: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 18),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Image.asset(
                  AppAssets.delete,
                  width: 30,
                  height: 30,
                  color: ThemeSetting.of(context).secondaryBackground,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            LocaleKeys.would_you_like_to_make_a_diary_with_that_picture.tr(),
            textAlign: TextAlign.center,
            style: ThemeSetting.of(context)
                .labelLarge
                .copyWith(color: ThemeSetting.of(context).secondaryBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
              '${LocaleKeys.a_total_of.tr()} ${LocaleKeys.make_a_diary_for.tr()}July 8',
              textAlign: TextAlign.center,
              style: ThemeSetting.of(context).headlineLarge),
          const SizedBox(
            height: 50,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                squareWidget(image: AppAssets.rectangle),
                const SizedBox(
                  width: 8,
                ),
                squareWidget(image: AppAssets.rectangle, width: 150),
                const SizedBox(
                  width: 8,
                ),
                squareWidget(image: AppAssets.rectangle),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 100,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                ),
                squareWidget(image: AppAssets.rectangle),
                const SizedBox(
                  width: 8,
                ),
                squareWidget(image: AppAssets.rectangle, width: 150),
                const SizedBox(
                  width: 8,
                ),
                squareWidget(image: AppAssets.rectangle),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                squareWidget(image: AppAssets.rectangle),
                const SizedBox(
                  width: 8,
                ),
                squareWidget(image: AppAssets.rectangle, width: 150),
                const SizedBox(
                  width: 8,
                ),
                squareWidget(image: AppAssets.rectangle),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 100,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ButtonWidget.gradientButtonWithImage(
                context: context,
                text: LocaleKeys.create_a_diary.tr(),
                onTap: () {
                  SharedPreferencesManager.setString(
                      key: SharedprefString.animationScreen,
                      value: autobiographyScreen);
                  context.pushReplacementNamed(animationScreen);
                }),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget squareWidget({required String image, double? width}) {
    return Container(
      width: width ?? 80,
      height: 80,
      decoration: BoxDecoration(
          border: Border.all(color: ThemeSetting.of(context).black1),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image))),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          border:
              Border.all(color: ThemeSetting.of(context).secondaryBackground),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return StatefulBuilder(
      key: GlobalKey(),
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              color: ThemeSetting.of(context).info,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          child: ListView(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      LocaleKeys.set_timeline.tr(),
                      style: ThemeSetting.of(context).titleLarge.copyWith(
                          color: ThemeSetting.of(context).secondaryBackground),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:
                            ThemeSetting.of(context).black1.withOpacity(0.2)),
                    child: Text(
                      '  ${selectedImages.length}/${getTotalImages()}  ',
                      style: ThemeSetting.of(context).captionLarge.copyWith(
                          color: ThemeSetting.of(context).secondaryBackground),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 60,
                //width: 60,
                child: ReorderableListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final item = selectedImages.removeAt(oldIndex);
                      selectedImages.insert(newIndex, item);
                      //_updateSelectedIndexes(context);
                    });
                    setState(() {});
                  },
                  children: List.generate(
                    selectedImages.length,
                    (index) {
                      final image = selectedImages[index];
                      return Container(
                          height: 60,
                          width: 60,
                          key: ValueKey(image),
                          margin: const EdgeInsets.only(right: 5, left: 2),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ThemeSetting.of(context)
                                      .secondaryBackground),
                              color: ThemeSetting.of(context).common4,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                  image['path'],
                                ),
                                fit: BoxFit.cover,
                              )),
                          child: Container(
                            height: 22,
                            width: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color:
                                  ThemeSetting.of(context).secondaryBackground,
                            ),
                            child: Text(image['index'].toString(),
                                style: ThemeSetting.of(context).bodySmall),
                          ));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ButtonWidget.gradientButton(
                  context: context,
                  text:
                      '${LocaleKeys.select_a_total_of.tr()}${selectedImages.length} ${LocaleKeys.photos.tr()}',
                  color1: ThemeSetting.of(context).black1,
                  color2: ThemeSetting.of(context).black2,
                  onTap: () {
                    showModalBottomSheet(
                      elevation: 1,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return bottomSheetForCreateDiary();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithTitle(
          context: context, title: LocaleKeys.select_photo.tr()),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
            color: ThemeSetting.of(context).common0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Image.asset(
                    AppAssets.logo,
                    height: 17,
                    width: 17,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    LocaleKeys
                        .it_automatically_creates_a_diary_through_the_Ai_algorithm
                        .tr(),
                    style: ThemeSetting.of(context).captionMedium,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        DateFormat('MM.dd.yy').format(item['date']),
                        style: ThemeSetting.of(context).headlineLarge.copyWith(
                            color: ThemeSetting.of(context).primaryText),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children:
                          List<Widget>.generate(item['images'].length, (i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (item['images'][i]['selected']) {
                                selectedImages.remove(item['images'][i]);
                              } else {
                                selectedImages.add(item['images'][i]);
                              }
                              item['images'][i]['selected'] =
                                  !item['images'][i]['selected'];
                              _updateSelectedIndexes(context);
                            });
                          },
                          child: Container(
                              height: 115,
                              width: 115,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                  color: ThemeSetting.of(context).common4,
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      item['images'][i]['path'],
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (item['images'][i]['selected']) {
                                      selectedImages.remove(item['images'][i]);
                                    } else {
                                      selectedImages.add(item['images'][i]);
                                    }
                                    item['images'][i]['selected'] =
                                        !item['images'][i]['selected'];
                                    _updateSelectedIndexes(context);
                                  });
                                },
                                child: Container(
                                  height: 24,
                                  width: 24,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:
                                        item['images'][i]['selected'] == false
                                            ? ThemeSetting.of(context)
                                                .primaryText
                                                .withOpacity(0.5)
                                            : ThemeSetting.of(context).primary,
                                  ),
                                  child: Text(
                                    item['images'][i]['selected'] == false
                                        ? ''
                                        : '${item['images'][i]['index']}',
                                    style: ThemeSetting.of(context)
                                        .bodyMedium
                                        .copyWith(
                                            color: ThemeSetting.of(context)
                                                .common0),
                                  ),
                                ),
                              )),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}