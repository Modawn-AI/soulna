// import 'package:flutter/material.dart';
// import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
//
// import '../../utils/theme_setting.dart';
//
// class PastFortuneCalenderViewScreen extends StatelessWidget {
//   final List<NeatCleanCalendarEvent> _eventList = [
//     NeatCleanCalendarEvent('MultiDay Event A',
//         startTime: DateTime(DateTime.now().year, DateTime.now().month,
//             DateTime.now().day, 10, 0),
//         endTime: DateTime(DateTime.now().year, DateTime.now().month,
//             DateTime.now().day + 2, 12, 0),
//         color: Colors.orange,
//         isMultiDay: true),
//     NeatCleanCalendarEvent('Allday Event B',
//         startTime: DateTime(DateTime.now().year, DateTime.now().month,
//             DateTime.now().day - 2, 14, 30),
//         endTime: DateTime(DateTime.now().year, DateTime.now().month,
//             DateTime.now().day + 2, 17, 0),
//         color: Colors.pink,
//         isAllDay: true),
//     NeatCleanCalendarEvent('Normal Event D',
//         startTime: DateTime(DateTime.now().year, DateTime.now().month,
//             DateTime.now().day, 14, 30),
//         endTime: DateTime(DateTime.now().year, DateTime.now().month,
//             DateTime.now().day, 17, 0),
//         color: Colors.indigo),
//   ];
//   PastFortuneCalenderViewScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ThemeSetting.of(context).secondaryBackground,
//       body: Calendar(
//         startOnMonday: true,
//         weekDays: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
//         isExpandable: true,
//         eventDoneColor: Colors.green,
//         selectedColor: Colors.pink,
//         selectedTodayColor: Colors.red,
//         todayColor: Colors.blue,
//         eventColor: null,
//         eventsList: _eventList,
//         isExpanded: true,
//         expandableDateFormat: 'EEEE, dd. MMMM yyyy',
//         datePickerType: DatePickerType.date,
//         dayOfWeekStyle: TextStyle(
//             color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
//       ),
//     );
//   }
// }