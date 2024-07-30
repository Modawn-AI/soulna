import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';


class CreateDairyBottomSheet {
  static createDairyBottomSheet({required BuildContext context}) {
    return showModalBottomSheet(
      elevation: 1,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
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
                    squareWidget(image: AppAssets.rectangle, context: context),
                    const SizedBox(
                      width: 8,
                    ),
                    squareWidget(
                        image: AppAssets.rectangle,
                        width: 150,
                        context: context),
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
                    squareWidget(
                        image: AppAssets.rectangle,
                        width: 150,
                        context: context),
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
                    squareWidget(
                        image: AppAssets.rectangle,
                        width: 150,
                        context: context),
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
                    onTap: () {
                      SharedPreferencesManager.setString(
                          key: SharedprefString.animationScreen,
                          value: autobiographyScreen);
                      context.pushReplacementNamed(animationScreen);
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

  static Widget squareWidget(
      {required String image, double? width, required BuildContext context}) {
    return Container(
      width: width ?? 80,
      height: 80,
      decoration: BoxDecoration(
          border: Border.all(color: ThemeSetting.of(context).black1),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image))),
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