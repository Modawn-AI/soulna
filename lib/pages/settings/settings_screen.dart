import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_dialog_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:Soulna/widgets/settings_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the SettingsScreen widget, which provides a screen for users to
//  Drawer -> settings icon
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> settingList = [
      {
        'image': AppAssets.iconAccount,
        'title': LocaleKeys.account_settings.tr(),
      },
      {
        'image': AppAssets.iconNotification,
        'title': LocaleKeys.notification_settings.tr(),
      },
    ];

    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithTitle(
          context: context, title: LocaleKeys.setting.tr()),
      body: Column(children: [
        ...List.generate(
          settingList.length,
          (index) {
            return SettingsWidget(
              onTap: () {
                if (index == 0) {
                  context.pushNamed(accountSettingScreen);
                } else if (index == 1) {
                  context.pushNamed(notificationSettings);
                }
              },
              image: settingList[index]['image'],
              context: context,
              title: settingList[index]['title'],
            );
          },
        ),
        Spacer(),
        ButtonWidget.borderButton(
          context: context,
          borderColor: ThemeSetting.of(context).common0,
          textColor: ThemeSetting.of(context).primary,
          text: LocaleKeys.log_out.tr(),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => CustomDialogWidget(
                context: context,
                title: LocaleKeys.log_out.tr(),
                content: LocaleKeys.are_you_sure_you_want_to_log_out.tr(),
                confirmText: LocaleKeys.log_out.tr(),
                onConfirm: () =>
                    Navigator.of(context).pushReplacementNamed('LoginScreen'),
              ),
            );
          },
        ),
        SizedBox(height: 40.h),
      ]),
    );
  }
}