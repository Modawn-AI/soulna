import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the ResponseCompletedScreen widget, which displays a screen indicating that a response has been completed.

class ResponseCompletedScreen extends StatelessWidget {
  const ResponseCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerBack(context: context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                LocaleKeys.i_want_to_edit_the_photos_in_my_diary_des.tr(),
                style: ThemeSetting.of(context).bodyMedium,
              ),
            ),
            SizedBox(height: 50.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                width: double.infinity,
                color: ThemeSetting.of(context).tertiary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ButtonWidget.squareButtonOrange(
                      context: context,
                      height: 30.h,
                      text: LocaleKeys.response_completed.tr(),
                      buttonBackgroundColor: ThemeSetting.of(context).primary,
                      textStyle: ThemeSetting.of(context).bodySmall.copyWith(
                            color: ThemeSetting.of(context).white,
                          ),
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      LocaleKeys.hello_member_for_photos_the_only_way_is_to_delete_them_and_recreate_them.tr(),
                      style: ThemeSetting.of(context).bodyMedium,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "January 1st, 1990 2:20 PM",
                      style: ThemeSetting.of(context).captionMedium.copyWith(
                            color: ThemeSetting.of(context).disabledText,
                            fontSize: 12.sp,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
