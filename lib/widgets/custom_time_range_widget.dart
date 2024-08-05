import 'package:Soulna/utils/package_exporter.dart';

class CustomRangeTimePicker extends StatefulWidget {
  final TimeOfDay initialStartTime;
  final TimeOfDay initialEndTime;
  final ValueChanged<TimeOfDay> onStartTimeChanged;
  final ValueChanged<TimeOfDay> onEndTimeChanged;

  const CustomRangeTimePicker({
    required this.initialStartTime,
    required this.initialEndTime,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    super.key,
  });

  @override
  _CustomRangeTimePickerState createState() => _CustomRangeTimePickerState();
}

class _CustomRangeTimePickerState extends State<CustomRangeTimePicker> {
  late TimeOfDay startTime;
  late TimeOfDay endTime;

  @override
  void initState() {
    super.initState();
    startTime = widget.initialStartTime;
    endTime = widget.initialEndTime;
  }

  showTimeDialog({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: ThemeSetting.of(context).secondaryBackground,
              dayPeriodTextColor: ThemeSetting.of(context).primaryText,
              dayPeriodColor: ThemeSetting.of(context).primary,
              dialHandColor: ThemeSetting.of(context).primary,

              // entryModeIconColor: ThemeSetting.of(context).primary,
              hourMinuteTextColor: ThemeSetting.of(context).primaryText,
              hourMinuteColor: ThemeSetting.of(context).secondaryBackground,
              // backgroundColor: ThemeSetting.of(context).secondaryBackground,
              cancelButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                    ThemeSetting.of(context).primary),
              ),
              confirmButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                    ThemeSetting.of(context).primary),
              ),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: ThemeSetting.of(context).headlineLarge.copyWith(
                      color: ThemeSetting.of(context).white,
                    ),
              ),
            ),
            primaryColor: ThemeSetting.of(context).secondaryBackground),
        child: child!,
      ),
    );
  }

  Future<void> _selectTimeRange(BuildContext context) async {
    final TimeOfDay? pickedStartTime = await showTimeDialog(
      context: context,
      initialTime: startTime,
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime;
      //   final TimeOfDay? pickedEndTime = await showTimeDialog(
      //     context: context,
      //     initialTime: endTime,
    }
    // if (pickedEndTime != null && pickedEndTime != pickedStartTime) {
    //   setState(() {
    //     startTime = pickedStartTime;
    //     endTime = pickedEndTime;
    //     widget.onStartTimeChanged(startTime);
    //     widget.onEndTimeChanged(endTime);
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: ThemeSetting.isLightTheme(context)
            ? ThemeSetting.of(context).secondaryBackground
            : ThemeSetting.of(context).common2,
        border: Border.all(
            color: ThemeSetting.isLightTheme(context)
                ? ThemeSetting.of(context).common0
                : ThemeSetting.of(context).common2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: GestureDetector(
        onTap: () => _selectTimeRange(context),
        child: Row(
          children: [
            Text(
              "   ${startTime.format(context)}",
              //"   ${startTime.format(context)} ~ ${endTime.format(context)}",
              style: ThemeSetting.of(context).headlineLarge.copyWith(
                    color: ThemeSetting.of(context).primaryText,
                  ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => _selectTimeRange(context),
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
          ],
        ),
      ),
    );
  }
}