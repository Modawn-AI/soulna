import 'dart:developer';

import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';

class CustomCalendarWidget extends StatelessWidget {
  final List<NeatCleanCalendarEvent> eventsList;
  final Widget? showEventWidget;
  final DateTime? initialDate;
  const CustomCalendarWidget(
      {super.key,
      required this.eventsList,
      this.showEventWidget,
      this.initialDate});

  @override
  Widget build(BuildContext context) {
    final authCon = Get.put(AuthController());
    return Calendar(
      startOnMonday: false,
      hideTodayIcon: true,
      hideBottomBar: false,
      hideArrows: true,
      weekDays: const ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
      // initialDate: authCon.selectedDate.value,

      // dayOfWeekStyle: TextStyle(
      //     color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),

      defaultDayColor: ThemeSetting.of(context).primaryText,
      isExpanded: true,
      eventDoneColor: ThemeSetting.of(context).primary,
      selectedColor: ThemeSetting.of(context).primary,
      selectedTodayColor: ThemeSetting.of(context).primary,
      todayColor: ThemeSetting.of(context).primary,
      eventColor: ThemeSetting.of(context).primary,
      eventsList: eventsList,
      // eventTileHeight: 00,

      onMonthChanged: (value) {
        log('value $value');
        authCon.selectedDate.value = value;
      },
      onDateSelected: (value) {
        log('value $value');
        authCon.selectedDate.value = value;
      },

      initialDate: authCon.selectedDate.value,
      bottomBarArrowColor: Colors.transparent,
      bottomBarColor: Colors.transparent,
      //bottomBarTextStyle: const TextStyle(color: Colors.redAccent),
      eventListBuilder: (context, events) {
        return Expanded(
          child: Column(
            children: [
              const SizedBox(
                height: 23,
              ),
              Divider(
                color: ThemeSetting.of(context).common0,
                thickness: 2,
              ),
              Expanded(child: showEventWidget ?? Container()),
            ],
          ),
        );
      },
      displayMonthTextStyle:
      ThemeSetting.of(context).bodyMedium.copyWith(color: Colors.transparent),
      //expandableDateFormat: 'EEEE, dd. MMMM yyyy',
      //datePickerType: DatePickerType.date,
      dayOfWeekStyle: ThemeSetting.of(context).captionMedium,
    );
  }
}