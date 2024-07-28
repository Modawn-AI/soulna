import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/custom_calendar_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import '../../utils/app_assets.dart';
import '../../widgets/custom_ios_date_picker.dart';

class PastFortuneScreen extends StatefulWidget {
  const PastFortuneScreen({super.key});

  @override
  State<PastFortuneScreen> createState() => _PastFortuneScreenState();
}

class _PastFortuneScreenState extends State<PastFortuneScreen> {
  int index = 0;

  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent('MultiDay Event A',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange,
        isMultiDay: true),
    NeatCleanCalendarEvent('MultiDay Event b',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange,
        isMultiDay: true),
    NeatCleanCalendarEvent('MultiDay Event b',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange,
        isMultiDay: true),
    NeatCleanCalendarEvent('MultiDay Event b',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange,
        isMultiDay: true),
    NeatCleanCalendarEvent('MultiDay Event b',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange,
        isMultiDay: true),
    NeatCleanCalendarEvent('Allday Event B',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day - 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.pink,
        isAllDay: true),
    NeatCleanCalendarEvent('Normal Event D',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 0),
        color: Colors.indigo),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerCalendar(
        context: context,
        title: DateFormat.yMMMM().format(DateTime.now()),
        onTapOnDownArrow: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CustomDatePicker();
            },
          );
        },
        onTap: () async {
          setState(() {
            if (index == 0) {
              index = 1;
            } else {
              index = 0;
            }
          });
        },
        image: index == 0 ? AppAssets.calendar : AppAssets.menu,
      ),
      body: index == 0 ? pastFortune() : pastFortuneCalenderView(),
    );
  }

  pastFortune() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) => listTile(
          date: 'July 2024',
          description:
              'It\s a day where you can expect results proportional to your efforts.'),
      padding: EdgeInsets.zero,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: ThemeSetting.of(context).common0,
          thickness: 1,
        );
      },
    );
  }

  pastFortuneCalenderView() => CustomCalendarWidget(
        eventsList: _eventList,
        showEventWidget: ListView.separated(
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: _eventList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            NeatCleanCalendarEvent event = _eventList[index];
            return listTile(
                date: DateFormat.yMMMM().format(event.startTime),
                description: event.summary);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: ThemeSetting.of(context).common0,
              thickness: 1,
            );
          },
        ),
      );

  listTile({required date, required String description}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              date,
              style: ThemeSetting.of(context).titleMedium.copyWith(
                    color: ThemeSetting.of(context).primary,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              description,
              style: ThemeSetting.of(context).bodyMedium,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}