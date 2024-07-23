import 'package:Soulna/utils/package_exporter.dart';

import '../../utils/app_assets.dart';

class HeaderWidget {
  static AppBar headerBack({required BuildContext context}) => AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 0,
        leadingWidth: 48,
        leading: Padding(
          padding: EdgeInsets.only(left: 15, top: 11),
          child: Image.asset(
            AppAssets.backArrow,
          ),
        ),
      );

  static AppBar headerWithTitle(
          {required BuildContext context, required String title}) =>
      AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 0,
        leadingWidth: 48,
        leading: Padding(
          padding: EdgeInsets.only(left: 15, top: 11),
          child: Image.asset(
            AppAssets.backArrow,
          ),
        ),
        titleSpacing: 5,
        title: Text(
          title,
          style: ThemeSetting.of(context).titleLarge,
        ),
      );

  static AppBar headerWithAction(
          {required BuildContext context,
          String? title,
          bool showMoreIcon = true}) =>
      AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 0,
        leadingWidth: 48,
        leading: Padding(
          padding: EdgeInsets.only(left: 18, top: 11),
          child: Image.asset(
            AppAssets.backArrow,
          ),
        ),
        titleSpacing: 5,
        title: Text(
          title ?? '',
          style: ThemeSetting.of(context).titleLarge,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15, top: 11),
            child: Image.asset(
              AppAssets.share,
              height: 30,
              width: 30,
            ),
          ),
          if (showMoreIcon == true)
            Padding(
              padding: EdgeInsets.only(right: 15, top: 11),
              child: Image.asset(
                AppAssets.more,
                height: 30,
                width: 30,
              ),
            )
        ],
      );

  static AppBar headerWithLogoAndInstagram({required BuildContext context}) =>
      AppBar(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        elevation: 00,
        leadingWidth: 48,
        leading: Padding(
          padding: EdgeInsets.only(left: 18, top: 11),
          child: Image.asset(
            AppAssets.btnMore,
            height: 30,
            width: 30,
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: 11),
          child: Image.asset(
            AppAssets.logo,
            height: 37,
            width: 37,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15, top: 11),
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
            padding: EdgeInsets.only(right: 15, top: 11),
            child: Icon(
              Icons.settings,
              size: 30,
              color: ThemeSetting.of(context).primaryText,
            ),
          )
        ],
      );
}