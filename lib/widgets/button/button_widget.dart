import 'dart:ui';

import 'package:Soulna/utils/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/package_exporter.dart';

class ButtonWidget {
  static Widget orangeBorderButton({
    required BuildContext context,
    required String text,
    required VoidCallback onTap,
  }) {
    return CustomButtonWidget(
        text: text,
        onPressed: onTap,
        options: CustomButtonOptions(
            borderRadius: BorderRadius.circular(30),
            height: 34,
            borderSide: BorderSide(color: ThemeSetting.of(context).primary),
            color: ThemeSetting.of(context).secondaryBackground,
            textStyle: ThemeSetting.of(context).captionLarge));
  }

  static Widget borderButton(
      {required BuildContext context,
      required String text,
      Color? textColor,
      Color? borderColor,
      required VoidCallback onTap}) {
    return CustomButtonWidget(
        text: text,
        onPressed: onTap,
        options: CustomButtonOptions(
            borderRadius: BorderRadius.circular(30),
            height: 36,
            borderSide: BorderSide(
                color: borderColor ?? ThemeSetting.of(context).primary),
            color: ThemeSetting.of(context).secondaryBackground,
            textStyle: ThemeSetting.of(context)
                .captionLarge
                .copyWith(color: textColor)));
  }

  static squareButtonOrange(
          {required BuildContext context,
          required String text,
          VoidCallback? onTap}) =>
      CustomButtonWidget(
          text: text,
          onPressed: onTap,
          options: CustomButtonOptions(
              borderRadius: BorderRadius.circular(8),
              height: 56,
              color: ThemeSetting.of(context).primary,
              textStyle: ThemeSetting.of(context).headlineLarge));

  static roundedButtonOrange(
          {required BuildContext context,
          required String text,
          VoidCallback? onTap,
          Color? color,
            double? height,
          BorderRadius? borderRadius}) =>
      CustomButtonWidget(
          text: text,
          onPressed: onTap,
          options: CustomButtonOptions(
              borderRadius: borderRadius ?? BorderRadius.circular(50),
              height:height ?? 56,
              color: color ?? ThemeSetting.of(context).primary,
              textStyle: ThemeSetting.of(context).headlineLarge));

  static gradientButton(
          {required BuildContext context,
          required String text,
          VoidCallback? onTap,
          required Color color1,
          required Color color2}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              color1,
              color2,
            ]),
            color: ThemeSetting.of(context).primary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(text, style: ThemeSetting.of(context).headlineLarge),
        ),
      );

  static gradientButtonWithImage({
    required BuildContext context,
    required String text,
    VoidCallback? onTap,
  }) =>
      Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            ThemeSetting.of(context).black1,
            ThemeSetting.of(context).black2,
          ]),
          color: ThemeSetting.of(context).primary,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: ThemeSetting.of(context).headlineLarge),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              AppAssets.start,
              width: 14,
              height: 14,
            )
          ],
        ),
      );

  static roundedButtonGrey(
          {required BuildContext context,
          required String text,
          VoidCallback? onTap,
          BorderRadius? borderRadius}) =>
      CustomButtonWidget(
          text: text,
          onPressed: onTap,
          options: CustomButtonOptions(
              borderRadius: borderRadius ?? BorderRadius.circular(50),
              height: 56,
              borderSide: BorderSide(color: ThemeSetting.of(context).common1),
              color: ThemeSetting.of(context).common3,
              textStyle: ThemeSetting.of(context)
                  .headlineLarge
                  .copyWith(color: ThemeSetting.of(context).primaryText)));
}