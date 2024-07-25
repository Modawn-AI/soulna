import 'package:Soulna/widgets/custom_switchtile_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';
import '../../utils/theme_setting.dart';
import '../../widgets/header/header_widget.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                LocaleKeys.information_about_events_and_benefits.tr(),
                style: ThemeSetting.of(context)
                    .captionLarge
                    .copyWith(color: ThemeSetting.of(context).grayLight),
              )
            ],
          ),
          CustomSwitchTile()
        ],
      )
    ],
          ),
        );
  }
}