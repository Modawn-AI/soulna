import '../utils/package_exporter.dart';

Future<TimeOfDay?> showCustomTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) => Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: TimePickerThemeData(
          dayPeriodTextColor: ThemeSetting.of(context).primaryText,
          dayPeriodColor: ThemeSetting.of(context).primary,
          dialHandColor: ThemeSetting.of(context).primary,
          dialBackgroundColor: ThemeSetting.of(context).secondaryBackground,
          entryModeIconColor: ThemeSetting.of(context).primary,
          hourMinuteTextColor: ThemeSetting.of(context).primaryText,
          hourMinuteColor: ThemeSetting.of(context).primary,
          // backgroundColor: ThemeSetting.of(context).secondaryBackground
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(ThemeSetting.of(context).primary),
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(ThemeSetting.of(context).primary),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: ThemeSetting.of(context).headlineLarge.copyWith(
              color: ThemeSetting.of(context).primary,
            ),
          ),
        ),
      ),
      child: child!,
    ),
  );
}