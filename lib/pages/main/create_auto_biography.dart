import 'package:Soulna/pages/main/animation_screen.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

// This file defines the CreateJournal widget, which is used for creating a AutoBiography.
//MainScreen -> CreateAutoBiography
class CreateAutoBiography extends StatefulWidget {
  const CreateAutoBiography({super.key});

  @override
  State<CreateAutoBiography> createState() => _CreateAutoBiographyState();
}

class _CreateAutoBiographyState extends State<CreateAutoBiography> {
  String selectedValue = '';
  // bool? isInstagramSelected = false;

  List list = [];
  getSelectedImage() async {
    // isMyAlbumSelected = await SharedPreferencesManager.getBool(
    //     key: SharedprefString.isMyAlbumSelected);
    list = await SharedPreferencesManager.getMediaListFromSharedPreferences(key: SharedprefString.selectedMediaList);
    setState(() {});
  }

  @override
  void initState() {
    getSelectedImage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: ThemeSetting.of(context).secondaryBackground));

    getSelectedImage();
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ButtonWidget.roundedButtonOrange(
          context: context,
          height: 50.h,
          width: double.infinity,
          text: "${LocaleKeys.create_my_own_journal.tr()} 💫",
          textStyle: ThemeSetting.of(context).captionMedium.copyWith(
                color: ThemeSetting.of(context).white,
                fontSize: 16.sp,
              ),
          onTap: () async {
            if (selectedValue == 'Instagram' || selectedValue == 'Album') {
              // SharedPreferencesManager.setString(
              //     key: SharedprefString.animationScreen,
              //     value: journalScreen);

              // final apiCallFuture = _mockApiCall(selectedImages);

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimationScreen(
                    apiFuture: Future.value(false),
                    onApiComplete: (bool result) {
                      if (result) {
                        context.pushReplacementNamed(animationScreen);
                      }
                    },
                    useLottieAnimation: false,
                  ),
                ),
              );
            }
          },
        ),
      ),
      appBar: HeaderWidget.headerBack(context: context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.how_do_you_want_it_to_be_made.tr(),
                style: ThemeSetting.of(context).labelSmall,
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AppAssets.logo, width: 20.w, height: 20.h),
                  SizedBox(width: 10.w),
                  Text(
                    LocaleKeys.it_automatically_creates_a_journal_through_the_Ai_algorithm.tr(),
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                          color: ThemeSetting.of(context).primaryText,
                          fontSize: 12.sp,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              Row(
                children: [
                  containerWidget(
                      image: AppAssets.album,
                      title: LocaleKeys.my_album.tr(),
                      description: LocaleKeys.choose_a_photo_to_create_your_own_journal.tr(),
                      isAlbum: true,
                      showBorder: selectedValue == 'Album',
                      onTap: () {
                        setState(() {
                          selectedValue = 'Album';
                          // SharedPreferencesManager.setBool(
                          //     key: SharedprefString.isMyAlbumSelected,
                          //     value: isMyAlbumSelected ?? false);
                          context.pushNamed(selectPhotoFromDevice);
                        });
                      }),
                  const SizedBox(
                    width: 11,
                  ),
                  containerWidget(
                      image: AppAssets.instagram,
                      title: LocaleKeys.instagram.tr(),
                      description: LocaleKeys.link_instagram_to_import_and_create_data.tr(),
                      isAlbum: false,
                      showBorder: selectedValue == 'Instagram' ? true : false,
                      onTap: () {
                        setState(() {
                          selectedValue = 'Instagram';
                          context.pushNamed(selectPhotoFromInstagram);
                        });
                      }),
                ],
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              //   height: 153,
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: isMyAlbumSelected
              //           ? ThemeSetting.of(context).black2
              //           : ThemeSetting.of(context).tertiary,
              //       width: 1,
              //     ),
              //     borderRadius: BorderRadius.circular(10.r),
              //     color: ThemeSetting.of(context).tertiary,
              //   ),
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: albumList.length,
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             isMyAlbumSelected = !isMyAlbumSelected;
              //             isInstagramSelected = false;
              //           });
              //         },
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Image.asset(AppAssets.album,
              //                     width: 24.w, height: 24.h, fit: BoxFit.fill),
              //                 // const Spacer(),
              //                 if (isMyAlbumSelected)
              //                   Image.asset(AppAssets.check,
              //                       width: 14.w, height: 14.h),
              //               ],
              //             ),
              //             // const Spacer(),
              //             Text(
              //               LocaleKeys.my_album.tr(),
              //               style: ThemeSetting.of(context).labelMedium.copyWith(
              //                     color: ThemeSetting.of(context).primaryText,
              //                     fontSize: 18.sp,
              //                   ),
              //             ),
              //             SizedBox(height: 10.h),
              //             Text(
              //               LocaleKeys.choose_a_photo_to_create_your_own_journal
              //                   .tr(),
              //               style:
              //                   ThemeSetting.of(context).captionMedium.copyWith(
              //                         color: ThemeSetting.of(context).primaryText,
              //                         fontSize: 12.sp,
              //                       ),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             isMyAlbumSelected = !isMyAlbumSelected;
              //             isInstagramSelected = false;
              //           });
              //         },
              //         child: Container(
              //           padding: EdgeInsets.symmetric(
              //               horizontal: 10.w, vertical: 10.h),
              //           height: 150.h,
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               color: isMyAlbumSelected
              //                   ? ThemeSetting.of(context).black2
              //                   : ThemeSetting.of(context).tertiary,
              //               width: 1,
              //             ),
              //             borderRadius: BorderRadius.circular(10.r),
              //             color: ThemeSetting.of(context).tertiary,
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Image.asset(AppAssets.album,
              //                       width: 24.w, height: 24.h, fit: BoxFit.fill),
              //                   const Spacer(),
              //                   if (isMyAlbumSelected)
              //                     Image.asset(AppAssets.check,
              //                         width: 14.w, height: 14.h),
              //                 ],
              //               ),
              //               const Spacer(),
              //               Text(
              //                 LocaleKeys.my_album.tr(),
              //                 style: ThemeSetting.of(context)
              //                     .labelMedium
              //                     .copyWith(
              //                       color: ThemeSetting.of(context).primaryText,
              //                       fontSize: 18.sp,
              //                     ),
              //               ),
              //               SizedBox(height: 10.h),
              //               Text(
              //                 LocaleKeys.choose_a_photo_to_create_your_own_journal
              //                     .tr(),
              //                 style: ThemeSetting.of(context)
              //                     .captionMedium
              //                     .copyWith(
              //                       color: ThemeSetting.of(context).primaryText,
              //                       fontSize: 12.sp,
              //                     ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 10.w),
              //     Expanded(
              //       child: GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             isInstagramSelected = !isInstagramSelected;
              //             isMyAlbumSelected = false;
              //           });
              //         },
              //         child: Container(
              //           padding: EdgeInsets.symmetric(
              //               horizontal: 10.w, vertical: 10.h),
              //           height: 150.h,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10.r),
              //             border: Border.all(
              //               color: isInstagramSelected
              //                   ? ThemeSetting.of(context).black2
              //                   : ThemeSetting.of(context).tertiary3,
              //               width: 1,
              //             ),
              //             color: ThemeSetting.of(context).tertiary3,
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Image.asset(AppAssets.instagram,
              //                       width: 24.w, height: 24.h, fit: BoxFit.fill),
              //                   const Spacer(),
              //                   if (isInstagramSelected)
              //                     Image.asset(AppAssets.check,
              //                         width: 14.w, height: 14.h),
              //                 ],
              //               ),
              //               const Spacer(),
              //               Text(
              //                 LocaleKeys.instagram.tr(),
              //                 style: ThemeSetting.of(context)
              //                     .labelMedium
              //                     .copyWith(
              //                       color: ThemeSetting.of(context).primaryText,
              //                       fontSize: 18.sp,
              //                     ),
              //               ),
              //               SizedBox(height: 10.h),
              //               Text(
              //                 LocaleKeys.link_instagram_to_import_and_create_data
              //                     .tr(),
              //                 style: ThemeSetting.of(context)
              //                     .captionMedium
              //                     .copyWith(
              //                       color: ThemeSetting.of(context).primaryText,
              //                       fontSize: 12.sp,
              //                     ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 30),
              selectedValue == 'Album'
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${list.length} ${LocaleKeys.pictures.tr()}",
                              style: ThemeSetting.of(context).bodyMedium,
                            ),
                            SizedBox(width: 10.w),
                            ButtonWidget.squareButtonOrange(
                              context: context,
                              height: 24.h,
                              text: LocaleKeys.edit.tr(),
                              buttonBackgroundColor: ThemeSetting.of(context).primaryText,
                              textStyle: ThemeSetting.of(context).captionMedium.copyWith(
                                    color: ThemeSetting.of(context).secondaryBackground,
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 60.h,
                          child: ListView.builder(
                              itemCount: list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 8.w),
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Image.network(list[index]['media_url'], width: 60.w, height: 60.h),
                                );
                              }),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  containerWidget({
    required String image,
    required String title,
    required String description,
    bool? isAlbum,
    bool? showBorder,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          //height: 153,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              color: showBorder == true
                  ? ThemeSetting.isLightTheme(context)
                      ? ThemeSetting.of(context).black2
                      : ThemeSetting.of(context).white
                  : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10.r),
            color: ThemeSetting.isLightTheme(context)
                ? isAlbum == true
                    ? ThemeSetting.of(context).tertiary
                    : ThemeSetting.of(context).tertiary3
                : ThemeSetting.of(context).common2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    image,
                    width: 30,
                    height: 30,
                    color: ThemeSetting.of(context).primaryText,
                  ),
                  if (showBorder == true)
                    Image.asset(
                      AppAssets.check,
                      height: 14,
                      width: 14,
                      color: ThemeSetting.of(context).primaryText,
                    )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                title,
                style: ThemeSetting.of(context).labelMedium.copyWith(
                      color: ThemeSetting.of(context).primaryText,
                      fontSize: 18.sp,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: ThemeSetting.of(context).captionMedium.copyWith(
                      color: ThemeSetting.of(context).primaryText,
                      fontSize: 12.sp,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
