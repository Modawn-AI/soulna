import 'package:Soulna/utils/package_exporter.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../utils/app_assets.dart';

class HeaderWidget {
  static AppBar headerBack(
          {required BuildContext context,
          void Function()? onTap,
          Color? backgroundColor}) =>
      AppBar(
        backgroundColor:
            backgroundColor ?? ThemeSetting.of(context).secondaryBackground,
        elevation: 0,
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 11),
            child: Image.asset(
              AppAssets.backArrow,
            ),
          ),
        ),
      );

  static AppBar headerWithTitle(
          {required BuildContext context,
          required String title,
          void Function()? onTap}) =>
      AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 0,
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 11),
            child: Image.asset(
              AppAssets.backArrow,
            ),
          ),
        ),
        titleSpacing: 5,
        title: Padding(
          padding: const EdgeInsets.only(top: 11),
          child: Text(
            title,
            style: ThemeSetting.of(context).titleLarge,
          ),
        ),
      );

  static AppBar headerWithAction(
          {required BuildContext context,
          String? title,
          bool showMoreIcon = true,
          void Function()? onTap}) =>
      AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 0,
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, top: 11),
            child: Image.asset(
              AppAssets.backArrow,
            ),
          ),
        ),
        titleSpacing: 5,
        title: Text(
          title ?? '',
          style: ThemeSetting.of(context).titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 11),
            child: Image.asset(
              AppAssets.share,
              height: 30,
              width: 30,
            ),
          ),
          if (showMoreIcon == true)
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 11),
              child: Image.asset(
                AppAssets.more,
                height: 30,
                width: 30,
              ),
            )
        ],
      );

  static AppBar headerWithLogoAndInstagram(
          {required BuildContext context, void Function()? onTap}) =>
      AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 00,
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, top: 11),
            child: Image.asset(
              AppAssets.btnMore,
              height: 30,
              width: 30,
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 11),
          child: Image.asset(
            AppAssets.logo,
            height: 37,
            width: 37,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 11),
            child: Image.asset(
              AppAssets.instagram,
              height: 30,
              width: 30,
            ),
          )
        ],
      );

  static AppBar headerMy({required BuildContext context}) => AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 11),
            child: Icon(
              Icons.settings,
              size: 30,
              color: ThemeSetting.of(context).primaryText,
            ),
          )
        ],
      );

  static AppBar headerWithCustomAction(
          {required BuildContext context,
          void Function()? onTap,
          List<Widget>? actions,
          String? pageIndex,
          double percent = 0.0}) =>
      AppBar(
          backgroundColor: ThemeSetting.of(context).secondaryBackground,
          elevation: 00,
          leadingWidth: 48,
          leading: GestureDetector(
            onTap: onTap ?? () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.only(left: 18, top: 11),
              child: Image.asset(
                AppAssets.backArrow,
                height: 30,
                width: 30,
              ),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15, top: 11),
                child: LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  width: 28,
                  lineHeight: 6,
                  animation: true,
                  percent: percent,
                  progressColor: ThemeSetting.of(context).primary,
                  fillColor: ThemeSetting.of(context).common1,
                  barRadius: const Radius.circular(50),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 11),
              child: RichText(
                  text: TextSpan(
                      text: pageIndex,
                      children: [
                        TextSpan(
                            text: '/4',
                            style: ThemeSetting.of(context)
                                .captionLarge
                                .copyWith(
                                    color:
                                        ThemeSetting.of(context).primaryText))
                      ],
                      style: ThemeSetting.of(context)
                          .captionLarge
                          .copyWith(color: ThemeSetting.of(context).primary))),
            )
          ]);

  static AppBar headerSettings(
          {required BuildContext context,
          required GestureTapCallback onTap,
          GestureTapCallback? onTapOnMenu}) =>
      AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 0,
        leading: GestureDetector(
          onTap: onTapOnMenu,
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, top: 11.h),
            child: Image.asset(
              AppAssets.backArrow,
              height: 30.h,
              width: 30.w,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.w, top: 11.h),
            child: InkWell(
              onTap: onTap,
              child: Image.asset(
                AppAssets.iconSettings,
                height: 30.h,
                width: 30.w,
              ),
            ),
          )
        ],
      );

  static headerCalendar(
          {required BuildContext context,
          required String title,
          void Function()? onTap,
          String? image}) =>
      AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 00,
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, top: 11.h),
            child: Image.asset(
              AppAssets.backArrow,
              height: 30,
              width: 30,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 11.h),
          child: Row(
            children: [
              Text(
                title,
                style: ThemeSetting.of(context).labelMedium.copyWith(
                      fontSize: 20.sp,
                    ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: ThemeSetting.of(context).primaryText,
                    size: 20.sp,
                  ))
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 11),
            child: InkWell(
              onTap: onTap,
              child: Image.asset(
                image ?? AppAssets.calendar,
                color: ThemeSetting.of(context).primaryText,
                height: 30,
                width: 30,
              ),
            ),
          )
        ],
      );
}