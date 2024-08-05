import 'dart:async';
import 'dart:io';

import 'package:Soulna/bottomsheet/create_dairy_bottomSheet.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:showcaseview/showcaseview.dart';

class SetTimelineBottomSheet {
  // static bool showHand = true;
  static setTimeLineBottomSheet(
      {required BuildContext context,
      required List<Map<String, dynamic>> selectedImages,
      required num Function() getTotalImages,
      bool? showHand}) {
    return showModalBottomSheet(
      elevation: 0,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          key: GlobalKey(),
          builder: (context, setState) {
            Timer(Duration(milliseconds: 2000), () {
              setState(() {
                showHand = false;
              },);
            });
            return GestureDetector(
                onTap: () {
                  setState(() {
                    showHand = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                      color: ThemeSetting.of(context).info,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Text(
                                  LocaleKeys.set_timeline.tr(),
                                  style: ThemeSetting.of(context)
                                      .titleLarge
                                      .copyWith(
                                          color:
                                              ThemeSetting.of(context).white),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ThemeSetting.of(context)
                                        .black1
                                        .withOpacity(0.2)),
                                child: Text(
                                  '  ${selectedImages.length}/10',
                                  style: ThemeSetting.of(context)
                                      .captionLarge
                                      .copyWith(
                                          color:
                                              ThemeSetting.of(context).white),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showHand = false;
                              });
                            },
                            child: SizedBox(
                              height: 60,
                              //width: 60,
                              child: ReorderableListView(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                scrollDirection: Axis.horizontal,
                                onReorder: (oldIndex, newIndex) {
                                  setState(() {
                                    if (newIndex > oldIndex) {
                                      newIndex -= 1;
                                    }
                                    final item =
                                        selectedImages.removeAt(oldIndex);
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
                                        margin: const EdgeInsets.only(
                                            right: 5, left: 2),
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ThemeSetting.of(context)
                                                  .white),
                                          color:
                                              ThemeSetting.of(context).common4,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image:
                                                FileImage(File(image['path'])),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Container(
                                          height: 22,
                                          width: 22,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                            color:
                                                ThemeSetting.of(context).white,
                                          ),
                                          child: Text(image['index'].toString(),
                                              style: ThemeSetting.of(context)
                                                  .bodySmall
                                                  .copyWith(
                                                      color: ThemeSetting.of(
                                                              context)
                                                          .black2)),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 50,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 18),
                          //   child: ButtonWidget.gradientButton(
                          //     context: context,
                          //     text:
                          //         '${LocaleKeys.select_a_total_of.tr()}${selectedImages.length} ${LocaleKeys.photos.tr()}',
                          //     color1: ThemeSetting.of(context).black1,
                          //     color2: ThemeSetting.of(context).black2,
                          //     onTap: () {
                          //       CreateDairyBottomSheet.createDairyBottomSheet(
                          //         context: context,
                          //         selectedImages: selectedImages,
                          //       );
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                      Positioned(
                          top: 190,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: ButtonWidget.gradientButton(
                                context: context,
                                text:
                                    '${LocaleKeys.select_a_total_of.tr()}${selectedImages.length} ${LocaleKeys.photos.tr()}',
                                color1: ThemeSetting.of(context).black1,
                                color2: ThemeSetting.of(context).black2,
                                onTap: () {
                                  CreateDairyBottomSheet.createDairyBottomSheet(
                                    context: context,
                                    selectedImages: selectedImages,
                                  );
                                },
                              ),
                            ),
                          )),
                      if (showHand == true)
                        Positioned(
                            top: 85,
                            left: 10,
                            child: Image.asset(
                              AppAssets.hand,
                              height: 110,
                              width: 300,
                            )),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
}