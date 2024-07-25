import 'dart:developer';

import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/generated/locale_keys.g.dart';
import 'package:Soulna/utils/nav.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/custom_gender_button.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/custom_validator_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import 'package:get/instance_manager.dart';

import '../../utils/theme_setting.dart';
import '../../widgets/button/button_widget.dart';

class SignUpAdditionalInfo extends StatefulWidget {
  const SignUpAdditionalInfo({super.key});

  @override
  State<SignUpAdditionalInfo> createState() => _SignUpAdditionalInfoState();
}

class _SignUpAdditionalInfoState extends State<SignUpAdditionalInfo> {
  final _formKey = GlobalKey<FormState>();
  var authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: ThemeSetting.of(context).secondaryBackground,
          appBar: HeaderWidget.headerWithCustomAction(
    context: context,
    pageIndex: '4',
    percent: 1.0,
          ),
          body: Form(
    key: _formKey,
    child: ListView(
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
          controller: authCon.nameCon.value,
          hintText: LocaleKeys.enter_your_name.tr(),
          validator: CustomValidatorWidget.validateName(
              value: authCon.nameCon.value.text),
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
        CustomGenderToggleButton(
          onGenderSelected: (p0) {
            authCon.genderSelection.value = p0;
          },
        ),
        const SizedBox(
          height: 70,
        ),
        ButtonWidget.gradientButtonWithImage(
            context: context,
            text: LocaleKeys.finish.tr(),
            onTap: () {
              log('Enter');
              if (_formKey.currentState!.validate()) {
                log('Gender: ${authCon.genderSelection.value}');
                FocusScope.of(context).unfocus();
                if (authCon.genderSelection.value != '') {
                } else {
                  Get.showSnackbar(
                    const GetSnackBar(
                      title: 'Gender',

                      message: 'Please select gender',
                    ),
                  );
                }
              }
            }),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
          ),
        );
  }
}