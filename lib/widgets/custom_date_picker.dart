import 'package:flutter/material.dart';

import '../utils/theme_setting.dart';

Future<DateTime?> showCustomDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (context, child) => Theme(
      data: Theme.of(context).copyWith(
        datePickerTheme: DatePickerThemeData(
          surfaceTintColor: ThemeSetting.of(context).secondaryBackground,
          backgroundColor: ThemeSetting.of(context).secondaryBackground,
          headerBackgroundColor: ThemeSetting.of(context).primary,
          headerForegroundColor: ThemeSetting.of(context).primaryText,
          dayOverlayColor: WidgetStateProperty.all<Color>(ThemeSetting.of(context).primary),
          todayBackgroundColor: WidgetStateProperty.all<Color>(ThemeSetting.of(context).primary),
          todayBorder: BorderSide(color: ThemeSetting.of(context).primary),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(ThemeSetting.of(context).primary),
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(ThemeSetting.of(context).primary),
          ),
        ),
      ),
      child: child!,
    ),
  );
}