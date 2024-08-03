import 'package:Soulna/utils/package_exporter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:Soulna/utils/app_assets.dart';

class HeaderWidget {
  static AppBar headerBack(
          {required BuildContext context,
          void Function()? onTap,
          Color? backgroundColor}) =>
      AppBar(
        // backgroundColor:
        //     backgroundColor ?? ThemeSetting.of(context).secondaryBackground,
        elevation: 0,
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 11),
            child: Image.asset(
              AppAssets.backArrow,
              height: 30,
              width: 30,
              color: ThemeSetting.of(context).primaryText,
            ),
          ),
        ),
      );

  static AppBar headerWithTitle(
          {required BuildContext context,
          required String title,
          void Function()? onTap}) =>
      AppBar(
        elevation: 0,
        leadingWidth: 43,
        leading: GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 11),
            child: Image.asset(
              AppAssets.backArrow,
              height: 30,
              width: 30,
              color: ThemeSetting.of(context).primaryText,
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

  static AppBar headerWithAction({
    required BuildContext context,
    String? title,
    bool showMoreIcon = true,
    void Function()? onTap,
    void Function()? showMoreIconOnTap,
  }) =>
      AppBar(
        elevation: 0,
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: onTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 11),
            child: Image.asset(
              AppAssets.backArrow,
              height: 30,
              width: 30,
              color: ThemeSetting.of(context).primaryText,
            ),
          ),
        ),
        titleSpacing: 5,
        title: Padding(
          padding: const EdgeInsets.only(top: 11),
          child: Text(
            title ?? '',
            style: ThemeSetting.of(context).titleLarge,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 11),
            child: Image.asset(
              AppAssets.share,
              height: 30,
              width: 30,
              color: ThemeSetting.of(context).primaryText,
            ),
          ),
          if (showMoreIcon == true)
            GestureDetector(
              onTap: showMoreIconOnTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 11),
                child: Image.asset(
                  AppAssets.more,
                  height: 30,
                  width: 30,
                  color: ThemeSetting.of(context).primaryText,
                ),
              ),
            )
        ],
      );

  static AppBar headerWithLogoAndInstagram(
          {required BuildContext context,
          required Widget title,
          void Function()? leadingOnTap,
            void Function()? actionOnTap,}) =>
      AppBar(
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: leadingOnTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, top: 11),
            child: Image.asset(
              AppAssets.btnMore,
              height: 30,
              width: 30,
              color: ThemeSetting.of(context).primaryText,
            ),
          ),
        ),
        centerTitle: true,
        title: title,
        actions: [

          GestureDetector(
            onTap: actionOnTap,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 11),
              child: Image.asset(
                AppAssets.instagram,
                height: 30,
                width: 30,
                color: ThemeSetting.of(context).primaryText,
              ),
            ),
          )
        ],
      );

  static AppBar headerMy({required BuildContext context}) => AppBar(
        elevation: 0,
        leadingWidth: 48,
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
                color: ThemeSetting.of(context).primaryText,
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
                            text: ' /4',
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
          String? actionIcon,
          GestureTapCallback? onTapOnMenu,
          Widget? switchTile}) =>
      AppBar(
        elevation: 0,
        leadingWidth: 48,
        leading: GestureDetector(
          onTap: onTapOnMenu,
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, top: 11.h),
            child: Image.asset(
              AppAssets.backArrow,
              height: 30,
              width: 30,
              color: ThemeSetting.of(context).primaryText,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.w, top: 11.h),
            child: InkWell(
              onTap: onTap,
              child: Image.asset(
                actionIcon ?? AppAssets.iconSettings,
                height: 30,
                width: 30,
                color: ThemeSetting.of(context).primaryText,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 18.w, top: 5.h),
              child: switchTile ?? SizedBox.shrink())
        ],
      );

  static headerCalendar(
          {required BuildContext context,
          required String title,
          void Function()? onTap,
          void Function()? onTapOnDownArrow,
          String? image}) =>
      AppBar(
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
              color: ThemeSetting.of(context).primaryText,
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
                  onPressed: onTapOnDownArrow,
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,

                    color: ThemeSetting.of(context).primaryText,
                    size: 20,
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