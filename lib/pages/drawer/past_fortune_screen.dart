import 'package:Soulna/bottomsheet/show_datePicker_bottomSheet.dart';
import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_calendar_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

// This file defines the PastFortuneScreen widget, which displays past fortune entries.

class PastFortuneScreen extends StatefulWidget {
  const PastFortuneScreen({super.key});

  @override
  State<PastFortuneScreen> createState() => _PastFortuneScreenState();
}

class _PastFortuneScreenState extends State<PastFortuneScreen> {
  int index = 0;
  bool showData = true;
  DateTime selectedDate = DateTime.now();
  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent('MultiDay Event A', startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0), endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2, 12, 0), color: Colors.orange, isMultiDay: true),
    NeatCleanCalendarEvent('MultiDay Event b', startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0), endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2, 12, 0), color: Colors.orange, isMultiDay: true),
    NeatCleanCalendarEvent('MultiDay Event b', startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0), endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2, 12, 0), color: Colors.orange, isMultiDay: true),
    NeatCleanCalendarEvent('MultiDay Event b', startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0), endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2, 12, 0), color: Colors.orange, isMultiDay: true),
    NeatCleanCalendarEvent('MultiDay Event b', startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0), endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2, 12, 0), color: Colors.orange, isMultiDay: true),
    NeatCleanCalendarEvent('Allday Event B', startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 2, 14, 30), endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2, 17, 0), color: Colors.pink, isAllDay: true),
    NeatCleanCalendarEvent('Normal Event D', startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 30), endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 0), color: Colors.indigo),
  ];

  final authCon = Get.put(AuthController());

  @override
  void initState() {
    authCon.selectedDate.value = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeSetting.of(context).secondaryBackground,
    ));
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerCalendar(
        context: context,
        title: Obx(
          () => Text(
            DateFormat.yMMMM().format(authCon.selectedDate.value),
            style: ThemeSetting.of(context).labelMedium.copyWith(
                  fontSize: 20.sp,
                ),
          ),
        ),
        onTapOnDownArrow: () {
          ShowDatePickerBottomSheet.showDatePicker(
            context: context,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
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
      body: SafeArea(
        child: index == 0 ? pastFortune() : pastFortuneCalenderView(),
      ),
    );
  }

  pastFortune() {
    return showData == true
        ? ListView.separated(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => listTile(date: 'July 2024', description: 'It\s a day where you can expect results proportional to your efforts.'),
            padding: EdgeInsets.zero,
            separatorBuilder: (BuildContext context, int index) {
              return CustomDividerWidget(
                color: ThemeSetting.of(context).common0,
                thickness: 1,
              );
            },
          )
        : noDataFound();
  }

  pastFortuneCalenderView() => CustomCalendarWidget(
        eventsList: _eventList,
        initialDate: selectedDate,
        showEventWidget: ListView.separated(
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: _eventList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            NeatCleanCalendarEvent event = _eventList[index];
            return listTile(date: DateFormat.yMMMM().format(event.startTime), description: event.summary);
          },
          separatorBuilder: (BuildContext context, int index) {
            return CustomDividerWidget(
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

  noDataFound() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
                        style: ThemeSetting.of(context).labelLarge.copyWith(
                              fontSize: 20.sp,
                              color: ThemeSetting.of(context).secondaryBackground,
                            ),
                      ),
                      SizedBox(height: 5.h),
                      ButtonWidget.roundedButtonOrange(
                          context: context,
                          width: 150.w,
                          height: 40.h,
                          color: ThemeSetting.of(context).primaryText,
                          textStyle: ThemeSetting.of(context).captionMedium.copyWith(
                                color: ThemeSetting.of(context).secondaryBackground,
                                fontSize: 12.sp,
                              ),
                          text: "${LocaleKeys.daily_vibe_check.tr()} 💫",
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
    );
  }
}
