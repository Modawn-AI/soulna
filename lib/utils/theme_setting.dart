// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class ThemeSetting {
  late AlertStyle alertStyle;

  static Future initialize() async => _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system ? _prefs?.remove(kThemeModeKey) : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static ThemeSetting of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? DarkModeTheme() : LightModeTheme();
  }

  static bool isLightTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static void changeTheme(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    bool isDarkMode = _prefs.getBool(kThemeModeKey) ?? false;
    isDarkMode = !isDarkMode;
    ThemeSetting.saveThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    _prefs.setBool(kThemeModeKey, isDarkMode);
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeSetting.of(context).secondaryBackground,
      // statusBarBrightness: ThemeSetting.isLightTheme(context)
      //     ? Brightness.light
      //     : Brightness.dark,
      statusBarIconBrightness: ThemeSetting.isLightTheme(context) ? Brightness.light : Brightness.dark,
    ));
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color tertiary1;
  late Color tertiary2;
  late Color tertiary3;

  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color divider;
  late Color tertiaryText;
  late Color disabledText;
  late Color disabledBackground;
  late Color grey900;

  late Color successBackground;
  late Color warningBackground;
  late Color errorBackground;

  late Color common0;
  late Color common3;
  late Color common1;
  late Color common5;
  late Color common2;
  late Color common4;
  late Color grayLight;
  late Color common6;
  late Color common7;

  late Color linearContainer1;
  late Color linearContainer2;
  late Color linearContainer3;
  late Color linearContainer4;
  late Color linearContainer5;
  late Color linearContainer6;
  late Color container1;
  late Color container2;
  late Color black1;
  late Color black2;
  late Color white;
  late Color green;
  late Color lightGreen;
  late Color lightPurple;
  late Color extraGray;

  late Color indigoAccent;
  late Color blueAccent;
  late Color redAccent;
  late Color redBorder;

  late Color sajuBlue;
  late Color sajuRed;
  late Color sajuYellow;
  late Color sajuWhite;
  late Color sajuBlack;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;
  String get captionLargeFamily => typography.captionLargeFamily;
  TextStyle get captionLarge => typography.captionLarge;
  String get captionMediumFamily => typography.captionMediumFamily;
  TextStyle get captionMedium => typography.captionMedium;

  CustomTypography get typography => ThemeTypography(this);
}

class LightModeTheme extends ThemeSetting {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFED5A2F);
  late Color secondary = const Color(0xFFFF5C00);
  late Color tertiary = const Color(0xFFFFECDB);
  late Color tertiary1 = const Color(0xFFFFD1A6);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color common0 = const Color(0xFFE7E7E7);
  late Color common2 = const Color(0xFFF8F8F8);

  late Color tertiary3 = const Color(0xFFFCE8FF);
  late Color tertiary2 = const Color(0xFFFFDDD0);
  late Color alternate = const Color(0xFFFFECDB);
  late Color primaryText = const Color(0xFF101213);
  late Color secondaryText = const Color(0xFF57636C);

  late Color accent1 = const Color(0x4D9489F5);
  late Color accent2 = const Color(0x4E39D2C0);
  late Color accent3 = const Color(0x4D6D5FED);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF24A891);
  late Color warning = const Color(0xFFCA6C45);
  late Color error = const Color(0xFFFF2B51);
  late Color info = const Color(0xFF6E62FA);

  late Color divider = const Color(0xFFDCDFE3);
  late Color tertiaryText = const Color(0xFFF8F9FA);
  late Color disabledText = const Color(0xFFADB5BD);
  late Color disabledBackground = const Color(0xFFDEE2E6);
  late Color grey900 = const Color(0xFF212529);
  late Color successBackground = const Color(0xFF89E768);
  late Color warningBackground = const Color(0xFFFFD159);
  late Color errorBackground = const Color(0xFFFF7387);

  late Color common1 = const Color(0xFFF3F3F3);

  late Color common3 = const Color(0xFFFFFFFF);
  late Color common4 = const Color(0x411D2429);
  late Color common5 = const Color(0xFFE0E3E7);
  late Color common6 = const Color(0xFF5633C1);
  late Color common7 = const Color(0xFFFF3B2F);
  late Color grayLight = const Color(0xFF8B97A2);

  late Color linearContainer1 = const Color(0xFFFFB36D);
  late Color linearContainer2 = const Color(0xFFFE61AE);
  late Color linearContainer3 = const Color(0xFFE0ADFF);
  late Color linearContainer4 = const Color(0xFF562DF3);
  late Color linearContainer5 = const Color(0xFFFF8ADE);
  late Color linearContainer6 = const Color(0xFF9755F2);

  late Color container1 = const Color(0xFFFF7046);
  late Color container2 = const Color(0xFFF96337);

  late Color black1 = const Color(0xFF212126);
  late Color black2 = const Color(0xFF000000);
  late Color white = const Color(0xFFFFFFFF);

  late Color green = const Color(0xFF206A0D);
  late Color lightGreen = const Color(0xFFF2F6D4);
  late Color lightPurple = const Color(0xFFE9E0F3);
  late Color extraGray = const Color(0xFFE0EAF3);

  late Color indigoAccent = const Color(0xFF0C83F0);
  late Color blueAccent = const Color(0xFFA7CFFF);
  late Color redAccent = const Color(0xFFFFB0A6);
  late Color redBorder = const Color(0xFFFF0000);
  //late Color greenAccent =const Color(0xFFA0EBCC);

  late Color sajuBlue = const Color(0xFF0C83F0);
  late Color sajuRed = const Color(0xFFFFB0A6);
  late Color sajuYellow = const Color(0xFFFFD159);
  late Color sajuWhite = const Color(0xFFFFFFFF);
  late Color sajuBlack = const Color(0xFF000000);

  late AlertStyle alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle: typography.bodyMedium,
    descTextAlign: TextAlign.start,
    animationDuration: const Duration(milliseconds: 300),
    backgroundColor: secondaryBackground,
    alertPadding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
    descPadding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
    buttonAreaPadding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 20.0),
    titlePadding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: const BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: typography.headlineLarge,
    titleTextAlign: TextAlign.start,
    alertAlignment: Alignment.center,
  );
}

abstract class CustomTypography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
  String get captionLargeFamily;
  TextStyle get captionLarge;
  String get captionMediumFamily;
  TextStyle get captionMedium;
}

class ThemeTypography extends CustomTypography {
  ThemeTypography(this.theme);

  final ThemeSetting theme;

//large Title 1= labelLarge
//large Title 2 = labelMedium
//large Title 3 = labelSmall
// Title 1 = titleLarge
// Title 2 = titleMedium
// Header 1 = headlineLarge
// Header 2 = headlineMedium
// Body 1 = bodyLarge
// Body 2 = bodyMedium
// Caption 1 = displayLarge
// Caption 2 = displayMedium
// Small = displaySmall

  static FontWeight regularFont = FontWeight.w400;
  static FontWeight mediumFont = FontWeight.w500;
  static FontWeight semiBoldFont = FontWeight.w600;
  static FontWeight boldFont = FontWeight.w700;
  static FontWeight extraBoldFont = FontWeight.w800;

  static double largeTitle1Font = 30;
  static double largeTitle2Font = 28;
  static double largeTitle3Font = 24;
  static double title1Font = 22;
  static double title2Font = 18;
  static double header1Font = 16;
  static double header2Font = 15;
  static double body1Font = 17;
  static double body2Font = 15;
  static double caption1Font = 13;
  static double caption2Font = 12;
  static double smallFont = 10;

  String get displayLargeFamily => 'Pretendard';
  TextStyle get displayLarge => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 57.0,
      );
  String get displayMediumFamily => 'Pretendard';
  TextStyle get displayMedium => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 45.0,
      );
  String get displaySmallFamily => 'Pretendard';
  TextStyle get displaySmall => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: regularFont,
        color: theme.secondaryBackground,
        fontSize: smallFont,
      );
  String get headlineLargeFamily => 'Pretendard';
  TextStyle get headlineLarge => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: mediumFont,
        color: theme.white,
        fontSize: header1Font,
      );
  String get headlineMediumFamily => 'Pretendard';
  TextStyle get headlineMedium => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: mediumFont,
        color: theme.secondaryBackground,
        fontSize: header2Font,
      );
  String get headlineSmallFamily => 'Pretendard';
  TextStyle get headlineSmall => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      );
  String get titleLargeFamily => 'Pretendard';
  TextStyle get titleLarge => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: semiBoldFont,
        color: theme.primaryText,
        fontSize: title1Font,
      );
  String get titleMediumFamily => 'Pretendard';
  TextStyle get titleMedium => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: semiBoldFont,
        color: theme.primaryText,
        fontSize: title2Font,
      );
  String get titleSmallFamily => 'Pretendard';
  TextStyle get titleSmall => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.secondaryBackground,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Pretendard';
  TextStyle get labelLarge => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: semiBoldFont,
        color: theme.primaryText,
        letterSpacing: -1,
        fontSize: largeTitle1Font,
      );
  String get labelMediumFamily => 'Pretendard';
  TextStyle get labelMedium => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: semiBoldFont,
        color: theme.primaryText,
        fontSize: largeTitle2Font,
      );
  String get labelSmallFamily => 'Pretendard';
  TextStyle get labelSmall => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: semiBoldFont,
        color: theme.primaryText,
        fontSize: largeTitle3Font,
      );
  String get bodyLargeFamily => 'Pretendard';
  TextStyle get bodyLarge => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: mediumFont,
        color: theme.primaryText,
        fontSize: body1Font,
      );
  String get bodyMediumFamily => 'Pretendard';
  TextStyle get bodyMedium => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: mediumFont,
        color: theme.primaryText,
        fontSize: body2Font,
      );
  String get bodySmallFamily => 'Pretendard';
  TextStyle get bodySmall => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get captionLargeFamily => 'Pretendard';
  TextStyle get captionLarge => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: mediumFont,
        color: theme.primaryText,
        fontSize: caption1Font,
      );

  String get captionMediumFamily => 'Pretendard';
  TextStyle get captionMedium => TextStyle(
        fontFamily: 'Pretendard',
        fontWeight: mediumFont,
        color: theme.primaryText,
        fontSize: caption2Font,
      );
}

class DarkModeTheme extends ThemeSetting {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFED5A2F);
  late Color secondary = const Color(0xFFFF5C00);
  late Color tertiary = const Color(0xFF383838);
  late Color tertiary1 = const Color(0xFF6D6D6D);
  late Color primaryBackground = const Color(0xFF000000);
  late Color secondaryBackground = const Color(0xFF383838);

  late Color tertiary3 = const Color(0xFFFCE8FF);
  late Color tertiary2 = const Color(0xFFFFDDD0);
  late Color alternate = const Color(0xFF512E10);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);
  late Color common2 = const Color(0xFF484848);
  late Color common0 = const Color(0xFFE7E7E7);
  // late Color secondaryBackground = const Color(0xFF101213);

  late Color accent1 = const Color(0x4C9489F5);
  late Color accent2 = const Color(0x4E39D2C0);
  late Color accent3 = const Color(0x4D6D5FED);
  late Color accent4 = const Color(0xB31D2428);
  late Color success = const Color(0xFF24A891);
  late Color warning = const Color(0xFFCA6C45);
  late Color error = const Color(0xFFE74852);
  late Color info = const Color(0xFF6E62FA);

  late Color divider = const Color(0xFF3D323B);
  late Color tertiaryText = const Color(0xFFA33B68);
  late Color disabledText = const Color(0xFFADB5BD);
  late Color disabledBackground = const Color(0xFF29746E);
  late Color grey900 = const Color(0xFF212529);
  late Color successBackground = const Color(0xFF89E768);
  late Color warningBackground = const Color(0xFFFFD159);
  late Color errorBackground = const Color(0xFFFF7387);

  late Color common3 = const Color(0xFFFFFFFF);
  late Color common1 = const Color(0x33000000);
  late Color common5 = const Color(0xFFE0E3E7);

  late Color common4 = const Color(0x411D2429);
  late Color grayLight = const Color(0xFF8B97A2);
  late Color common6 = const Color(0xFF5633C1);
  late Color common7 = const Color(0xFFFF3B2F);
  late Color linearContainer1 = const Color(0xFFFFB36D);

  late Color linearContainer2 = const Color(0xFFFE61AE);
  late Color linearContainer3 = const Color(0xFFE0ADFF);
  late Color linearContainer4 = const Color(0xFF562DF3);
  late Color linearContainer5 = const Color(0xFFFF8ADE);
  late Color linearContainer6 = const Color(0xFF9755F2);

  late Color container1 = const Color(0xFFFF7046);
  late Color container2 = const Color(0xFFF96337);

  late Color black1 = const Color(0xFF212126);
  late Color black2 = const Color(0xFF000000);
  late Color white = const Color(0xFFFFFFFF);

  late Color green = const Color(0xFF206A0D);
  late Color lightGreen = const Color(0xFFF2F6D4);
  late Color lightPurple = const Color(0xFFE9E0F3);
  late Color extraGray = const Color(0xFFE0EAF3);

  late Color indigoAccent = const Color(0xFF0C83F0);
  late Color blueAccent = const Color(0xFFA7CFFF);
  late Color redAccent = const Color(0xFFFFB0A6);
  late Color redBorder = const Color(0xFFFF0000);

  late Color sajuBlue = const Color(0xFF0C83F0);
  late Color sajuRed = const Color(0xFFFFB0A6);
  late Color sajuYellow = const Color(0xFFFFD159);
  late Color sajuWhite = const Color(0xFFFFFFFF);
  late Color sajuBlack = const Color(0xFF000000);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
