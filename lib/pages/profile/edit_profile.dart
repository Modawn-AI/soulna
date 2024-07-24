import 'package:Soulna/generated/locale_keys.g.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/widgets/custom_gender_button.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_setting.dart';
import '../../widgets/button/button_widget.dart';

class EditProfile extends StatefulWidget {

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ThemeSetting.of(context).secondaryBackground,
          appBar: HeaderWidget.headerWithTitle(
              context: context,
             title: LocaleKeys.edit_profile.tr()
             ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    width: 100,
                    height: 100,
                    AppAssets.user,
                    fit: BoxFit.cover,

                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppAssets.camera,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
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
                height: 40,
              ),
              Text(
                LocaleKeys.date_of_birth.tr(),
                style: ThemeSetting.of(context)
                    .captionLarge
                    .copyWith(color: ThemeSetting.of(context).primary),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: TextEditingController(),
                hintText: 'January 1st, 1990',
                onTap: () {

                },
                readOnly: true,
                suffix: const Icon(Icons.keyboard_arrow_right),
              ),
              const SizedBox(
                height: 70,
              ),

              ButtonWidget.roundedButtonOrange(
                  context: context,
                  color: ThemeSetting.of(context).primaryText,
                  text: LocaleKeys.save.tr(),

                  onTap: () {}),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}