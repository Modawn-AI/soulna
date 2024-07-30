import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_checkbox_widget.dart';
import 'package:Soulna/widgets/custom_ios_date_picker.dart';
import 'package:Soulna/widgets/custom_time_range_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the DateOfBirthMain widget, which is used for entering the date of birth.
//Main screen -> set date of birth
class DateOfBirthMain extends StatefulWidget {
  const DateOfBirthMain({super.key});

  @override
  State<DateOfBirthMain> createState() => _DateOfBirthMainState();
}

class _DateOfBirthMainState extends State<DateOfBirthMain> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        appBar: HeaderWidget.headerBack(
          context: context,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),

          children: [
            Text(
              LocaleKeys.please_set_your_date_of_birth.tr(),
              style: ThemeSetting.of(context).labelSmall.copyWith(
                    color: ThemeSetting.of(context).primaryText,
                  ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(
              height: 20,
            ),
            const CustomDatePicker(),
            const SizedBox(
              height: 40,
            ),
            Text(
              LocaleKeys.time.tr(),
              style: ThemeSetting.of(context).captionMedium.copyWith(
                    color: ThemeSetting.of(context).primary,
                  ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 15),
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
            const SizedBox(
              height: 180,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: ButtonWidget.roundedButtonOrange(
                  context: context,
                  color: ThemeSetting.of(context).black2,
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