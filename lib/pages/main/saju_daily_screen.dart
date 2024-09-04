import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:Soulna/models/bookDetail/book_detail_model.dart';
import 'package:Soulna/models/saju_daily_model.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

//Not linked to any screen
//Same as book details screen with some changes
class SajuDailyScreen extends StatefulWidget {
  const SajuDailyScreen({
    super.key,
  });

  @override
  State<SajuDailyScreen> createState() => _SajuDailyScreenState();
}

class _SajuDailyScreenState extends State<SajuDailyScreen> {
  List<BookDetailModel> thingsList = [];
  UserInfoData? user;
  SajuDailyService? sajuDailyService;

  int _counter = 0;
  Uint8List _imageFile = Uint8List(0);
  ScreenshotController screenshotController = ScreenshotController();

  final GlobalKey _printKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = GetIt.I.get<UserInfoData>();
    sajuDailyService = GetIt.I.get<SajuDailyService>();

    debugPrint('KeyWord ${sajuDailyService?.sajuDailyInfo}');
    if (sajuDailyService?.sajuDailyInfo != null) {
      for (int i = 0; i < sajuDailyService?.sajuDailyInfo.keyword.length; i++) {
        thingsList.add(BookDetailModel(
          title: sajuDailyService!.sajuDailyInfo.keyword[i].text,
          backgroundColor: ThemeSetting.of(context).extraGray,
          image: sajuDailyService!.sajuDailyInfo.keyword[i].emoji,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List hashTag = sajuDailyService!.sajuDailyInfo != null ? sajuDailyService!.sajuDailyInfo.hashtag : [];

    String myPicture = user!.userModel.tenTwelve.picture;
    String myElementName = Utils.getCardAttribute(myPicture, CardAttribute.element);

    String ganjiPicture = sajuDailyService!.sajuDailyInfo.dailyGanji;
    String animalName = Utils.getCardAttribute(ganjiPicture, CardAttribute.animal);
    String elementName = Utils.getCardAttribute(ganjiPicture, CardAttribute.element);

    return Scaffold(
      backgroundColor: Utils.getElementBgToColor(context, myElementName),
      body: SafeArea(
        child: Stack(
          children: [
            buildMediaQuery(context, myElementName, elementName, animalName, hashTag),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: HeaderWidget.headerBack(
                context: context,
                backgroundColor: Utils.getElementBgToColor(context, myElementName),
                onTap: () {
                  context.goNamed(mainScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMediaQuery(BuildContext context, String myElementName, String elementName, String animalName, List<dynamic> hashTag) {
    return RepaintBoundary(
      key: _printKey,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          color: Utils.getElementBgToColor(context, myElementName),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image.asset(
                AppAssets.logo,
                height: 38,
                width: 38,
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  Utils.getTodayMDYFormatted(),
                  style: ThemeSetting.of(context).headlineMedium.copyWith(color: ThemeSetting.of(context).primaryText),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    sajuDailyService!.sajuDailyInfo.sajuDescription.title,
                    style: ThemeSetting.of(context).labelLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    height: 270,
                    width: 222,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 2,
                        color: Utils.getElementToColor(context, myElementName),
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "$kResouceUrl${user!.userModel.tenTwelve.picture}",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: ThemeSetting.of(context).secondaryBackground,
                ),
                child: Column(
                  children: [
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
                      height: 40,
                    ),
                    Text(
                      LocaleKeys.avoid_today.tr(),
                      style: ThemeSetting.of(context).titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$elementName $animalName",
                      style: ThemeSetting.of(context).titleLarge,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Container(
                      height: 270,
                      width: 222,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: Utils.getElementToColor(context, elementName),
                        ),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "$kResouceUrl${sajuDailyService!.sajuDailyInfo.dailyGanji}",
                          height: 250,
                          width: 202,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    const CustomDividerWidget(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 40,
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
                      height: 20,
                    ),
                    Wrap(
                      children: List.generate(
                        sajuDailyService!.sajuDailyInfo.sajuDescription.sajuTextList.length,
                        (index) {
                          return sajuDescriptionText(
                            context,
                            sajuDailyService!.sajuDailyInfo.sajuDescription.sajuTextList[index].title,
                            sajuDailyService!.sajuDailyInfo.sajuDescription.sajuTextList[index].paragraph,
                          );
                        },
                      ),
                    ),
                    Wrap(
                      spacing: 5,
                      runSpacing: 10,
                      children: List.generate(
                        hashTag.length,
                        (index) {
                          return ButtonWidget.roundedButtonOrange(
                            context: context,
                            text: hashTag[index],
                            height: 30,
                            color: ThemeSetting.of(context).alternate,
                            textStyle: ThemeSetting.of(context).captionLarge.copyWith(
                                  color: ThemeSetting.of(context).primary,
                                ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: ThemeSetting.of(context).common0,
                    ),
                    const SizedBox(
                      height: 40,
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
                                borderRadius: BorderRadius.circular(50),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
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
                            // screenshotController.capture(delay: Duration(milliseconds: 10)).then((capturedImage) async {
                            //   ShowCapturedWidget(context, capturedImage!);
                            //   final directory = await getTemporaryDirectory();
                            //   final imagePath = '${directory.path}/screenshot.png';
                            //   final imageFile = File(imagePath);
                            //   await imageFile.writeAsBytes(capturedImage);
                            //
                            //   // Share the image
                            //   await Share.shareXFiles([XFile(imagePath)], text: 'Check out my Saju Daily!');
                            // }).catchError((onError) {
                            //   print(onError);
                            // });
                            captureAndShareScreenshot();
                            // showModalBottomSheet(
                            //   context: context,
                            //   builder: (context) {
                            //     return showLinksDialog();
                            //   },
                            // );
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container sajuDescriptionText(BuildContext context, String title, String description) {
    return Container(
      child: Column(
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
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }

  Future<void> captureAndShareScreenshot2() async {
    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (status.isDenied) {
        // Handle permission denied
        return;
      }

      // Capture the screenshot
      final capture = await screenshotController.captureFromWidget(
        InheritedTheme.captureAll(
          context,
          Material(
            child: build(context),
          ),
        ),
        delay: const Duration(milliseconds: 100),
        pixelRatio: 3.0,
      );

      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/screenshot.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(capture);

      // Share the image
      await Share.shareXFiles([XFile(imagePath)], text: 'Check out my Saju Daily!');
    } catch (e) {
      print('Error capturing or sharing screenshot: $e');
    }
  }

  Future<void> captureAndShareScreenshot() async {
    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (status.isDenied) {
        print('Storage permission denied');
        return;
      }

      final RenderRepaintBoundary boundary = _printKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final double pixelRatio = 3.0; // Increased pixel ratio for higher quality
      final Size size = boundary.size;
      final double totalHeight = _scrollController.position.maxScrollExtent + size.height;

      List<img.Image> images = [];
      double capturedHeight = 0;

      while (capturedHeight < totalHeight) {
        await _scrollController.animateTo(
          capturedHeight,
          duration: Duration(milliseconds: 10),
          curve: Curves.linear,
        );
        await Future.delayed(Duration(milliseconds: 10)); // Wait for rendering

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

      // Calculate the height of the last partial screen
      double remainingHeight = totalHeight - (images.length - 1) * size.height;
      int remainingPixels = (remainingHeight * pixelRatio).ceil();

      // Crop the last image from the bottom
      img.Image lastImage = images.last;
      img.Image croppedLastImage = img.copyCrop(
        lastImage,
        x: 0,
        y: lastImage.height - remainingPixels,
        width: lastImage.width,
        height: remainingPixels,
      );

      // Combine images
      final img.Image fullImage = img.Image(
        width: images[0].width,
        height: (images.length - 1) * images[0].height + remainingPixels,
      );

      int offsetY = 0;
      for (int i = 0; i < images.length - 1; i++) {
        img.compositeImage(
          fullImage,
          images[i],
          dstY: offsetY,
        );
        offsetY += images[i].height;
      }

      // Add the cropped last image
      img.compositeImage(
        fullImage,
        croppedLastImage,
        dstY: offsetY,
      );

      // Use high quality PNG encoding
      final pngEncoder = img.PngEncoder(level: 0); // 0 is no compression, highest quality
      final pngBytes = pngEncoder.encode(fullImage);

      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/high_quality_screenshot.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(pngBytes);

      // Share the image
      await Share.shareXFiles([XFile(imagePath)], text: 'Check out my high-quality Saju Daily!');
    } catch (e, stackTrace) {
      print('Error capturing or sharing screenshot: $e');
      print('Stack trace: $stackTrace');

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
      height: MediaQuery.of(context).size.height * 0.20,
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
