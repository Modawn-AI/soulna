import '../utils/package_exporter.dart';

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

  showTimeDialog({ required BuildContext context,
    required TimeOfDay initialTime,}) {
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
            hourMinuteTextColor: ThemeSetting.of(context).secondaryBackground,
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
  Future<void> _selectTimeRange(BuildContext context) async {
    final TimeOfDay? pickedStartTime = await showTimeDialog(
      context: context,
      initialTime: startTime,
    );
    if (pickedStartTime != null) {
      final TimeOfDay? pickedEndTime = await showTimeDialog(
        context: context,
        initialTime: endTime,
      );
      if (pickedEndTime != null && pickedEndTime != pickedStartTime) {
        setState(() {
          startTime = pickedStartTime;
          endTime = pickedEndTime;
          widget.onStartTimeChanged(startTime);
          widget.onEndTimeChanged(endTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: ThemeSetting.of(context).common0),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: GestureDetector(
        onTap: () => _selectTimeRange(context),
        child: Row(
          children: [
            Text(
              "   ${startTime.format(context)} ~ ${endTime.format(context)}",
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