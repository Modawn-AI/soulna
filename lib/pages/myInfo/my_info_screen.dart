import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/settings_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../utils/app_assets.dart';
import '../../widgets/header/header_widget.dart';

class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> settingList = [
      {
        'image': AppAssets.iconFortune,
        'title': LocaleKeys.past_fortune.tr(),
      },
      {
        'image': AppAssets.iconDiary,
        'title': LocaleKeys.past_diary.tr(),
      },
      {
        'image': AppAssets.iconNotice,
        'title': LocaleKeys.notice.tr(),
      },
      {
        'image': AppAssets.iconService,
        'title': LocaleKeys.customer_service.tr(),
      },
      {
        'image': AppAssets.iconTerm,
        'title': LocaleKeys.terms_and_conditions.tr(),
      },
      {
        'image': AppAssets.iconVersion,
        'title': LocaleKeys.version_information.tr(),
      },
    ];

    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerSettings(
          context: context, onTap: () => context.pushNamed('SettingsScreen')),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.asset(
                    width: 100.h,
                    height: 100.h,
                    AppAssets.user,
                    fit: BoxFit.cover,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppAssets.edit,
                      width: 30.w,
                      height: 30.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                "Stella",
                style: ThemeSetting.of(context).labelLarge.copyWith(
                      color: ThemeSetting.of(context).primaryText,
                    ),
              ),
              SizedBox(height: 4.h),
              Text(
                "October 7, 2002",
                style: ThemeSetting.of(context).bodyMedium.copyWith(
                      color: ThemeSetting.of(context).secondaryText,
                    ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: CustomButtonWidget(
                  text: "",
                  onPressed: () {},
                  textIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.iconInstagram,
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        LocaleKeys.connect_with_instagram.tr(),
                        style: ThemeSetting.of(context).bodyMedium.copyWith(
                              color: ThemeSetting.of(context).tertiaryText,
                            ),
                      ),
                    ],
                  ),
                  options: CustomButtonOptions(
                    elevation: 0,
                    height: 50.h,
                    color: ThemeSetting.of(context).primaryText,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
              ),
              Divider(
                color: ThemeSetting.of(context).common2,
                thickness: 3,
              ),
              SizedBox(height: 10,),
              ...List.generate(
                settingList.length,
                (index) {
                  return SettingsWidget(
                    onTap: () {},
                    image: settingList[index]['image'],
                    context: context,
                    title: settingList[index]['title'],
                    child: index == settingList.length - 1
                        ? Text(
                            "2.0 Ver",
                            style: ThemeSetting.of(context).bodyMedium.copyWith(
                                  color: ThemeSetting.of(context).primary,
                                ),
                          )
                        : Container(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}