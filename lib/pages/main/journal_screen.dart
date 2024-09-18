import 'dart:ui' as ui;

import 'package:Soulna/bottomsheet/update_delete_diary_bottomSheet.dart';
import 'package:Soulna/models/journal_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/custom_hashtag_function.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

// This file defines the JournalScreen widget, which is used for displaying journals.

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final ScrollController _scrollController = ScrollController();
  final CarouselSliderController _carouselController = CarouselSliderController();
  bool showHeader = false;
  int currentIndex = 0;

  List<String> journalText = [];
  List<String> journalImage = [];

  JournalService journalService = JournalService();

  final Map<String, ImageProvider?> _cachedImages = {};

  List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Initialize _itemKeys after journalText is populated
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _itemKeys = List.generate(journalText.length, (_) => GlobalKey());
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _preloadImages() {
    for (String imageUrl in journalImage) {
      CachedNetworkImageProvider(imageUrl).resolve(ImageConfiguration()).addListener(
            ImageStreamListener(
              (ImageInfo image, bool synchronousCall) {
                setState(() {
                  _cachedImages[imageUrl] = CachedNetworkImageProvider(imageUrl);
                });
              },
              onError: (dynamic exception, StackTrace? stackTrace) {
                print('Error loading image: $imageUrl');
                setState(() {
                  _cachedImages[imageUrl] = null;
                });
              },
            ),
          );
    }
  }

  void _onScroll() {
    if (!_scrollController.position.isScrollingNotifier.value) {
      for (int i = 0; i < _itemKeys.length; i++) {
        final RenderObject? renderObject = _itemKeys[i].currentContext?.findRenderObject();
        if (renderObject != null && renderObject is RenderBox) {
          final position = renderObject.localToGlobal(Offset.zero);
          if (position.dy >= 0 && position.dy <= MediaQuery.of(context).size.height / 2) {
            if (currentIndex != i) {
              setState(() {
                currentIndex = i;
              });
              _carouselController.animateToPage(i);
            }
            break;
          }
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    journalService = GetIt.I.get<JournalService>();
    if (journalService.journalModel != null) {
      journalText = journalService.journalModel.content.map<String>((item) => item.text.toString()).toList();

      journalImage = journalService.journalModel.content.map<String>((item) => item.image.toString()).toList();

      _itemKeys = List.generate(journalText.length, (_) => GlobalKey());
      _preloadImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.isLightTheme(context) ? ThemeSetting.of(context).secondaryBackground : ThemeSetting.of(context).common2,
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget.headerWithAction(
              context: context,
              title: null, // Adjusted as per your condition
              showMoreIconOnTap: () {
                UpdateDeleteDiaryBottomSheet.updateDeleteDiaryBottomSheet(context: context);
              },
            ),
            Expanded(
              child: journalList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget journalList() {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 39,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: ThemeSetting.of(context).tertiary1, width: 1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: ThemeSetting.of(context).tertiary1, width: 1),
                    borderRadius: BorderRadius.circular(50),
                    color: ThemeSetting.of(context).tertiary1,
                  ),
                  child: Text(
                    Utils.getTodayMDYFormatted(),
                    style: ThemeSetting.of(context).bodyMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          journalService.journalModel?.title ?? '',
          textAlign: TextAlign.center,
          style: ThemeSetting.of(context).labelMedium,
        ),
        const SizedBox(height: 20),
        carouselSlider(),
        const SizedBox(height: 20),
        Expanded(
          child: showDescriptionList(showKeyword: true),
        ),
      ],
    );
  }

  Widget showDescriptionList({required bool showKeyword}) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: journalText.length,
      itemBuilder: (context, index) {
        return Container(
          key: _itemKeys[index],
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeSetting.of(context).primaryText,
                  ),
                  color: ThemeSetting.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('${index + 1}', style: ThemeSetting.of(context).bodySmall),
              ),
              const SizedBox(height: 10),
              RichText(
                text: CustomHashtagFunction.getStyledText(
                  text: journalText[index],
                  keywords: journalService.journalModel?.hashtags ?? [],
                  context: context,
                ),
              ),
              if (index == journalText.length - 1 && showKeyword)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      LocaleKeys.today_keyword.tr(),
                      style: ThemeSetting.of(context).headlineLarge.copyWith(
                            color: ThemeSetting.of(context).primaryText,
                          ),
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        journalService.journalModel?.hashtags.length ?? 0,
                        (i) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: ThemeSetting.of(context).alternate,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "#${journalService.journalModel?.hashtags[i] ?? ''}",
                            style: ThemeSetting.of(context).bodyMedium.copyWith(color: ThemeSetting.of(context).secondary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const CustomDividerWidget(),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        LocaleKeys.share_my_ai_diary_to_your_friend.tr(),
                        style: ThemeSetting.of(context).captionLarge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonWidget.gradientButtonWithImage(
                      context: context,
                      text: LocaleKeys.share_text.tr(),
                      imageString: AppAssets.heart,
                    ),
                    const SizedBox(height: 20),
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  Widget carouselSlider() {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: journalImage.length,
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: () {
            _scrollToIndex(index);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ThemeSetting.isLightTheme(context) ? ThemeSetting.of(context).black1 : ThemeSetting.of(context).tertiary1,
                width: 2,
              ),
            ),
            child: GrayscaleBlurredBackgroundImage(
              imageUrl: journalImage[index],
              blurSigma: 10.0, // Adjust the blur strength as needed
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: journalImage[index],
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: ThemeSetting.of(context).bodySmall.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 230,
        viewportFraction: 0.9,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        padEnds: false,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
          _scrollToIndex(index);
        },
      ),
    );
  }

  void _scrollToIndex(int index) {
    double totalHeight = 0;

    // Calculate the total height of previous items
    for (int i = 0; i < index; i++) {
      totalHeight += _calculateTextHeight(journalText[i]);
      totalHeight += 70; // Add extra space for numbering, padding, etc.
    }

    _scrollController.animateTo(
      totalHeight,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  double _calculateTextHeight(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: ThemeSetting.of(context).bodyMedium, // Use the actual text style
      ),
      maxLines: null,
      textDirection: Directionality.of(context),
    );

    // Calculate available width for the text
    double availableWidth = MediaQuery.of(context).size.width - 36; // Consider horizontal padding

    textPainter.layout(maxWidth: availableWidth);

    return textPainter.height;
  }
}

class GrayscaleBlurredBackgroundImage extends StatelessWidget {
  final String imageUrl;
  final Widget child;
  final double blurSigma;

  const GrayscaleBlurredBackgroundImage({
    Key? key,
    required this.imageUrl,
    required this.child,
    this.blurSigma = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Grayscale and blurred background
          ImageFiltered(
            imageFilter: ui.ImageFilter.blur(
              sigmaX: blurSigma,
              sigmaY: blurSigma,
            ),
            child: ColorFiltered(
              colorFilter: const ColorFilter.matrix(<double>[
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ]),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(color: Colors.grey[300]),
                placeholder: (context, url) => Container(color: Colors.grey[300]),
              ),
            ),
          ),
          // Original content
          child,
        ],
      ),
    );
  }
}
