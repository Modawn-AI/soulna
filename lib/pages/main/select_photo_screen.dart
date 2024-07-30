import 'package:Soulna/bottomsheet/set_timeline_bottomSheet.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the SelectPhotoScreen widget, which is used for selecting photos.
//Main screen ->  select photo screen -> set timeline -> create dairy
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
      SetTimelineBottomSheet.setTimeLineBottomSheet(context: context,selectedImages : selectedImages,getTotalImages : getTotalImages);
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




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        key: scaffoldKey,
        appBar: HeaderWidget.headerWithTitle(
            context: context, title: LocaleKeys.select_photo.tr()),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              color: ThemeSetting.of(context).common2,
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
                          style: ThemeSetting.of(context)
                              .headlineLarge
                              .copyWith(
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
                                        selectedImages
                                            .remove(item['images'][i]);
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
                                      color: item['images'][i]['selected'] ==
                                              false
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
      ),
    );
  }
}