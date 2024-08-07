import 'package:Soulna/bottomsheet/show_datePicker_bottomSheet.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_calendar_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';

//Not linked to any screen
// This file defines the NoPastFortuneScreen widget, which displays a screen indicating that there are no past fortune entries.

class NoPastFortuneScreen extends StatefulWidget {
  const NoPastFortuneScreen({super.key});

  @override
  State<NoPastFortuneScreen> createState() => _NoPastFortuneScreenState();
}

class _NoPastFortuneScreenState extends State<NoPastFortuneScreen> {
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
        title: DateFormat.yMMMM().format(
          DateTime.now(),
        ),
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
        onTapOnDownArrow: () {
          ShowDatePickerBottomSheet.showDatePicker(context: context);

        },
      ),
      body: index == 0
          ? Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ThemeSetting.of(context).linearContainer1,
                        ThemeSetting.of(context).linearContainer2,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: ThemeSetting.of(context).black2,
                      width: 1,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemeSetting.of(context).secondaryBackground,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                LocaleKeys.check_your_fortune_for_today.tr(),
                                style: ThemeSetting.of(context)
                                    .labelLarge
                                    .copyWith(
                                      fontSize: 20.sp,
                                      color: ThemeSetting.of(context)
                                          .secondaryBackground,
                                    ),
                              ),
                              SizedBox(height: 5.h),
                              ButtonWidget.roundedButtonOrange(
                                  context: context,
                                  width: 150.w,
                                  height: 40.h,
                                  color: ThemeSetting.of(context).primaryText,
                                  textStyle: ThemeSetting.of(context)
                                      .captionMedium
                                      .copyWith(
                                        color: ThemeSetting.of(context)
                                            .secondaryBackground,
                                        fontSize: 12.sp,
                                      ),
                                  text:
                                      "${LocaleKeys.daily_vibe_check.tr()} 💫",
                                  onTap: () {}),
                            ],
                          ),
                        ),
                        Image.asset(
                          AppAssets.image1,
                          height: 90.h,
                          width: 64.w,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      LocaleKeys.i_have_not_checked_my_fortune_yet.tr(),
                      style: ThemeSetting.of(context).bodyMedium.copyWith(
                            color: ThemeSetting.of(context).disabledText,
                          ),
                    ),
                  ),
                ),
              ],
            )
          : CustomCalendarWidget(
              eventsList: _eventList,
              showEventWidget: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: _eventList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  NeatCleanCalendarEvent event = _eventList[index];
                  return listTile(
                      date: DateFormat.yMMMM().format(event.startTime),
                      description: event.summary);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return CustomDividerWidget(
                    color: ThemeSetting.of(context).common0,
                    thickness: 1,
                  );
                },
              ),
            ),
    );
  }

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