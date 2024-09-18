import 'package:Soulna/bottomsheet/show_datePicker_bottomSheet.dart';
import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/models/journal_model.dart';
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
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

// This file defines the PastDiary widget, which displays past diary entries.

class PastJournal extends StatefulWidget {
  const PastJournal({super.key});

  @override
  State<PastJournal> createState() => _PastJournalState();
}

class _PastJournalState extends State<PastJournal> {
  int index = 0;
  bool showData = true;
  DateTime selectedDate = DateTime.now();
  String selectedJournal = '';
  bool isLoading = false;
  final Set<NeatCleanCalendarEvent> _eventList = {};
  final Map<String, JournalModel> _journalCache = {};

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
    _fetchJournalData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (index == 1) {
        // index 1이 캘린더 뷰를 나타낸다고 가정
        _onDateSelected(DateTime.now());
      }
    });
  }

  Future<void> _fetchJournalData() async {
    dynamic response = await ApiCalls().getJournalList();
    if (response['status'] == 'success') {
      _eventList.clear();
      if (response['message'] == 'none') {
        setState(() {
          showData = false;
        });

        return;
      }
      for (var item in response['data']['journal_list']) {
        if (item is List) {
          for (var event in item) {
            if (event is Map<String, dynamic>) {
              _eventList.add(
                NeatCleanCalendarEvent(
                  event['title'] ?? '',
                  startTime: DateTime.tryParse(event['date'] ?? '') ?? DateTime.now(),
                  endTime: DateTime.tryParse(event['date'] ?? '') ?? DateTime.now().add(Duration(hours: 1)),
                  color: ThemeSetting.of(context).primary,
                ),
              );
            }
          }
        }
      }
    }
    setState(() {
      showData = true;
    });
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
              setState(
                () {
                  authCon.selectedDate.value = date;
                },
              );
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
        child: index == 0 ? pastJournal() : pastJournalCalenderView(),
      ),
    );
  }

  Widget pastJournal() {
    if (!showData) {
      return noDataFound();
    }

    // 이벤트 리스트를 날짜 기준으로 정렬 (최신 순)
    final sortedEvents = List<NeatCleanCalendarEvent>.from(_eventList)..sort((a, b) => b.startTime.compareTo(a.startTime));

    return ListView.separated(
      shrinkWrap: true,
      itemCount: sortedEvents.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () async {
          await _onDateSelected(sortedEvents[index].startTime);
          context.pushNamed(journalScreen);
        },
        child: listTile(
          date: DateFormat.yMMMMd().format(sortedEvents[index].startTime),
          description: sortedEvents[index].summary ?? '',
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

  Widget pastJournalCalenderView() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedJournal.isEmpty && !isLoading) {
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

          if (selectedJournal.isEmpty) {
            return Center(
              child: Text(
                LocaleKeys.no_journal_avaliable_select.tr(),
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
                  context.pushNamed(journalScreen);
                },
                child: listTile(
                  date: DateFormat.yMMMMd().format(selectedDate),
                  description: selectedJournal,
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
                ThemeSetting.of(context).linearContainer3,
                ThemeSetting.of(context).linearContainer4,
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
                        StringTranslateExtension(LocaleKeys.create_today_journal).tr(),
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
                          text: "${StringTranslateExtension(LocaleKeys.create_text).tr()} 💫",
                          onTap: () {}),
                    ],
                  ),
                ),
                Image.asset(
                  AppAssets.image2,
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
              StringTranslateExtension(LocaleKeys.checked_my_fortune_yet).tr(), //
              style: ThemeSetting.of(context).bodyMedium.copyWith(
                    color: ThemeSetting.of(context).disabledText,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onDateSelected(DateTime date) async {
    if (!mounted) return;

    setState(() {
      selectedDate = date;
      isLoading = true;
      selectedJournal = '';
    });

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    if (_journalCache.containsKey(formattedDate)) {
      // 캐시된 데이터가 있으면 사용
      setState(() {
        GetIt.I.get<JournalService>().updateJournal(_journalCache[formattedDate]!, selectedDate);
        selectedJournal = _journalCache[formattedDate]!.title;
        isLoading = false;
      });
    } else {
      try {
        dynamic response = await ApiCalls().getDateToJournal(formattedDate);

        if (response['status'] == 'success' && response['data']['journal_entry'] != null) {
          JournalModel model = JournalModel.fromJson(response['data']['journal_entry']);
          _journalCache[formattedDate] = model;
          GetIt.I.get<JournalService>().updateJournal(model, selectedDate);

          setState(() {
            selectedJournal = model.title;
            isLoading = false;

            // 기존 이벤트 제거 후 새 이벤트 추가
            _eventList.removeWhere((event) => event.startTime.year == date.year && event.startTime.month == date.month && event.startTime.day == date.day);
            _eventList.add(
              NeatCleanCalendarEvent(
                model.title,
                startTime: date,
                endTime: date,
                color: ThemeSetting.of(context).primary,
              ),
            );
          });
        } else {
          setState(() {
            selectedJournal = LocaleKeys.no_journal_avaliable_this.tr();
            isLoading = false;
          });
        }
      } catch (e) {
        print('Error fetching journal: $e');
        setState(() {
          selectedJournal = 'Error fetching journal. Please try again.'; // error_fetching_journal
          isLoading = false;
        });
      }
    }
  }
}
