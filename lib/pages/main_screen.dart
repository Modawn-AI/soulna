import 'package:Soulna/models/image_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<ImageModel> images = [];
  @override
  Widget build(BuildContext context) {
    images = [
      ImageModel(
          linear1: ThemeSetting.of(context).linearContainer1,
          linear2: ThemeSetting.of(context).linearContainer2,
          image: AppAssets.image1,
          text: LocaleKeys.check_your_fortune_for_today.tr()),
      ImageModel(
          linear1: ThemeSetting.of(context).linearContainer3,
          linear2: ThemeSetting.of(context).linearContainer4,
          image: AppAssets.image2,
          text: LocaleKeys.create_today_diary.tr()),
      ImageModel(
          linear1: ThemeSetting.of(context).linearContainer5,
          linear2: ThemeSetting.of(context).linearContainer6,
          image: AppAssets.image3,
          text: LocaleKeys.create_your_journal.tr()),
    ];
    return SafeArea(
        child: Scaffold(

      backgroundColor: ThemeSetting.of(context).secondaryBackground,

      body: ListView(
        children: [
          HeaderWidget.headerWithLogoAndInstagram(context: context),
          const SizedBox(
            height: 32,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${LocaleKeys.hey.tr()} Stella,',
                style: ThemeSetting.of(context).labelLarge,
              ),
              Text(
                LocaleKeys.hows_you_day_going.tr(),
                style: ThemeSetting.of(context).labelLarge,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 39,
            margin: const EdgeInsets.only(right: 148, left: 149),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(
                  color: ThemeSetting.of(context).tertiary1, width: 1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ThemeSetting.of(context).tertiary1, width: 1),
                  borderRadius: BorderRadius.circular(50),
                  color: ThemeSetting.of(context).tertiary1),
              child: Text(
                'July 8',
                style: ThemeSetting.of(context)
                    .bodyMedium
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 350,
            width: 202,
            child: CarouselSlider(
              items: images.map((e) {
                ImageModel image = e;
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 300,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [image.linear1, image.linear2],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        border: Border.all(
                            color: ThemeSetting.of(context).primaryText),
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 22),
                          margin:
                              const EdgeInsets.only(top: 8, left: 8, right: 8),
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: ThemeSetting.of(context)
                                          .secondaryBackground,width: 1.5),
                                  left: BorderSide(
                                      color: ThemeSetting.of(context)
                                          .secondaryBackground,width: 1.5),
                                  top: BorderSide(
                                      color: ThemeSetting.of(context)
                                          .secondaryBackground,width: 1.5)),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Text(
                            image.text,
                            style: ThemeSetting.of(context).titleLarge.copyWith(
                                color: ThemeSetting.of(context)
                                    .secondaryBackground),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Image.asset(
                            image.image,
                            width: 165,
                            height: 195,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: ThemeSetting.of(context).primaryText,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.create.tr(),
                                style: ThemeSetting.of(context).headlineLarge,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                AppAssets.start,
                                height: 14,
                                width: 14,
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
              }).toList(),
              carouselController: CarouselController(),
              options: CarouselOptions(
                  viewportFraction: 0.8,
                  padEnds: true,
                  aspectRatio: 0.9,
                  height: 500,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 202,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.asMap().entries.map((entry) {
                return GestureDetector(
                  //onTap: () => _controller.animateToPage(entry.key),
                  child: Container(

                      width: 85,
                      height: 4,
                      // margin: const EdgeInsets.symmetric(
                      //     vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.horizontal(left: Radius.circular(3),),
                          color: currentIndex == entry.key
                              ? ThemeSetting.of(context).primary
                              : ThemeSetting.of(context).common1)),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: ThemeSetting.of(context).common2,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10),
            child: Text(
              LocaleKeys.recommended_fortune.tr(),
              style: ThemeSetting.of(context).captionLarge,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 17),
            decoration: BoxDecoration(
                color: ThemeSetting.of(context).tertiary2,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.natural_born_fortune_from_the_heavens.tr(),
                      style: ThemeSetting.of(context)
                          .bodyMedium
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          LocaleKeys.check.tr(),
                          style: ThemeSetting.of(context).captionLarge,
                        ),
                        Image.asset(
                          AppAssets.next,
                          height: 14,
                          width: 14,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppAssets.star,
                      height: 20,
                      width: 20,
                    ),
                    Image.asset(
                      AppAssets.character,
                      height: 52,
                      width: 57,
                    ),
                  ],
                )
              ],
            ),
          ),const SizedBox(
            height: 35,
          ),

        ],
      ),
    ));
  }
}