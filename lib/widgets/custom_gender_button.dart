import 'package:Soulna/generated/locale_keys.g.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/theme_setting.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'custom_button_widget.dart';

class CustomGenderToggleButton extends StatefulWidget {
  final Function(String) onGenderSelected;
  const CustomGenderToggleButton({super.key, required this.onGenderSelected});

  @override
  _CustomGenderToggleButtonState createState() => _CustomGenderToggleButtonState();
}

class _CustomGenderToggleButtonState extends State<CustomGenderToggleButton> {
  List<bool> isSelected = [false, false]; // Assuming 'Male' is selected by default

  void _selectGender(int index) {
    setState(() {
      isSelected = [index == 0, index == 1];
    });
    widget.onGenderSelected(index == 0 ? 'Male' : 'Female');
  }

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
                      LocaleKeys.man_text.tr(),
                      style: ThemeSetting.of(context).bodyMedium.copyWith(color: isSelected.first == true ? ThemeSetting.of(context).secondaryBackground : ThemeSetting.of(context).primaryText),
                    ),
                  ],
                ),
                onPressed: () => _selectGender(0),
                options: CustomButtonOptions(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: isSelected.first == false ? ThemeSetting.of(context).common0 : ThemeSetting.of(context).primary),
                    height: 56,
                    color: isSelected.first == false ? ThemeSetting.of(context).secondaryBackground : ThemeSetting.of(context).primary,
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
                      LocaleKeys.woman_text.tr(),
                      style: ThemeSetting.of(context).bodyMedium.copyWith(color: isSelected.last == true ? ThemeSetting.of(context).secondaryBackground : ThemeSetting.of(context).primaryText),
                    ),
                  ],
                ),
                onPressed: () => _selectGender(1),
                options: CustomButtonOptions(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: isSelected.last == false ? ThemeSetting.of(context).common0 : ThemeSetting.of(context).primary),
                    height: 56,
                    color: isSelected.last == false ? ThemeSetting.of(context).secondaryBackground : ThemeSetting.of(context).primary,
                    textStyle: ThemeSetting.of(context).headlineLarge))),
      ],
    );
  }
}
