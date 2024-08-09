import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:Soulna/models/journal_model.dart';
import 'package:Soulna/pages/main/animation_screen.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

class CreateDairyBottomSheet {
  static createDairyBottomSheet({
    required BuildContext context,
    required List<dynamic> selectedImages,
    required bool isNetwork,
    required String screen,
  }) {
    return showModalBottomSheet(
      elevation: 1,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        List displayImages = List.from(selectedImages);

        log('Display Image ${(selectedImages.toString().contains('media_url'))}');
        while (displayImages.length < 10) {
          displayImages.add({
            'id': 0,
            "media_type": "IMAGE",
            "media_url":
                "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
          });
        }
        log('displayImages ${displayImages.first.toString().contains('media_type')}');
        log('displayImages ${displayImages.last.toString().contains('media_type')}');
        return Container(
          // alignment: Alignment.bottomCenter,
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
                      color: ThemeSetting.of(context).white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.would_you_like_to_make_a_diary_with_that_picture
                    .tr(),
                textAlign: TextAlign.center,
                style: ThemeSetting.of(context)
                    .labelLarge
                    .copyWith(color: ThemeSetting.of(context).white),
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
                    squareWidget(
                        image: isNetwork == true
                            ? displayImages[0]['media_url']
                            : (displayImages[0]
                                    .toString()
                                    .contains('media_url'))
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
                            : (displayImages[1]
                                    .toString()
                                    .contains('media_url'))
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
                            : (displayImages[2]
                                    .toString()
                                    .contains('media_url'))
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
                            : (displayImages[3]
                                    .toString()
                                    .contains('media_url'))
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
                            : (displayImages[4]
                                    .toString()
                                    .contains('media_url'))
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
                            : (displayImages[5]
                                    .toString()
                                    .contains('media_url'))
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
                            : (displayImages[6]
                                    .toString()
                                    .contains('media_url'))
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
                            : (displayImages[7]
                                    .toString()
                                    .contains('media_url'))
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
                            : (displayImages[8]
                                    .toString()
                                    .contains('media_url'))
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
                            : (displayImages[9]
                                    .toString()
                                    .contains('media_url'))
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: ButtonWidget.gradientButtonWithImage(
                      context: context,
                      text: LocaleKeys.create_a_diary.tr(),
                      onTap: () async {
                        //  final apiCallFuture = _mockApiCall(selectedImages);

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnimationScreen(
                              apiFuture: Future.value(false),
                              screenName: screen,
                            ),
                          ),
                        );

                        // context.pushReplacementNamed(screen);
                      }),
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

  static Future<bool> _mockApiCall(
      List<Map<String, dynamic>> selectedImages) async {
    List<String> base64Images = [];
    for (var imageMap in selectedImages) {
      try {
        print("Processing image: $imageMap"); // 디버깅을 위한 출력

        if (imageMap.containsKey('bytes')) {
          dynamic bytes = imageMap['bytes'];
          if (bytes is Uint8List) {
            String base64Image = base64Encode(bytes);
            base64Images.add(base64Image);
            print("Added base64 image with length: ${base64Image.length}");
          } else if (bytes is String) {
            // 이미 Base64로 인코딩된 경우
            base64Images.add(bytes);
            print(
                "Added pre-encoded base64 image with length: ${bytes.length}");
          } else {
            print("Unexpected type for bytes: ${bytes.runtimeType}");
          }
        } else if (imageMap.containsKey('path')) {
          // 파일 경로가 주어진 경우
          File imageFile = File(imageMap['path']);
          Uint8List bytes = await imageFile.readAsBytes();
          String base64Image = base64Encode(bytes);
          base64Images.add(base64Image);
          print(
              "Added base64 image from file with length: ${base64Image.length}");
        } else {
          print("Image map doesn't contain 'bytes' or 'path': $imageMap");
        }
      } catch (e) {
        print("Error processing image: $e");
      }
    }

    print("Total base64 images: ${base64Images.length}");

    if (base64Images.isEmpty) {
      print("No images were successfully processed.");
      return false;
    }

    try {
      dynamic response = await ApiCalls().journalDailyCall(info: base64Images);

      if (response == null) {
        print("API call returned null response");
        return false;
      }
      if (response['status'] == 'success') {
        JournalModel model = JournalModel.fromJson(response['journal']);
        GetIt.I.get<JournalService>().updateJournal(model);
      }
      return true;
    } catch (e) {
      print("Error in API call: $e");
      return false;
    }
  }

  static bool isNetworkImage(dynamic image) {
    return image is String && image.startsWith('http');
  }

  static Widget squareWidget(
      {required String image,
      double? width,
      required BuildContext context,
      required bool isNetwork}) {
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
                  : FileImage(File(image)),
          fit: BoxFit.cover,
        ),
      ),
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
}