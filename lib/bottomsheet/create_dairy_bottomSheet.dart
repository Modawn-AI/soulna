import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:Soulna/models/journal_model.dart';
import 'package:Soulna/pages/main/animation_screen.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateDairyBottomSheet {
  static createDairyBottomSheet({
    required BuildContext context,
    required List<Map<String, dynamic>> selectedImages,
  }) {
    return showModalBottomSheet(
      elevation: 1,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.88,
          decoration: BoxDecoration(color: ThemeSetting.of(context).info, borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
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
                LocaleKeys.would_you_like_to_make_a_diary_with_that_picture.tr(),
                textAlign: TextAlign.center,
                style: ThemeSetting.of(context).labelLarge.copyWith(color: ThemeSetting.of(context).white),
              ),
              const SizedBox(
                height: 16,
              ),
              Text('${LocaleKeys.a_total_of.tr()} ${LocaleKeys.make_a_diary_for.tr()}July 8', textAlign: TextAlign.center, style: ThemeSetting.of(context).headlineLarge),
              const SizedBox(
                height: 50,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    squareWidget(image: AppAssets.rectangle, context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(image: AppAssets.rectangle, width: 150, context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(image: AppAssets.rectangle, context: context),
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
                    squareWidget(image: AppAssets.rectangle, context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(image: AppAssets.rectangle, width: 150, context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(image: AppAssets.rectangle, context: context),
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
                    squareWidget(image: AppAssets.rectangle, context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(image: AppAssets.rectangle, width: 150, context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(image: AppAssets.rectangle, context: context),
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
                    onTap: () async {
                      final apiCallFuture = _mockApiCall(selectedImages);

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimationScreen(apiFuture: apiCallFuture),
                        ),
                      );

                      context.pushReplacementNamed(journalScreen);
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool> _mockApiCall(List<Map<String, dynamic>> selectedImages) async {
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
            print("Added pre-encoded base64 image with length: ${bytes.length}");
          } else {
            print("Unexpected type for bytes: ${bytes.runtimeType}");
          }
        } else if (imageMap.containsKey('path')) {
          // 파일 경로가 주어진 경우
          File imageFile = File(imageMap['path']);
          Uint8List bytes = await imageFile.readAsBytes();
          String base64Image = base64Encode(bytes);
          base64Images.add(base64Image);
          print("Added base64 image from file with length: ${base64Image.length}");
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

  static Widget squareWidget({required String image, double? width, required BuildContext context}) {
    return Container(
      width: width ?? 80,
      height: 80,
      decoration: BoxDecoration(border: Border.all(color: ThemeSetting.of(context).black1), borderRadius: BorderRadius.circular(10), image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image))),
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
