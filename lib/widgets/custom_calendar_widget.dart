import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

import '../utils/package_exporter.dart';

class CustomCalendarWidget extends StatelessWidget {
  final List<NeatCleanCalendarEvent> eventsList;
  final Widget? showEventWidget;
  const CustomCalendarWidget(
      {super.key, required this.eventsList, this.showEventWidget});

  @override
  Widget build(BuildContext context) {
    return Calendar(
      startOnMonday: false,
      hideTodayIcon: true,
      hideBottomBar: true,
      hideArrows: true,
      weekDays: const ['S', 'M', 'T', 'W', 'T', 'F', 'S'],

      defaultDayColor: ThemeSetting.of(context).primaryText,
      isExpanded: true,
      eventDoneColor: ThemeSetting.of(context).primary,
      selectedColor: ThemeSetting.of(context).primary,
      selectedTodayColor: ThemeSetting.of(context).primary,
      todayColor: ThemeSetting.of(context).primary,
      eventColor: ThemeSetting.of(context).primary,
      eventsList: eventsList,
      // eventTileHeight: 00,

      bottomBarArrowColor: Colors.transparent,
      bottomBarColor: Colors.transparent,
      //bottomBarTextStyle: const TextStyle(color: Colors.transparent),
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
      displayMonthTextStyle: ThemeSetting.of(context)
          .bodyMedium
          .copyWith(color: Colors.transparent),
      // expandableDateFormat: 'EEEE, dd. MMMM yyyy',
      //datePickerType: DatePickerType.date,
      dayOfWeekStyle: ThemeSetting.of(context).captionMedium,
    );
  }
}