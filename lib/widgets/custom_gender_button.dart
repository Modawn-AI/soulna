import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../generated/locale_keys.g.dart';
import '../utils/theme_setting.dart';
import 'custom_button_widget.dart';

class CustomGenderToggleButton extends StatefulWidget {
  const CustomGenderToggleButton({super.key});

  @override
  _CustomGenderToggleButtonState createState() =>
      _CustomGenderToggleButtonState();
}

class _CustomGenderToggleButtonState extends State<CustomGenderToggleButton> {
  List<bool> isSelected = [
    true,
    false
  ]; // Assuming 'Male' is selected by default

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: CustomButtonWidget(
                text: 'text',
                textIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.man,
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      LocaleKeys.man.tr(),
                      style: ThemeSetting.of(context).bodyMedium.copyWith(
                          color: isSelected.first == true
                              ? ThemeSetting.of(context).secondaryBackground
                              : ThemeSetting.of(context).primaryText),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    isSelected = [true, false];
                  });
                },
                options: CustomButtonOptions(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isSelected.first == false
                            ? ThemeSetting.of(context).common0
                            : ThemeSetting.of(context).primary),
                    height: 56,
                    color: isSelected.first == false
                        ? ThemeSetting.of(context).secondaryBackground
                        : ThemeSetting.of(context).primary,
                    textStyle: ThemeSetting.of(context).headlineLarge))),
        const SizedBox(width: 8), // Spacing between buttons
        Expanded(
            child: CustomButtonWidget(
                text: 'text',
                textIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.woman,
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      LocaleKeys.woman.tr(),
                      style: ThemeSetting.of(context).bodyMedium.copyWith(
                          color: isSelected.last == true
                              ? ThemeSetting.of(context).secondaryBackground
                              : ThemeSetting.of(context).primaryText),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    isSelected = [false, true];
                  });
                },
                options: CustomButtonOptions(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isSelected.last == false
                            ? ThemeSetting.of(context).common0
                            : ThemeSetting.of(context).primary),
                    height: 56,
                    color: isSelected.last == false
                        ? ThemeSetting.of(context).secondaryBackground
                        : ThemeSetting.of(context).primary,
                    textStyle: ThemeSetting.of(context).headlineLarge))),
      ],
    );
  }
}