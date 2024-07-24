import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupEmail extends StatefulWidget {
  final PageController controller;
  const SignupEmail({super.key, required this.controller});

  @override
  State<SignupEmail> createState() => _SignupEmailState();
}

class _SignupEmailState extends State<SignupEmail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithCustomAction(
          context: context,
          pageIndex: '2',
          percent: 0.50,
          onTap: () => widget.controller.animateToPage(0,
              duration: const Duration(microseconds: 300), curve: Curves.ease)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        children: [
          Text(
            LocaleKeys.please_enter_your_email.tr(),
            style: ThemeSetting.of(context).labelSmall,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.email.tr(),
            style: ThemeSetting.of(context)
                .captionLarge
                .copyWith(color: ThemeSetting.of(context).primary),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              controller: TextEditingController(),
              hintText: LocaleKeys.please_enter_your_email.tr(),
              suffix: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: ButtonWidget.roundedButtonOrange(
                    context: context,
                    height: 30,
                    text: LocaleKeys.confirm.tr(),
                    color: ThemeSetting.of(context).primaryText),
              )),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: TextEditingController(),
            hintText: LocaleKeys.enter_verification_code.tr(),
            suffix: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Text(
                '04:38',
                style: ThemeSetting.of(context)
                    .captionLarge
                    .copyWith(color: ThemeSetting.of(context).primary),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            LocaleKeys.enter_verification_code_des.tr(),
            style: ThemeSetting.of(context).captionMedium,
          ),
          const SizedBox(
            height: 85,
          ),
          ButtonWidget.gradientButton(
              context: context,
              text: LocaleKeys.next.tr(),
              color1: ThemeSetting.of(context).black1,
              color2: ThemeSetting.of(context).black2,
              onTap: () => widget.controller.animateToPage(2,
                  duration: Duration(microseconds: 300), curve: Curves.ease)),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}