import 'package:Soulna/bottomsheet/show_datePicker_bottomSheet.dart';
import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/models/saju_daily_model.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_calendar_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';

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
  String selectedFortune = '';
  bool isLoading = false;
  final List<NeatCleanCalendarEvent> _eventList = [];
  final Map<String, SajuDailyModel> _fortuneCache = {};

  final authCon = Get.put(AuthController());

  @override
  void initState() {
    authCon.selectedDate.value = DateTime.now();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedDate = authCon.selectedDate.value;
    _fetchSajuData();
  }

  Future<void> _fetchSajuData() async {
    try {
      dynamic response = await ApiCalls().getSajuList();

      if (response['status'] == 'success') {
        _eventList.clear();
        if (response['message'] == 'none') {
          setState(() {
            showData = false;
          });
          return;
        }
        for (var dayEvents in response['data']['daily_list']) {
          if (dayEvents is List) {
            for (var event in dayEvents) {
              if (event is Map<String, dynamic>) {
                _eventList.add(
                  NeatCleanCalendarEvent(
                    event['title'] ?? 'Untitled Event',
                    startTime: DateTime.tryParse(event['date'] ?? '') ?? DateTime.now(),
                    endTime: DateTime.tryParse(event['date'] ?? '') ?? DateTime.now().add(Duration(hours: 1)),
                    color: ThemeSetting.of(context).primary,
                  ),
                );
              }
            }
          }
        }
        setState(() {
          showData = true;
        });
      }
    } catch (e) {
      debugPrint('Error fetching saju list: $e');
    }
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
      body: SafeArea(child: index == 0 ? pastFortune() : pastFortuneCalenderView()),
    );
  }

  Widget pastFortune() {
    return showData == true
        ? ListView.separated(
            shrinkWrap: true,
            itemCount: _eventList.length,
            itemBuilder: (context, index) => listTile(
              date: DateFormat.yMMMMd().format(_eventList[index].startTime),
              description: _eventList[index].summary,
            ),
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

  Widget pastFortuneCalenderView() => CustomCalendarWidget(
        eventsList: _eventList,
        initialDate: selectedDate,
        onDateSelected: (date) {
          _onDateSelected(date);
        },
        showEventWidget: Builder(
          builder: (context) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (selectedFortune.isEmpty) {
              return Center(
                child: Text(
                  'No fortune available for selected date.', // no_fortune_select_date
                  style: ThemeSetting.of(context).bodyMedium.copyWith(
                        color: ThemeSetting.of(context).disabledText,
                      ),
                ),
              );
            }

            return ListView(
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed(sajuDailyScreen);
                  },
                  child: listTile(
                    date: DateFormat.yMMMMd().format(selectedDate),
                    description: selectedFortune,
                  ),
                ),
              ],
            );
          },
        ),
      );

  Widget listTile({required String date, required String description}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              date,
              style: ThemeSetting.of(context).titleMedium.copyWith(
                    color: ThemeSetting.of(context).primary,
                  ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: ThemeSetting.of(context).bodyMedium,
            ),
            const SizedBox(height: 10),
          ],
        ),
      );

  Widget noDataFound() {
    return Column(
      children: [
        const SizedBox(
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
                        StringTranslateExtension(LocaleKeys.check_your_fortune_for_today).tr(),
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
                          text: "${StringTranslateExtension(LocaleKeys.daily_vibe_check).tr()} 💫",
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
              StringTranslateExtension(LocaleKeys.i_have_not_checked_my_fortune_yet).tr(), // not_checked_my_fortune_yet
              style: ThemeSetting.of(context).bodyMedium.copyWith(
                    color: ThemeSetting.of(context).disabledText,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  void _onDateSelected(DateTime date) async {
    setState(() {
      selectedDate = date;
      isLoading = true;
      selectedFortune = '';
    });

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    if (_fortuneCache.containsKey(formattedDate)) {
      // 캐시된 데이터가 있으면 사용
      setState(() {
        selectedFortune = _fortuneCache[formattedDate]!.sajuDescription.title;
        isLoading = false;
      });
    } else {
      try {
        dynamic response = await ApiCalls().getDateToSaju(formattedDate);

        if (response != null && response['status'] == 'success') {
          SajuDailyModel model = SajuDailyModel.fromJson(response['data']['daily_entry']);
          _fortuneCache[formattedDate] = model; // 캐시에 저장
          GetIt.I.get<SajuDailyService>().setSajuDailyInfo(model);
          setState(() {
            selectedFortune = model.sajuDescription.title;
            isLoading = false;
          });

          // _eventList 업데이트
          if (!_eventList.any((event) => event.startTime == date)) {
            setState(() {
              _eventList.add(
                NeatCleanCalendarEvent(
                  formattedDate,
                  startTime: date,
                  endTime: date,
                  color: ThemeSetting.of(context).primary,
                ),
              );
            });
          }
        } else {
          setState(() {
            selectedFortune = 'No fortune available for this date.'; // no_fortune_available_this
            isLoading = false;
          });
        }
      } catch (e) {
        debugPrint('Error fetching fortune: $e');
        setState(() {
          selectedFortune = 'Error fetching fortune. Please try again.'; // error_fetching_fortune
          isLoading = false;
        });
      }
    }
  }
}
