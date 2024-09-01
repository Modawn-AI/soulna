import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_dialog_widget.dart';
import 'package:Soulna/widgets/custom_switchtile_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:Soulna/widgets/settings_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:package_info_plus/package_info_plus.dart';

// This file defines the SettingsScreen widget, which provides a screen for users to
//  Drawer -> settings icon
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currentLanguage = 'en'; // Default language

  final Map<String, String> _languages = {
    'en': 'English',
    'ko': '한국어',
    'ja': '日本語',
    'zh': '中文',
  };

  String version = "";

  @override
  void initState() {
    super.initState();
    initVersionInfo();
  }

  Future<void> initVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
    debugPrint("version: ${packageInfo.version}");
  }

  void _changeLanguage(String? languageCode) {
    if (languageCode != null && languageCode != _currentLanguage) {
      setState(() {
        _currentLanguage = languageCode;
      });
      context.setLocale(Locale(languageCode));
    }
  }

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
      appBar: HeaderWidget.headerWithTitle(context: context, title: LocaleKeys.setting_text.tr()),
      body: SafeArea(
        child: Column(children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.mode_night_outlined,
                  size: 26,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(LocaleKeys.dark_mode.tr(),
                    style: ThemeSetting.of(context).bodyMedium.copyWith(
                          color: ThemeSetting.of(context).primaryText,
                          fontSize: 16,
                        )),
                const Spacer(),
                CustomSwitchTile(
                  initialValue: ThemeSetting.isLightTheme(context) ? false : true,
                  onChanged: (bool value) {
                    setState(() {
                      ThemeSetting.changeTheme(context);
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.language_outlined,
                  size: 26,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(LocaleKeys.dark_mode.tr(), // language_setting
                    style: ThemeSetting.of(context).bodyMedium.copyWith(
                          color: ThemeSetting.of(context).primaryText,
                          fontSize: 16,
                        )),
                const Spacer(),
                DropdownButton<String>(
                  value: _currentLanguage,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: ThemeSetting.of(context).bodyMedium.copyWith(
                        color: ThemeSetting.of(context).primaryText,
                      ),
                  underline: Container(
                    height: 2,
                    color: ThemeSetting.of(context).primaryColor,
                  ),
                  onChanged: _changeLanguage,
                  items: _languages.entries.map<DropdownMenuItem<String>>((MapEntry<String, String> entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SettingsWidget(
            onTap: () {},
            image: AppAssets.iconVersion,
            context: context,
            title: LocaleKeys.version_information.tr(),
            child: Text(
              "Ver $version",
              style: ThemeSetting.of(context).bodyMedium.copyWith(
                    color: ThemeSetting.of(context).primary,
                  ),
            ),
          ),
          const Spacer(),
          ButtonWidget.borderButton(
            context: context,
            borderColor: ThemeSetting.of(context).common0,
            textColor: ThemeSetting.of(context).primary,
            text: LocaleKeys.logout_text.tr(),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CustomDialogWidget(
                  context: context,
                  title: LocaleKeys.logout_text.tr(),
                  content: LocaleKeys.you_want_to_log_out.tr(),
                  confirmText: LocaleKeys.logout_text.tr(),
                  onConfirm: () => Navigator.of(context).pushReplacementNamed('LoginScreen'),
                ),
              );
            },
          ),
          SizedBox(height: 40.h),
        ]),
      ),
    );
  }
}
