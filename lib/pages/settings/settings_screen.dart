import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../widgets/header/header_widget.dart';
import '../../widgets/settings_widget.dart';

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
      appBar: HeaderWidget.headerWithTitle(context: context, title: LocaleKeys.setting.tr()),
      body: Column(
          children: List.generate(
        settingList.length,
        (index) {
          return SettingsWidget(
            onTap: () {},
            image: settingList[index]['image'],
            context: context,
            title: settingList[index]['title'],
          );
        },
      )),
    );
  }
}