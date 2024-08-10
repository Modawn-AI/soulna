import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/generated/locale_keys.g.dart';
import 'package:Soulna/utils/nav.dart';
import 'package:Soulna/utils/theme_setting.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/custom_validator_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

//This file defines the SignUpPassword widget, which collects the user's password during the sign-up process.
//step 3
class SignUpPassword extends StatefulWidget {
  const SignUpPassword({
    super.key,
  });

  @override
  State<SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  final _formKey = GlobalKey<FormState>();
  final authCon = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithCustomAction(
        context: context,
        pageIndex: '3',
        percent: 0.75,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
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
                style: ThemeSetting.of(context).captionLarge.copyWith(color: ThemeSetting.of(context).primary),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: authCon.passwordCon.value,
                hintText: LocaleKeys.enter_your_password.tr(),
                validator: CustomValidatorWidget.validatePassword(value: authCon.passwordCon.value.text),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: authCon.newPasswordCon.value,
                hintText: LocaleKeys.enter_your_new_password.tr(),
                inputAction: TextInputAction.done,
                validator: CustomValidatorWidget.validatePassword(value: authCon.newPasswordCon.value.text),
              ),
              const SizedBox(
                height: 150,
              ),
              ButtonWidget.gradientButton(
                  context: context,
                  text: LocaleKeys.next.tr(),
                  color1: ThemeSetting.of(context).black1,
                  color2: ThemeSetting.of(context).black2,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      context.pushNamed(signUpAdditionalInfo);
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
