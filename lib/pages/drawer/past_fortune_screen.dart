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
  final Set<NeatCleanCalendarEvent> _eventList = {};
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (index == 1) {
        // index 1이 캘린더 뷰를 나타낸다고 가정
        _onDateSelected(DateTime.now());
      }
    });
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
    if (!showData) {
      return noDataFound();
    }

    // 이벤트 리스트를 날짜 기준으로 정렬 (최신 순)
    final sortedEvents = List<NeatCleanCalendarEvent>.from(_eventList)..sort((a, b) => b.startTime.compareTo(a.startTime));

    return ListView.separated(
      shrinkWrap: true,
      itemCount: sortedEvents.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          _onDateSelected(sortedEvents[index].startTime);
          context.pushNamed(sajuDailyScreen);
        },
        child: listTile(
          date: DateFormat.yMMMMd().format(sortedEvents[index].startTime),
          description: sortedEvents[index].summary,
        ),
      ),
      padding: EdgeInsets.zero,
      separatorBuilder: (BuildContext context, int index) {
        return CustomDividerWidget(
          color: ThemeSetting.of(context).common0,
          thickness: 1,
        );
      },
    );
  }

  Widget pastFortuneCalenderView() {
    // 컴포넌트가 처음 생성될 때 오늘 날짜에 대한 데이터를 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedFortune.isEmpty && !isLoading) {
        _onDateSelected(DateTime.now());
      }
    });

    return CustomCalendarWidget(
      eventsList: _eventList.toList(),
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
                StringTranslateExtension(LocaleKeys.no_fortune_select_date).tr(),
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
  }

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
              StringTranslateExtension(LocaleKeys.not_checked_my_fortune_yet).tr(),
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
    if (!mounted) return;

    setState(() {
      selectedDate = date;
      isLoading = true;
      selectedFortune = '';
    });

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    try {
      SajuDailyModel model;
      if (_fortuneCache.containsKey(formattedDate)) {
        model = _fortuneCache[formattedDate]!;
      } else {
        dynamic response = await ApiCalls().getDateToSaju(formattedDate);
        if (response != null && response['status'] == 'success') {
          model = SajuDailyModel.fromJson(response['data']['daily_entry']);
          _fortuneCache[formattedDate] = model;
          GetIt.I.get<SajuDailyService>().setSajuDailyInfo(model);
        } else {
          throw Exception('API 응답이 성공이 아닙니다.');
        }
      }

      if (!mounted) return;

      setState(() {
        selectedFortune = model.sajuDescription.title;
        isLoading = false;

        // 기존 이벤트 제거 후 새 이벤트 추가
        _eventList.removeWhere((event) => event.startTime.year == date.year && event.startTime.month == date.month && event.startTime.day == date.day);
        _eventList.add(NeatCleanCalendarEvent(
          model.sajuDescription.title,
          startTime: date,
          endTime: date,
          color: ThemeSetting.of(context).primary,
        ));
      });
    } catch (e) {
      debugPrint('Error fetching fortune: $e');
      if (!mounted) return;
      setState(() {
        selectedFortune = 'Error fetching fortune. Please try again.';
        isLoading = false;
      });
    }
  }
}
