import 'dart:io';

import 'package:Soulna/bottomsheet/set_timeline_bottomSheet.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final PhotoService _photoService = PhotoService();
  final List<Map<String, dynamic>> _selectedPhotos = [];

  @override
  void initState() {
    super.initState();

    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final List<XFile> newPhotos = await _photoService.fetchPhotos();
    setState(() {
      for (var newPhoto in newPhotos) {
        if (!_selectedPhotos.any((photo) => photo['path'] == newPhoto.path)) {
          _selectedPhotos.add({
            'path': newPhoto.path,
            'index': _selectedPhotos.length + 1
          });
        }
      }
    });
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
      for (int i = 0; i < _selectedPhotos.length; i++) {
        _selectedPhotos[i]['index'] = i + 1;
      }
    });
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeSetting.of(context).secondaryBackground,
      // statusBarBrightness: ThemeSetting.isLightTheme(context)
      //     ? Brightness.light
      //     : Brightness.dark,
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: _selectedPhotos.length,
                itemBuilder: (context, index) {
                  final photo = _selectedPhotos[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ThemeSetting.of(context).common4,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ThemeSetting.of(context).primaryText,
                              width: 1),
                          image: DecorationImage(
                            image: FileImage(File(photo['path'])),
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
                            '${photo['index']}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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
                  );
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonWidget.roundedButtonOrange(
                          context: context,
                          width: MediaQuery.of(context).size.width,
                          text: LocaleKeys.set_timeline.tr(),
                          onTap: () {
                            SetTimelineBottomSheet.setTimeLineBottomSheet(
                                context: context,
                                selectedImages: _selectedPhotos,
                                getTotalImages: getTotalImages);
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ButtonWidget.roundedButtonOrange(
                        context: context,
                        width: MediaQuery.of(context).size.width,
                        text: LocaleKeys.select_photo.tr(),
                        onTap: () => _loadPhotos(),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class PhotoService {
  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>> fetchPhotos() async {
    final List<XFile>? photos = await _picker.pickMultiImage();
    return photos ?? [];
  }

  Future<List<XFile>?> pickPhotos(List<XFile> selectedPhotos) async {
    final List<XFile>? photos = await _picker.pickMultiImage();
    if (photos != null) {
      for (var photo in photos) {
        if (!selectedPhotos
            .any((selectedPhoto) => selectedPhoto.path == photo.path)) {
          selectedPhotos.add(photo);
        }
      }
    }
    return selectedPhotos;
  }
}