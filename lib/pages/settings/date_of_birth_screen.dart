import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_checkbox_widget.dart';
import 'package:Soulna/widgets/custom_ios_date_picker.dart';
import 'package:Soulna/widgets/custom_time_range_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the DateOfBirthScreen widget, which provides a screen for users to enter or update their date of birth.
//Drawer -> edit icon -> set date of birth

class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen({super.key});

  @override
  State<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  DateTime selectedDate = DateTime(1990, 1, 1);
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerBack(
        context: context,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),

          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.please_set_your_date_of_birth.tr(),
              style: ThemeSetting.of(context).labelSmall.copyWith(
                    color: ThemeSetting.of(context).primaryText,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomDatePicker(
              onDateSelected: (data) {},
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              LocaleKeys.time.tr(),
              style: ThemeSetting.of(context).captionMedium.copyWith(
                    color: ThemeSetting.of(context).primary,
                  ),
            ),
            const SizedBox(height: 10),
            CustomRangeTimePicker(
              initialStartTime: const TimeOfDay(hour: 9, minute: 0),
              initialEndTime: const TimeOfDay(hour: 17, minute: 0),
              onStartTimeChanged: (startTime) {
                print("Start Time: ${startTime.format(context)}");
              },
              onEndTimeChanged: (endTime) {
                print("End Time: ${endTime.format(context)}");
              },
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
              child: Row(
                children: [
                  CustomCheckbox(
                    initialValue: isChecked,
                    showIcon: isChecked,
                    onChanged: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                  ),
                  Text(
                    LocaleKeys.dont_know_my_time.tr(),
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                          color: ThemeSetting.of(context).primaryText,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 180,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: ButtonWidget.roundedButtonOrange(
                  context: context,
                  color: ThemeSetting.of(context).black2,
                  text: LocaleKeys.save.tr(),
                  onTap: () {
                    context.pop();
                    // SharedPreferences.getInstance();
                    // SharedPreferencesManager.setString(
                    //     key: SharedprefString.animationScreen,
                    //     value: bookDetailScreen);
                    //context.pushReplacementNamed(animationScreen);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomDatePicker extends StatefulWidget {
//   final DateTime initialDate;
//   final DateTime minimumDate;
//   final DateTime maximumDate;
//   final ValueChanged<DateTime> onDateTimeChanged;
//
//   const CustomDatePicker({
//     required this.initialDate,
//     required this.minimumDate,
//     required this.maximumDate,
//     required this.onDateTimeChanged,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _CustomDatePickerState createState() => _CustomDatePickerState();
// }
//
// class _CustomDatePickerState extends State<CustomDatePicker> {
//   late int selectedDay;
//   late int selectedMonth;
//   late int selectedYear;
//
//   final List<String> monthNames = [
//     'January',
//     'February',
//     'March',
//     'April',
//     'May',
//     'June',
//     'July',
//     'August',
//     'September',
//     'October',
//     'November',
//     'December'
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     selectedDay = widget.initialDate.day;
//     selectedMonth = widget.initialDate.month;
//     selectedYear = widget.initialDate.year;
//   }
//
//   List<int> _generateDays(int month, int year) {
//     int daysInMonth = DateTime(year, month + 1, 0).day;
//     return List<int>.generate(daysInMonth, (index) => index + 1);
//   }
//
//   List<int> _generateYears() {
//     return List<int>.generate(
//       widget.maximumDate.year - widget.minimumDate.year + 1,
//       (index) => widget.minimumDate.year + index,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildPicker(
//               context,
//               List<int>.generate(12, (index) => index + 1),
//               selectedMonth,
//               (value) {
//                 setState(() {
//                   selectedMonth = value;
//                   widget.onDateTimeChanged(
//                       DateTime(selectedYear, selectedMonth, selectedDay));
//                 });
//               },
//               isMonth: true,
//             ),
//             _buildPicker(
//               context,
//               _generateDays(selectedMonth, selectedYear),
//               selectedDay,
//               (value) {
//                 setState(() {
//                   selectedDay = value;
//                   widget.onDateTimeChanged(
//                       DateTime(selectedYear, selectedMonth, selectedDay));
//                 });
//               },
//             ),
//             _buildPicker(
//               context,
//               _generateYears(),
//               selectedYear,
//               (value) {
//                 setState(() {
//                   selectedYear = value;
//                   widget.onDateTimeChanged(
//                       DateTime(selectedYear, selectedMonth, selectedDay));
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPicker(BuildContext context, List<int> items, int selectedItem,
//       ValueChanged<int> onSelectedItemChanged,
//       {bool isMonth = false}) {
//     return Expanded(
//       child: ListWheelScrollView.useDelegate(
//         controller: FixedExtentScrollController(
//             initialItem: items.indexOf(selectedItem)),
//         itemExtent: 30,
//         perspective: 0.005,
//         diameterRatio: 1.2,
//         physics: const FixedExtentScrollPhysics(),
//         onSelectedItemChanged: (index) => onSelectedItemChanged(items[index]),
//         childDelegate: ListWheelChildBuilderDelegate(
//           builder: (context, index) {
//             return Center(
//               child: Text(
//                 isMonth
//                     ? monthNames[items[index] - 1]
//                     : items[index].toString(),
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: items[index] == selectedItem
//                       ? Colors.blueAccent
//                       : Colors.black,
//                 ),
//               ),
//             );
//           },
//           childCount: items.length,
//         ),
//       ),
//     );
//   }
// }
//
// class RangeTimePicker extends StatefulWidget {
//   final TimeOfDay initialStartTime;
//   final TimeOfDay initialEndTime;
//   final ValueChanged<TimeOfDay> onStartTimeChanged;
//   final ValueChanged<TimeOfDay> onEndTimeChanged;
//
//   const RangeTimePicker({
//     required this.initialStartTime,
//     required this.initialEndTime,
//     required this.onStartTimeChanged,
//     required this.onEndTimeChanged,
//     super.key,
//   });
//
//   @override
//   _RangeTimePickerState createState() => _RangeTimePickerState();
// }
//
// class _RangeTimePickerState extends State<RangeTimePicker> {
//   late TimeOfDay startTime;
//   late TimeOfDay endTime;
//
//   @override
//   void initState() {
//     super.initState();
//     startTime = widget.initialStartTime;
//     endTime = widget.initialEndTime;
//   }
//
//   Future<void> _selectTimeRange(BuildContext context) async {
//     final TimeOfDay? pickedStartTime = await showCustomTimePicker(
//       context: context,
//       initialTime: startTime,
//     );
//     if (pickedStartTime != null) {
//       final TimeOfDay? pickedEndTime = await showCustomTimePicker(
//         context: context,
//         initialTime: endTime,
//       );
//       if (pickedEndTime != null && pickedEndTime != pickedStartTime) {
//         setState(() {
//           startTime = pickedStartTime;
//           endTime = pickedEndTime;
//           widget.onStartTimeChanged(startTime);
//           widget.onEndTimeChanged(endTime);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50.h,
//       decoration: BoxDecoration(
//         border: Border.all(color: ThemeSetting.of(context).common0),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: GestureDetector(
//         onTap: () => _selectTimeRange(context),
//         child: Row(
//           children: [
//             Text(
//               "   ${startTime.format(context)} ~ ${endTime.format(context)}",
//               style: ThemeSetting.of(context).headlineLarge.copyWith(
//                     color: ThemeSetting.of(context).primaryText,
//                   ),
//             ),
//             const Spacer(),
//             IconButton(
//               onPressed: () => _selectTimeRange(context),
//               icon: const Icon(Icons.keyboard_arrow_down),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
