import 'package:Soulna/generated/locale_keys.g.dart';
import 'package:Soulna/widgets/custom_gender_button.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_setting.dart';
import '../../widgets/button/button_widget.dart';

class SignUpAdditionalInfo extends StatefulWidget {
  final PageController controller;
  const SignUpAdditionalInfo({super.key, required this.controller});

  @override
  State<SignUpAdditionalInfo> createState() => _SignUpAdditionalInfoState();
}

class _SignUpAdditionalInfoState extends State<SignUpAdditionalInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithCustomAction(
          context: context,
          pageIndex: '4',
          percent: 1.0,
          onTap: () => widget.controller.animateToPage(2,
              duration: Duration(microseconds: 300), curve: Curves.ease)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        children: [
          Text(
            LocaleKeys.please_enter_additional_information.tr(),
            style: ThemeSetting.of(context).labelSmall,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.name.tr(),
            style: ThemeSetting.of(context)
                .captionLarge
                .copyWith(color: ThemeSetting.of(context).primary),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: TextEditingController(),
            hintText: LocaleKeys.enter_your_name.tr(),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.gender.tr(),
            style: ThemeSetting.of(context)
                .captionLarge
                .copyWith(color: ThemeSetting.of(context).primary),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomGenderToggleButton(),
          const SizedBox(
            height: 70,
          ),

          ButtonWidget.gradientButtonWithImage(
              context: context,
              text: LocaleKeys.finish.tr(),

              onTap: () => widget.controller.animateToPage(3,
                  duration: Duration(microseconds: 300), curve: Curves.ease)),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}