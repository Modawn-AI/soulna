import 'dart:developer';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:Soulna/widgets/settings_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the DrawerScreen widget, which is used for the navigation drawer in the application.

class DrawerScreen {
  static Widget drawerWidget({
    required BuildContext context,
  }) {
    List<Map<String, dynamic>> settingList = [
      {
        'image': AppAssets.logo,
        'title': "My TenTwelve",
        'route': tenTwelveScreen,
      },
      {
        'image': AppAssets.iconFortune,
        'title': LocaleKeys.past_fortune.tr(),
        'route': pastFortuneScreen,
      },
      {
        'image': AppAssets.iconDiary,
        'title': LocaleKeys.past_diary.tr(),
        'route': pastDiary,
      },
      {
        'image': AppAssets.iconNotice,
        'title': LocaleKeys.notice.tr(),
        'route': noticeScreen,
      },
      {
        'image': AppAssets.iconService,
        'title': LocaleKeys.customer_service.tr(),
        'route': customerService,
      },
      {
        'image': AppAssets.iconTerm,
        'title': LocaleKeys.terms_and_conditions.tr(),
        'route': termAndConditions,
      },
      {
        'image': AppAssets.iconVersion,
        'title': LocaleKeys.version_information.tr(),
        'route': '',
      },
    ];

    return Container(
      alignment: Alignment.center,
      color: ThemeSetting.of(context).secondaryBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeaderWidget.headerSettings(
            onTapOnMenu: () => context.pop(),
            context: context,
            onTap: () => context.pushNamed(settingsScreen),
          ),
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
                onTap: () => context.pushNamed(editProfile),
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
                    color: Colors.white,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    LocaleKeys.connect_with_instagram.tr(),
                    style: ThemeSetting.of(context).bodyMedium.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              options: CustomButtonOptions(
                elevation: 0,
                height: 50.h,
                color: Colors.black,
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
          ),
          const CustomDividerWidget(),
          const SizedBox(
            height: 10,
          ),
          ...List.generate(
            settingList.length,
            (index) {
              return SettingsWidget(
                onTap: () {
                  if (index != settingList.length - 1) {
                    log(settingList[index]['route']);
                    context.pushNamed("${settingList[index]['route']}");
                  }
                },
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
          ),
        ],
      ),
    );
  }
}
