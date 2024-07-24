import 'package:Soulna/generated/locale_keys.g.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_setting.dart';

class SignUpPassword extends StatefulWidget {
  final PageController controller;
  const SignUpPassword({super.key, required this.controller});

  @override
  State<SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithCustomAction(
          context: context,
          pageIndex: '3',
          percent: 0.75,
          onTap: () => widget.controller.animateToPage(1,
              duration: Duration(microseconds: 300), curve: Curves.ease)),
      body:ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        children: [
          Text(
            LocaleKeys.please_enter_your_password.tr(),
            style: ThemeSetting.of(context).labelSmall,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.password.tr(),
            style: ThemeSetting.of(context)
                .captionLarge
                .copyWith(color: ThemeSetting.of(context).primary),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              controller: TextEditingController(),
              hintText: LocaleKeys.enter_your_password.tr(),
              ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: TextEditingController(),
            hintText: LocaleKeys.enter_your_new_password.tr(),

          ),

          const SizedBox(
            height: 150,
          ),
          ButtonWidget.gradientButton(
              context: context,
              text: LocaleKeys.next.tr(),
              color1: ThemeSetting.of(context).black1,
              color2: ThemeSetting.of(context).black2,
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