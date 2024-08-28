import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the AwaitingResponseScreen widget, which displays a screen indicating that a response is awaited.

class AwaitingResponseScreen extends StatelessWidget {
  const AwaitingResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerBack(context: context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    LocaleKeys.service.tr(),
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                          color: ThemeSetting.of(context).primary,
                          fontSize: 14.sp,
                        ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    LocaleKeys.i_want_to_edit_the_photos_in_my_diary.tr(),
                    style: ThemeSetting.of(context).labelLarge.copyWith(
                          fontSize: 24.sp,
                        ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "January 1st, 1990 2:20 PM",
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                          color: ThemeSetting.of(context).disabledText,
                          fontSize: 12.sp,
                        ),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
            Divider(
              color: ThemeSetting.of(context).common2,
              thickness: 2,
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                LocaleKeys.edit_the_photos_in_my_diary_des.tr(),
                style: ThemeSetting.of(context).bodyMedium,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ButtonWidget.squareButtonOrange(
                context: context,
                height: 30.h,
                text: LocaleKeys.awaiting_response.tr(),
                buttonBackgroundColor: ThemeSetting.of(context).common0,
                textStyle: ThemeSetting.of(context).captionMedium.copyWith(
                      color: ThemeSetting.of(context).black2,
                    ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
