import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:Soulna/widgets/custom_ios_date_picker.dart';
import 'package:Soulna/widgets/custom_time_range_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../utils/app_assets.dart';
import '../../utils/package_exporter.dart';
import '../../widgets/button/button_widget.dart';
import '../../widgets/custom_checkbox_widget.dart';
import '../../widgets/header/header_widget.dart';

class DateOfBirthMain extends StatefulWidget {
  const DateOfBirthMain({super.key});

  @override
  State<DateOfBirthMain> createState() => _DateOfBirthMainState();
}

class _DateOfBirthMainState extends State<DateOfBirthMain> {

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerBack(
        context: context,
        backgroundColor: ThemeSetting.of(context).secondaryBackground
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.please_set_your_date_of_birth.tr(),
              style: ThemeSetting.of(context).labelSmall.copyWith(
                    color: ThemeSetting.of(context).primaryText,
                  ),
            ),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Image.asset(
                    AppAssets.logo,
                    height: 17,
                    width: 17,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    LocaleKeys
                        .it_automatically_creates_a_diary_through_the_Ai_algorithm
                        .tr(),
                    style: ThemeSetting.of(context).captionMedium,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomDatePicker(),
            Text(
              LocaleKeys.time.tr(),
              style: ThemeSetting.of(context).captionMedium.copyWith(
                    color: ThemeSetting.of(context).primary,
                  ),
            ),
            SizedBox(height: 10.h),
            CustomRangeTimePicker(
              initialStartTime: const TimeOfDay(hour: 9, minute: 0),
              initialEndTime: const TimeOfDay(hour: 17, minute: 0),
              onStartTimeChanged: (startTime) {
                print("Start Time: ${startTime.format(context)}");
              },
              onEndTimeChanged: (endTime) {
                print("End Time: ${endTime.format(context)}");
              },
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                CustomCheckbox(
                  initialValue: isChecked,
                  onChanged: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                ),
                Text(
                  LocaleKeys.i_dont_know_my_time_of_birth.tr(),
                  style: ThemeSetting.of(context).captionMedium.copyWith(
                        color: ThemeSetting.of(context).primaryText,
                      ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: ButtonWidget.roundedButtonOrange(
                  context: context,
                  color: ThemeSetting.of(context).primaryText,
                  text: LocaleKeys.daily_vibe_check.tr(),
                  onTap: () {
                    // SharedPreferences.getInstance();
                    SharedPreferencesManager.setString(
                        key: SharedprefString.animationScreen,
                        value: bookDetailScreen);
                    context.pushReplacementNamed(animationScreen);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}