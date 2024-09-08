import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:Soulna/models/journal_model.dart';
import 'package:Soulna/pages/main/animation_screen.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CreateDairyBottomSheet {
  static createDairyBottomSheet({
    required BuildContext context,
    required List<dynamic> selectedImages,
    required bool isNetwork,
    required String screen,
    required bool isInstagram,
  }) {
    return showModalBottomSheet(
      elevation: 1,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        List displayImages = List.from(selectedImages);

        // log('Display Image ${(selectedImages.toString().contains('media_url'))}');
        while (displayImages.length < 10) {
          displayImages.add({'id': 0, "media_type": "IMAGE", "media_url": "assets/appicon/logo.png"});
        }
        // log('displayImages ${displayImages.first.toString().contains('media_type')}');
        // log('displayImages ${displayImages.last.toString().contains('media_type')}');
        return Container(
          // alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height * 0.88,
          decoration: BoxDecoration(
            color: ThemeSetting.of(context).info,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
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
                      color: ThemeSetting.of(context).white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.diary_select_picture.tr(),
                textAlign: TextAlign.center,
                style: ThemeSetting.of(context).labelLarge.copyWith(color: ThemeSetting.of(context).white),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                LocaleKeys.diary_total_select.tr(namedArgs: {'selectedImages': selectedImages.length.toString(), 'today': Utils.getTodayMDFormatted()}),
                textAlign: TextAlign.center,
                style: ThemeSetting.of(context).headlineLarge,
              ),
              const SizedBox(
                height: 50,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[0]['media_url']
                            : (displayImages[0].toString().contains('media_url'))
                                ? displayImages[0]['media_url']
                                : (displayImages[0] as XFile).path,
                        context: context,
                        isNetwork: isNetwork),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[1]['media_url']
                            : (displayImages[1].toString().contains('media_url'))
                                ? displayImages[1]['media_url']
                                : (displayImages[1] as XFile).path,
                        width: 150,
                        isNetwork: isNetwork,
                        context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[2]['media_url']
                            : (displayImages[2].toString().contains('media_url'))
                                ? displayImages[2]['media_url']
                                : (displayImages[2] as XFile).path,
                        isNetwork: isNetwork,
                        context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    const SizedBox(
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
                    const SizedBox(
                      width: 100,
                    ),
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[3]['media_url']
                            : (displayImages[3].toString().contains('media_url'))
                                ? displayImages[3]['media_url']
                                : (displayImages[3] as XFile).path,
                        isNetwork: isNetwork,
                        context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[4]['media_url']
                            : (displayImages[4].toString().contains('media_url'))
                                ? displayImages[4]['media_url']
                                : (displayImages[4] as XFile).path,
                        isNetwork: isNetwork,
                        width: 150,
                        context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[5]['media_url']
                            : (displayImages[5].toString().contains('media_url'))
                                ? displayImages[5]['media_url']
                                : (displayImages[5] as XFile).path,
                        isNetwork: isNetwork,
                        context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[6]['media_url']
                            : (displayImages[6].toString().contains('media_url'))
                                ? displayImages[6]['media_url']
                                : (displayImages[6] as XFile).path,
                        isNetwork: isNetwork,
                        width: 150,
                        context: context),
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
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[7]['media_url']
                            : (displayImages[7].toString().contains('media_url'))
                                ? displayImages[7]['media_url']
                                : (displayImages[7] as XFile).path,
                        isNetwork: isNetwork,
                        context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[8]['media_url']
                            : (displayImages[8].toString().contains('media_url'))
                                ? displayImages[8]['media_url']
                                : (displayImages[8] as XFile).path,
                        isNetwork: isNetwork,
                        width: 150,
                        context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[9]['media_url']
                            : (displayImages[9].toString().contains('media_url'))
                                ? displayImages[9]['media_url']
                                : (displayImages[9] as XFile).path,
                        isNetwork: isNetwork,
                        context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    const SizedBox(
                      width: 100,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: ButtonWidget.gradientButtonWithImage(
                    context: context,
                    text: LocaleKeys.diary_create.tr(),
                    onTap: () async {
                      final apiCallFuture = _mockApiCall(selectedImages, screen, isInstagram);

                      final result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimationScreen(
                            apiFuture: apiCallFuture,
                            useLottieAnimation: false,
                            onApiComplete: (bool result) {
                              Navigator.pop(context, result);
                            },
                          ),
                        ),
                      );

                      if (result == true) {
                        context.pushReplacementNamed(screen);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool> _mockApiCall(List<dynamic> selectedImages, String screenType, bool isInstagram) async {
    List<String> base64Images = [];
    Dio dio = Dio();

    try {
      for (var image in selectedImages) {
        try {
          Uint8List bytes;
          if (screenType == autobiographyScreen) {
            // autobiographyScreen일 때의 처리
            if (image is Map<String, dynamic> && image.containsKey('media_url')) {
              String imageUrl = image['media_url'];
              if (imageUrl.startsWith('http')) {
                // 네트워크 이미지 처리
                Response response = await dio.get(
                  imageUrl,
                  options: Options(responseType: ResponseType.bytes),
                );
                if (response.statusCode != 200) {
                  print("이미지 다운로드 실패: $imageUrl");
                  continue;
                }
                bytes = Uint8List.fromList(response.data);
              } else if (imageUrl.startsWith('assets')) {
                // 에셋 이미지 처리
                ByteData data = await rootBundle.load(imageUrl);
                bytes = data.buffer.asUint8List();
              } else {
                print("지원하지 않는 이미지 형식: $imageUrl");
                continue;
              }
            } else {
              print("잘못된 이미지 데이터 형식: $image");
              continue;
            }
          } else {
            // XFile 처리 (이전과 동일)
            XFile xFile = image;
            File file = File(xFile.path);
            if (!await file.exists()) {
              print("파일이 존재하지 않습니다: ${xFile.path}");
              continue;
            }
            bytes = await file.readAsBytes();
          }

          String base64Image = base64Encode(bytes);
          base64Images.add(base64Image);
        } catch (e) {
          print("이미지 처리 중 오류 발생 $image: $e");
        }
      }
      if (base64Images.isEmpty) {
        print("성공적으로 처리된 이미지가 없습니다.");
        return false;
      }

      try {
        dynamic response;
        if (screenType == autobiographyScreen) {
          String albumType = isInstagram ? Utils.getAlbumType(AlbumType.instagram) : Utils.getAlbumType(AlbumType.album);

          response = await ApiCalls().autobiographyCreateCall(info: base64Images, type: albumType);

          if (response == null) {
            print("autobiographyCreateCall API 호출이 null 응답을 반환했습니다");
            return false;
          }
          if (response['status'] == 'success') {
            JournalModel model = JournalModel.fromJson(response['autobiography']);
            GetIt.I.get<JournalService>().updateJournal(model);
          }
          return true;
        } else {
          response = await ApiCalls().journalDailyCall(info: base64Images);
          if (response == null) {
            print("journalDailyCall API 호출이 null 응답을 반환했습니다");
            return false;
          }
          if (response['status'] == 'success') {
            JournalModel model = JournalModel.fromJson(response['journal']);
            GetIt.I.get<JournalService>().updateJournal(model);
          }
        }

        return true;
      } catch (e) {
        print("API 호출 중 오류 발생: $e");
        return false;
      }
    } catch (e) {
      print("전체 프로세스에서 오류 발생: $e");
      return false;
    }
  }

  static bool isNetworkImage(dynamic image) {
    return image is String && image.startsWith('http');
  }

  static bool isAssetImage(dynamic image) {
    return image is String && image.startsWith('assets');
  }

  static Widget squareWidget({required String image, double? width, required BuildContext context, required bool isNetwork}) {
    log('IsNetwork ${image.toString()}');
    return Container(
      width: width ?? 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: ThemeSetting.of(context).black1),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: isNetwork
              ? NetworkImage(image)
              : isNetworkImage(image)
                  ? NetworkImage(image)
                  : isAssetImage(image)
                      ? AssetImage(image)
                      : FileImage(File(image)),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: ThemeSetting.of(context).secondaryBackground),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
