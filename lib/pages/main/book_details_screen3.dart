import 'package:Soulna/models/bookDetail/book_detail_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';


//Not linked to any screen
//Same as book details screen with some changes
class BookDetailsScreen3 extends StatefulWidget {
  const BookDetailsScreen3({super.key});

  @override
  State<BookDetailsScreen3> createState() => _BookDetailsScreen3State();
}

class _BookDetailsScreen3State extends State<BookDetailsScreen3> {
  List hashTag = ['#dreamy', '#Hyundai Outlet'];

  List<BookDetailModel> overAllList = [];
  List<BookDetailModel> thingsList = [];
  @override
  Widget build(BuildContext context) {
    overAllList = [
      BookDetailModel(
          title: LocaleKeys.overall.tr(),
          backgroundColor: ThemeSetting.of(context).tertiary,
          des:
              'A day of learning and mastering new things. There\'s no end to studying. It\'s not just about academic learning; everything necessary in daily life can be a subject of study. Overreaching ambitions can lead to failure.',
          textColor: ThemeSetting.of(context).primary),
      BookDetailModel(
          title: LocaleKeys.financial.tr(),
          backgroundColor: ThemeSetting.of(context).lightGreen,
          des:
              'A day of learning and mastering new things. There\'s no end to studying. It\'s not just about academic learning; everything necessary in daily life can be a subject of study. Overreaching ambitions can lead to failure.',
          textColor: ThemeSetting.of(context).green),
    ];

    thingsList = [
      BookDetailModel(
        title: LocaleKeys.green_color.tr(),
        backgroundColor: ThemeSetting.of(context).tertiary,
        image: AppAssets.one,
      ),
      BookDetailModel(
        title: LocaleKeys.french_cuisine.tr(),
        backgroundColor: ThemeSetting.of(context).lightGreen,
        image: AppAssets.two,
      ),
      BookDetailModel(
        title: LocaleKeys.relatives.tr(),
        backgroundColor: ThemeSetting.of(context).common1,
        image: AppAssets.three,
      ),
      BookDetailModel(
        title: '2,4',
        backgroundColor: ThemeSetting.of(context).extraGray,
        image: AppAssets.four,
      ),
      BookDetailModel(
        title: LocaleKeys.camera.tr(),
        backgroundColor: ThemeSetting.of(context).lightPurple,
        image: AppAssets.five,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.isLightTheme(context)
            ? ThemeSetting.of(context).blueAccent
            : ThemeSetting.of(context).common2,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              HeaderWidget.headerBack(
                  context: context,
                  backgroundColor: ThemeSetting.of(context).tertiary1),
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
                  'October 7, 2024',
                  style: ThemeSetting.of(context)
                      .headlineMedium
                      .copyWith(color: ThemeSetting.of(context).primaryText),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  LocaleKeys.a_day_of_learning_and_mastering_new_things.tr(),
                  style: ThemeSetting.of(context).labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    height: 260,
                    width: 212,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: ThemeSetting.of(context).primary)),
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(AppAssets.bookImage),
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
                      topRight: Radius.circular(30)),
                  color: ThemeSetting.of(context).secondaryBackground,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                LocaleKeys.result.tr(),
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
                      LocaleKeys.blue_ox.tr(),
                      style: ThemeSetting.of(context).titleLarge,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Image.asset(
                      AppAssets.bookImage,
                      height: 250,
                      width: 202,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                   CustomDividerWidget(thickness: 2,),
                    const SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                      radius: 45,

                      backgroundColor: ThemeSetting.of(context).common2,
                      child: Image.asset(
                        ThemeSetting.isLightTheme(context) ? AppAssets.character: AppAssets.characterDark,
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      LocaleKeys.outfit_that_brings_luck_and_love.tr(),
                      style: ThemeSetting.of(context).titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        LocaleKeys.outfit_that_brings_luck_and_love_des.tr(),
                        style: ThemeSetting.of(context).captionLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                        spacing: 5,
                        children: List.generate(
                          hashTag.length,
                          (index) {
                            return ButtonWidget.roundedButtonOrange(
                                context: context,
                                text: hashTag[index],
                                height: 30,
                                color: ThemeSetting.of(context).alternate,
                                textStyle: ThemeSetting.of(context)
                                    .captionLarge
                                    .copyWith(
                                        color:
                                            ThemeSetting.of(context).primary));
                          },
                        )),
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
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.all(2),
                                avatar: Image.asset(
                                  detail.image!,
                                  height: 30,
                                ),
                                backgroundColor: ThemeSetting.of(context)
                                    .secondaryBackground,
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
                          )),
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
                          text: LocaleKeys.share.tr(),
                          imageString: AppAssets.heart,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return showLinksDialog();
                              },
                            );
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

  Widget showLinksDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: ThemeSetting.of(context).secondaryBackground,
          borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(15), left: Radius.circular(15))),
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