import 'dart:developer';
import 'dart:io';
import 'package:Soulna/bottomsheet/set_timeline_bottomSheet.dart';
import 'package:Soulna/models/photo_service_model.dart';
import 'package:Soulna/pages/main/instagram_view.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// This file defines the SelectPhotoScreen widget, which is used for selecting photos.
//Main screen ->  select photo screen -> set timeline -> create dairy
class SelectPhotoFromDevice extends StatefulWidget {
  const SelectPhotoFromDevice({super.key});

  @override
  State<SelectPhotoFromDevice> createState() => _SelectPhotoFromDeviceState();
}

class _SelectPhotoFromDeviceState extends State<SelectPhotoFromDevice> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<int> selectedIndices = [];
  final List<int> originalIndices = [];

  List<dynamic> mediaList = [];
  final PhotoServiceModel _photoService = PhotoServiceModel();

  Future<void> _loadPhotos() async {
    final List<XFile> newPhotos = await _photoService.fetchPhotos();
    setState(() {
      mediaList.addAll(newPhotos);
    });
  }

  void _removePhoto(int index) {
    setState(() {
      mediaList.removeAt(index);
      selectedIndices.remove(index);

      // for (int i = 0; i < mediaList.length; i++) {
      //  // mediaList[i] = i + 1;
      // }
    });
  }

  @override
  void initState() {
    _loadPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeSetting.of(context).secondaryBackground,
      statusBarIconBrightness: ThemeSetting.isLightTheme(context)
          ? Brightness.dark
          : Brightness.light,
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        key: scaffoldKey,
        appBar: HeaderWidget.headerWithTitle(
            context: context, title: LocaleKeys.select_photo.tr()),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              children: [
                Expanded(
                    child: ButtonWidget.roundedButtonOrange(
                        context: context,
                        width: MediaQuery.of(context).size.width,
                        text: LocaleKeys.set_timeline.tr(),
                        onTap: () async {
                          // SharedPreferencesManager
                          //     .saveMediaListToSharedPreferences(
                          //         key: SharedprefString.selectedMediaList,
                          //         mediaList: mediaList);
                          originalIndices.clear();
                          originalIndices.addAll(List.generate(
                              mediaList.length, (index) => index));

                          String? card =await  SharedPreferencesManager.getString(key: SharedprefString.cardNumber);

                         log('Card ${card.toString()}');
                          SetTimelineBottomSheet.setTimeLineBottomSheet(
                              context: context,
                              selectedImages: mediaList,
                              originalIndices: originalIndices,
                              showHand: true,
                              screen: int.parse(card.toString()) == 1 ? journalScreen : autobiographyScreen,
                              isNetwork: false);
                        })),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ButtonWidget.roundedButtonOrange(
                        context: context,
                        width: MediaQuery.of(context).size.width,
                        text: LocaleKeys.select_photo.tr(),
                        onTap: () {
                          _loadPhotos();
                        })),
              ],
            )),

        body: Column(
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
            Expanded(
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: mediaList.length,
                itemBuilder: (context, index) {
                  final photo = mediaList[index];
                  final isSelected = selectedIndices.contains(photo);

                  log('IsSelected ${isSelected}');
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        log('List ${mediaList.length}');
                        if (isSelected) {
                          selectedIndices.remove(index);
                        } else {
                          log('Enter $selectedIndices');
                          selectedIndices.add(index);
                          log('Enter ${selectedIndices.length}');
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: ThemeSetting.of(context).common4,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ThemeSetting.of(context).primaryText,
                                width: 1),
                            image: DecorationImage(
                              image: FileImage(File(photo.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: 5,
                        //   right: 5,
                        //   child: Container(
                        //     height: 24,
                        //     width: 24,
                        //     alignment: Alignment.center,
                        //     margin: const EdgeInsets.symmetric(
                        //         horizontal: 5, vertical: 5),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(5),
                        //         color: isSelected == false
                        //             ? ThemeSetting.of(context)
                        //                 .primaryText
                        //                 .withOpacity(0.5)
                        //             : ThemeSetting.of(context).primary),
                        //     child: Text(
                        //       isSelected == false
                        //           ? ''
                        //           : '${selectedIndices.indexOf(index) + 1}',
                        //       style: ThemeSetting.of(context)
                        //           .bodyMedium
                        //           .copyWith(
                        //               color: ThemeSetting.of(context).common0),
                        //     ),
                        //   ),
                        //   // child: GestureDetector(
                        //   //   // onTap: () => _removePhoto(index),
                        //   //   child: Container(
                        //   //     padding: const EdgeInsets.all(5),
                        //   //     decoration: BoxDecoration(
                        //   //       color: Colors.red.withOpacity(0.8),
                        //   //       shape: BoxShape.circle,
                        //   //     ),
                        //   //     child: const Icon(
                        //   //       Icons.close,
                        //   //       size: 18,
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //   ),
                        //   // ),
                        // ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () => _removePhoto(index),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}