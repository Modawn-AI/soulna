import 'package:Soulna/utils/package_exporter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../utils/app_assets.dart';
import '../../widgets/button/button_widget.dart';
import '../../widgets/custom_ios_date_picker.dart';
import '../../widgets/header/header_widget.dart';

class NoPastDiaryScreen extends StatelessWidget {
  const NoPastDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerCalendar(
        context: context,
        title:  DateFormat.yMMMM().format(DateTime.now(),),
        onTapOnDownArrow: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CustomDatePicker();
            },
          );
        },
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            padding : EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
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
            child: Container(    alignment: Alignment.center,
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
                          LocaleKeys.create_today_diary.tr(),
                          style: ThemeSetting.of(context).labelLarge.copyWith(
                            fontSize: 20.sp,
                            color: ThemeSetting.of(context).secondaryBackground,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        ButtonWidget.roundedButtonOrange(
                            context: context,
                            width: 100.w,
                            height: 40.h,
                            color: ThemeSetting.of(context).primaryText,
                            textStyle: ThemeSetting.of(context).captionMedium.copyWith(
                              color: ThemeSetting.of(context).secondaryBackground,
                              fontSize: 12.sp,
                            ),
                            text: "${LocaleKeys.create.tr()} 💫",
                            onTap: () {}),
                      ],
                    ),
                  ),
                  Image.asset(
                    AppAssets.image1,
                    height: 90.h,
                    width: 80.w,
                    fit: BoxFit.fill,
                  ),
                ],),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                LocaleKeys.i_have_not_written_a_diary_yet.tr(),
                style: ThemeSetting.of(context).bodyMedium.copyWith(
                  color: ThemeSetting.of(context).disabledText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}