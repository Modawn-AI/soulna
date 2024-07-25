import 'package:Soulna/utils/package_exporter.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import '../../utils/app_assets.dart';

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
      appBar: AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 00,
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, top: 11.h),
            child: Image.asset(
              AppAssets.backArrow,
              height: 30,
              width: 30,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 11.h),
          child: Row(
            children: [
              Text(
                "July 2024",
                style: ThemeSetting.of(context).labelMedium.copyWith(
                      fontSize: 20.sp,
                    ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: ThemeSetting.of(context).primaryText,
                    size: 20.sp,
                  ))
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 11),
            child: InkWell(
              onTap: () async {
                setState(() {
                  if (index == 0) {
                    index = 1;
                  } else {
                    index = 0;
                  }
                });
              },
              child: Image.asset(
                AppAssets.calendar,
                color: ThemeSetting.of(context).primaryText,
                height: 30,
                width: 30,
              ),
            ),
          )
        ],
      ),
      body: index == 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) => pastFortune(
                    context: context,
                    date: "July 2024",
                    description:
                        "It's a day where you can expect results proportional to your efforts.",
                  ))
          : pastFortuneCalenderView(),
    );
  }

  pastFortune(
      {required BuildContext context,
      required String date,
      required String description}) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text(
            date,
            style: ThemeSetting.of(context).titleMedium.copyWith(
                  color: ThemeSetting.of(context).primary,
                ),
          ),
          subtitle: Text(
            description,
            style: ThemeSetting.of(context).bodyMedium,
          ),
        ),
        Divider(
          color: ThemeSetting.of(context).common0,
          thickness: 1,
        ),
      ],
    );
  }

  pastFortuneCalenderView() => Calendar(
        startOnMonday: true,
        hideTodayIcon: true,
        hideBottomBar: true,
        hideArrows: true,

        weekDays: const ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
        isExpandable: true,
        eventDoneColor: Colors.green,
        selectedColor: Colors.pink,
        selectedTodayColor: Colors.red,
        todayColor: Colors.blue,
        eventColor: null,
        eventsList: _eventList,
        isExpanded: true,

        expandableDateFormat: 'EEEE, dd. MMMM yyyy',
        datePickerType: DatePickerType.date,
        dayOfWeekStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
      );
}