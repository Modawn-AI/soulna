import 'package:Soulna/generated/locale_keys.g.dart';
import 'package:Soulna/utils/theme_setting.dart';
import 'package:Soulna/widgets/custom_switchtile_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// This file defines the NotificationSettings widget, which is used for the notification settings screen.

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        appBar: HeaderWidget.headerWithTitle(
          context: context,
          title: LocaleKeys.notification_settings.tr(),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.marketing_notifications.tr(),
                      style: ThemeSetting.of(context).bodyMedium,
                    ),
                    Text(
                      LocaleKeys.information_about_events_and_benefits.tr(), // information_about_events
                      style: ThemeSetting.of(context).captionLarge.copyWith(color: ThemeSetting.of(context).grayLight),
                    )
                  ],
                ),
                CustomSwitchTile(
                  initialValue: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
