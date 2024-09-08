import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:Soulna/models/bookDetail/book_detail_model.dart';
import 'package:Soulna/models/ten_twelve_model.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:Soulna/provider/ten_twelve_provider.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

// Same as book details screen with some changes

class TenTwelveScreen extends StatefulWidget {
  const TenTwelveScreen({super.key});

  @override
  State<TenTwelveScreen> createState() => _TenTwelveScreenState();
}

class _TenTwelveScreenState extends State<TenTwelveScreen> {
  final GlobalKey _printKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool _isCapturing = false;

  @override
  Widget build(BuildContext context) {
    Widget errorWidget = Container();
    try {
      TenTwelveModel? tenTwelveModel = context.watch<TenTwelveProvider>().tenTwelveModel;
      tenTwelveModel ??= GetIt.I.get<UserInfoData>().userModel.tenTwelve;
      String myElementName = Utils.getCardAttribute(tenTwelveModel!.picture, CardAttribute.element);
      List<String> titleString = tenTwelveModel.title.split(',');
      List<BookDetailModel> thingsList = [];

      for (int i = 0; i < tenTwelveModel.hashtag.length; i++) {
        thingsList.add(BookDetailModel(
          title: tenTwelveModel.hashtag[i].hashtag,
          backgroundColor: ThemeSetting.of(context).extraGray,
          image: tenTwelveModel.hashtag[i].emoji,
        ));
      }
      return Scaffold(
        backgroundColor: Utils.getElementBgToColor(context, myElementName),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              buildRepaintBoundary(context, titleString, myElementName, tenTwelveModel, thingsList),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: HeaderWidget.headerBack(
                  context: context,
                  backgroundColor: ThemeSetting.of(context).redAccent,
                  onTap: () {
                    context.goNamed(mainScreen);
                  },
                ),
              ),
              if (_isCapturing)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text(
                            '캡처 중...',
                            style: ThemeSetting.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    } catch (e) {
      errorWidget = Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 50, color: Colors.red),
              const SizedBox(height: 20),
              const Text("오류가 발생했습니다.", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text("돌아가기"),
              ),
            ],
          ),
        ),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.pop();
      });
    }
    return errorWidget;
  }

  RepaintBoundary buildRepaintBoundary(BuildContext context, List<String> titleString, String myElementName, TenTwelveModel tenTwelveModel, List<BookDetailModel> thingsList) {
    return RepaintBoundary(
      key: _printKey,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: _isCapturing ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Utils.getElementBgToColor(context, myElementName).withOpacity(0.5),
                  BlendMode.srcOver,
                ),
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Image.asset(
                    "$kCardResource3DUrl${tenTwelveModel.picture}",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Image.asset(
                  AppAssets.logo,
                  height: 37,
                  width: 37,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    LocaleKeys.your_korean_zodiac.tr(),
                    style: ThemeSetting.of(context).headlineMedium.copyWith(color: ThemeSetting.of(context).primaryText),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    titleString[0],
                    style: ThemeSetting.of(context).displayMedium.copyWith(
                          fontFamily: "ChosunGs",
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${titleString[2]} (${titleString[1]})",
                  style: ThemeSetting.of(context).headlineMedium.copyWith(color: ThemeSetting.of(context).primaryText),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      height: 260,
                      width: 212,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Utils.getElementToColor(context, myElementName),
                          )),
                      padding: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "$kCardResource3DUrl${tenTwelveModel.picture}",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: ThemeSetting.of(context).secondaryBackground,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: Image.asset(
                                AppAssets.dotLine,
                                color: ThemeSetting.of(context).primaryText,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 30,
                              width: 67,
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                  AppAssets.result,
                                ),
                              )),
                              child: Center(
                                child: Text(
                                  LocaleKeys.result_text.tr(),
                                  style: ThemeSetting.of(context).captionMedium,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Image.asset(
                                AppAssets.dotLine,
                                color: ThemeSetting.of(context).primaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomDividerWidget(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: ThemeSetting.of(context).common2,
                        child: Image.asset(
                          ThemeSetting.isLightTheme(context) ? AppAssets.character : AppAssets.characterDark,
                          height: 60,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Wrap(
                        children: List.generate(
                          tenTwelveModel.description.text.length,
                          (index) {
                            return sajuDescriptionText(
                              context,
                              tenTwelveModel!.description.text[index].title,
                              tenTwelveModel.description.text[index].paragraph,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          alignment: WrapAlignment.center,
                          children: List.generate(
                            thingsList.length,
                            (index) {
                              BookDetailModel detail = thingsList[index];
                              return Chip(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.all(2),
                                avatar: Text(detail.image!),
                                backgroundColor: ThemeSetting.of(context).secondaryBackground,
                                label: Text(
                                  detail.title,
                                  style: ThemeSetting.of(context).captionLarge,
                                ),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: ThemeSetting.of(context).common2,
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        LocaleKeys.share_my_ai_diary_to_your_friend.tr(),
                        style: ThemeSetting.of(context).captionLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: ButtonWidget.gradientButtonWithImage(
                            context: context,
                            text: LocaleKeys.share_text.tr(),
                            imageString: AppAssets.heart,
                            onTap: () {
                              captureAndShareScreenshot();
                              // showModalBottomSheet(
                              //   context: context,
                              //   builder: (context) {
                              //     return showLinksDialog();
                              //   },
                              // );
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sajuDescriptionText(BuildContext context, String title, String description) {
    return Column(
      children: [
        Text(
          title,
          style: ThemeSetting.of(context).titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            description,
            style: ThemeSetting.of(context).captionLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Future<void> captureAndShareScreenshot() async {
    try {
      setState(() {
        _isCapturing = true;
      });

      var status = await Permission.storage.request();
      if (status.isDenied) {
        setState(() {
          _isCapturing = false;
        });
        return;
      }

      final RenderRepaintBoundary boundary = _printKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final double pixelRatio = MediaQuery.of(context).devicePixelRatio;
      final Size size = boundary.size;
      final double totalHeight = _scrollController.position.maxScrollExtent + size.height;
      final int imageHeight = (size.height * pixelRatio).toInt();
      final int fullImageHeight = (totalHeight * pixelRatio).toInt();

      List<img.Image> images = [];
      double capturedHeight = 0;

      while (capturedHeight < totalHeight) {
        await _scrollController.animateTo(
          capturedHeight,
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
        await Future.delayed(Duration(milliseconds: 300));

        ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          img.Image? partImage = img.decodePng(byteData.buffer.asUint8List());
          if (partImage != null) {
            images.add(partImage);
          }
        }

        capturedHeight += size.height;
      }

      final img.Image fullImage = img.Image(
        width: (size.width * pixelRatio).toInt(),
        height: fullImageHeight,
      );

      int offsetY = 0;
      for (int i = 0; i < images.length; i++) {
        int heightToCopy;

        if (i == images.length - 1) {
          // 마지막 이미지는 남은 높이만큼 합침
          heightToCopy = fullImageHeight - offsetY;
          if (heightToCopy <= 0) break;

          // 마지막 이미지는 아래쪽에 맞추어 합침
          img.Image croppedImage = img.copyCrop(
            images[i],
            x: 0,
            y: images[i].height - heightToCopy, // 아래쪽에서 남은 부분만 잘라냄
            width: images[i].width,
            height: heightToCopy,
          );

          img.compositeImage(fullImage, croppedImage, dstY: fullImageHeight - heightToCopy); // 마지막 이미지는 아래쪽부터 붙임
        } else {
          // 그 외 이미지는 위에서부터 합침
          heightToCopy = imageHeight;

          img.Image croppedImage = img.copyCrop(
            images[i],
            x: 0,
            y: 0,
            width: images[i].width,
            height: heightToCopy,
          );

          img.compositeImage(fullImage, croppedImage, dstY: offsetY);
          offsetY += heightToCopy;
        }
      }

      final pngEncoder = img.PngEncoder(level: 0);
      final pngBytes = pngEncoder.encode(fullImage);

      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/high_quality_screenshot.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(pngBytes);

      setState(() {
        _isCapturing = false;
      });

      await Share.shareXFiles([XFile(imagePath)], text: 'Check out my high-quality Saju Daily!');
    } catch (e, stackTrace) {
      print('Error capturing or sharing screenshot: $e');
      print('Stack trace: $stackTrace');

      setState(() {
        _isCapturing = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to capture or share screenshot: $e'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Widget showLinksDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: ThemeSetting.of(context).secondaryBackground, borderRadius: const BorderRadius.horizontal(right: Radius.circular(15), left: Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.share_link.tr(),
            style: ThemeSetting.of(context).bodyMedium,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            LocaleKeys.share_instagram.tr(),
            style: ThemeSetting.of(context).bodyMedium,
          )
        ],
      ),
    );
  }
}
