import 'dart:developer';
import 'dart:io';

import 'package:Soulna/bottomsheet/set_timeline_bottomSheet.dart';
import 'package:Soulna/pages/main/instagram_view.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_snackbar_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_login/insta_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This file defines the SelectPhotoScreen widget, which is used for selecting photos.
//Main screen ->  select photo screen -> set timeline -> create dairy
class SelectPhotoFromInstagram extends StatefulWidget {
  const SelectPhotoFromInstagram({super.key});

  @override
  State<SelectPhotoFromInstagram> createState() => _SelectPhotoFromInstagramState();
}

class _SelectPhotoFromInstagramState extends State<SelectPhotoFromInstagram> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String token = '', userid = '', username = '', accountType = '';
  int mediaCount = -1;
  List<dynamic> mediaList = [];
  final List<dynamic> list = [];
  final List<int> selectedIndices = [];
  final List<int> originalIndices = [];

  getMedia() async {
    mediaList = await SharedPreferencesManager.getMediaListFromSharedPreferences(key: SharedprefString.mediaList);
    log('Media List ${mediaList.length}');
    setState(() {});
  }

  @override
  void initState() {
    getMedia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeSetting.of(context).secondaryBackground,
      statusBarIconBrightness: ThemeSetting.isLightTheme(context) ? Brightness.dark : Brightness.light,
    ));
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      key: scaffoldKey,
      appBar: HeaderWidget.headerWithTitle(context: context, title: LocaleKeys.select_photo.tr()),
      // ),
      body: SafeArea(
        child: Column(
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
                      LocaleKeys.it_automatically_creates_a_diary_through_the_Ai_algorithm.tr(),
                      style: ThemeSetting.of(context).captionMedium,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (mediaList.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: mediaList.length,
                  itemBuilder: (context, index) {
                    final media = mediaList[index];
                    final isSelected = selectedIndices.contains(index);

                    // log('Media ${media.toString()}');
                    return (media['media_type'] == 'IMAGE' || media['media_type'] == 'CAROUSEL_ALBUM')
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                log('List ${list.length}');
                                if (isSelected) {
                                  selectedIndices.remove(index);
                                  list.removeWhere((item) => item['media_url'] == media['media_url']);
                                } else {
                                  selectedIndices.add(index);
                                  list.add(media);
                                }
                              });
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ThemeSetting.of(context).common4,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: ThemeSetting.of(context).primaryText, width: 1),
                                    image: DecorationImage(
                                      image: NetworkImage(media['media_url']),
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   top: 5,
                                //   left: 5,
                                //   child: Container(
                                //     padding: const EdgeInsets.all(5),
                                //     decoration: BoxDecoration(
                                //       color: Colors.black.withOpacity(0.6),
                                //       shape: BoxShape.circle,
                                //     ),
                                //     child: Text(
                                //       '${index + 1}',
                                //       style: const TextStyle(color: Colors.white),
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: isSelected == false ? ThemeSetting.of(context).primaryText.withOpacity(0.5) : ThemeSetting.of(context).primary),
                                    child: Text(
                                      isSelected == false ? '' : '${selectedIndices.indexOf(index) + 1}',
                                      style: ThemeSetting.of(context).bodyMedium.copyWith(color: ThemeSetting.of(context).common0),
                                    ),
                                  ),
                                  // child: GestureDetector(
                                  //   // onTap: () => _removePhoto(index),
                                  //   child: Container(
                                  //     padding: const EdgeInsets.all(5),
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.red.withOpacity(0.8),
                                  //       shape: BoxShape.circle,
                                  //     ),
                                  //     child: const Icon(
                                  //       Icons.close,
                                  //       size: 18,
                                  //       color: Colors.white,
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  },
                ),
              )
            else
              ButtonWidget.borderButton(
                  context: context,
                  text: LocaleKeys.connect_with_instagram.tr(),
                  onTap: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return InstagramView(
                            instaAppId: '864298968952275',
                            instaAppSecret: '4cf5ddaeed3021a49f23c422043a7b7d',
                            onComplete: (_token, _userid, _username) {
                              WidgetsBinding.instance.addPostFrameCallback(
                                (timeStamp) async {
                                  token = _token;
                                  userid = _userid;
                                  username = _username;
                                  log('User Id ${userid}');
                                  log('Toekn ${token}');

                                  await Instaservices()
                                      .fetchUserMedia(
                                    userId: userid,
                                    accessToken: token,
                                  )
                                      .then((value) async {
                                    mediaList = value;
                                    setState(() {});
                                    await SharedPreferencesManager.saveMediaListToSharedPreferences(key: SharedprefString.mediaList, mediaList: mediaList);
                                    log('Media ${mediaList.length}');
                                    log('Media ${mediaList.first.toString()}');

                                    setState(() {});
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  }),
            if (mediaList.isNotEmpty)
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
                              if (selectedIndices.length > 10) {
                                CustomSnackBarWidget.showSnackBar(context: context, message: 'You can select only 10 images');
                                // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                //   content: Text('You can select only 10 images'),
                                // ));
                              } else {
                                //log('selectedIndices ${selectedIndices.length}');
                                originalIndices.addAll(List.generate(selectedIndices.length, (index) => index));

                                SetTimelineBottomSheet.setTimeLineBottomSheet(
                                  context: context,
                                  selectedImages: list,
                                  showHand: true,
                                  isNetwork: true,
                                  originalIndices: originalIndices,
                                  screen: autobiographyScreen,
                                  isInstagram: true,
                                );
                              }
                            }),
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
