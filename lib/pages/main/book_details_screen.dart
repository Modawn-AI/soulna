import 'package:Soulna/models/bookDetail/book_detail_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
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

    return Scaffold(
      backgroundColor: ThemeSetting.of(context).tertiary1,
      body: Container(
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
                      border:
                          Border.all(color: ThemeSetting.of(context).primary)),
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
                  Row(
                    children: [
                      Flexible(
                        child: Image.asset(
                          AppAssets.dotLine,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        AppAssets.result,
                        height: 30,
                        width: 67,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Image.asset(
                          AppAssets.dotLine,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    AppAssets.details1,
                    height: 270,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 170,
                    child: ListView.builder(
                      itemCount: overAllList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        BookDetailModel detail = overAllList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                              width: MediaQuery.of(context).size.width * .80,
                              decoration: BoxDecoration(
                                  color: detail.backgroundColor ??
                                      ThemeSetting.of(context).tertiary,
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      detail.title,
                                      style: ThemeSetting.of(context)
                                          .titleMedium
                                          .copyWith(
                                              color: detail.textColor ??
                                                  ThemeSetting.of(context)
                                                      .primary),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Text(
                                      detail.des.toString(),
                                      style:
                                          ThemeSetting.of(context).bodyMedium,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'more',
                                      style:
                                          ThemeSetting.of(context).bodyMedium,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )),
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
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: ThemeSetting.of(context).common1,
                    child: Image.asset(
                      AppAssets.character,
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
                              color: ThemeSetting.of(context).tertiary,
                              textStyle: ThemeSetting.of(context)
                                  .captionLarge
                                  .copyWith(
                                      color: ThemeSetting.of(context).primary));
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
                              backgroundColor:
                                  ThemeSetting.of(context).secondaryBackground,
                              label: Text(
                                detail.title,
                                style: ThemeSetting.of(context).captionLarge,
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: ThemeSetting.of(context).common0,
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
    );
  }

  Widget showLinksDialog() {
    return Container(

      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width ,
      padding: EdgeInsets.symmetric(horizontal: 15),
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
          SizedBox(height: 25,),
          Text(
            LocaleKeys.share_instagram.tr(),
            style: ThemeSetting.of(context).bodyMedium,
          )
        ],
      ),
    );
  }
}