import 'package:Soulna/models/bookDetail/book_detail_model.dart';
import 'package:Soulna/models/saju_daily_model.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

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

    for (int i = 0; i < sajuDailyService!.sajuDailyInfo.keyword.length; i++) {
      thingsList.add(BookDetailModel(
        title: sajuDailyService!.sajuDailyInfo.keyword[i].text,
        backgroundColor: ThemeSetting.of(context).extraGray,
        image: sajuDailyService!.sajuDailyInfo.keyword[i].emoji,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    List hashTag = sajuDailyService!.sajuDailyInfo.hashtag;

    List<String> myParts = user!.userModel.tenTwelve.picture.split("_");
    String myElementName = myParts[2];

    List<String> parts = sajuDailyService!.sajuDailyInfo.dailyGanji.split("_");
    String animalName = parts[1];
    String elementName = parts[2];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.getElementBgToColor(context, myElementName),
        appBar: HeaderWidget.headerBack(
          context: context,
          backgroundColor: Utils.getElementBgToColor(context, myElementName),
          onTap: () {
            context.goNamed(mainScreen);
          },
        ),
        body: Container(
          color: Utils.getElementBgToColor(context, myElementName),
          width: MediaQuery.of(context).size.width,
          child: ListView(
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
                        "assets/tarot/${user!.userModel.tenTwelve.picture}",
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
                          "assets/tarot/${sajuDailyService!.sajuDailyInfo.dailyGanji}",
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
