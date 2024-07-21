// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
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

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
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

  CustomTypography get typography => ThemeTypography(this);
}

class LightModeTheme extends ThemeSetting {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF9489F5);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFF6D5FED);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryText = const Color(0xFF101213);
  late Color secondaryText = const Color(0xFF57636C);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4D9489F5);
  late Color accent2 = const Color(0x4E39D2C0);
  late Color accent3 = const Color(0x4D6D5FED);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF24A891);
  late Color warning = const Color(0xFFCA6C45);
  late Color error = const Color(0xFFE74852);
  late Color info = const Color(0xFFFFFFFF);

  late Color divider = const Color(0xFFDCDFE3);
  late Color tertiaryText = const Color(0xFFF8F9FA);
  late Color disabledText = const Color(0xFFADB5BD);
  late Color disabledBackground = const Color(0xFFDEE2E6);
  late Color grey900 = const Color(0xFF212529);
  late Color successBackground = const Color(0xFF89E768);
  late Color warningBackground = const Color(0xFFFFD159);
  late Color errorBackground = const Color(0xFFFF7387);

  late Color common0 = const Color(0x00FFFFFF);
  late Color common3 = const Color(0xFFFFFFFF);
  late Color common1 = const Color(0x33000000);
  late Color common5 = const Color(0xFFE0E3E7);
  late Color common2 = const Color(0xFF57636C);
  late Color common4 = const Color(0x411D2429);
  late Color grayLight = const Color(0xFF8B97A2);
  late Color common6 = const Color(0xFF5633C1);
  late Color common7 = const Color(0xFFFF3B2F);

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
}

class ThemeTypography extends CustomTypography {
  ThemeTypography(this.theme);

  final ThemeSetting theme;

  String get displayLargeFamily => 'Urbanist';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Urbanist',
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 57.0,
      );
  String get displayMediumFamily => 'Urbanist';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Urbanist',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 45.0,
      );
  String get displaySmallFamily => 'Urbanist';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Urbanist',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      );
  String get headlineLargeFamily => 'Urbanist';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Urbanist',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Urbanist';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Urbanist',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 28.0,
      );
  String get headlineSmallFamily => 'Urbanist';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Urbanist',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      );
  String get titleLargeFamily => 'Manrope';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Manrope',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleMediumFamily => 'Manrope';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Manrope',
        color: theme.info,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Manrope';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Manrope',
        color: theme.info,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Manrope';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Manrope',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelMediumFamily => 'Manrope';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Manrope',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get labelSmallFamily => 'Manrope';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Manrope',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
      );
  String get bodyLargeFamily => 'Manrope';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Manrope',
        color: theme.primaryText,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Manrope';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Manrope',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Manrope';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Manrope',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get captionLargeFamily => 'Plus Jakarta Sans';
  TextStyle get captionLarge => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 10.0,
      );
}

class DarkModeTheme extends ThemeSetting {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF9489F5);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFF6D5FED);
  late Color alternate = const Color(0xFF22282F);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);
  late Color primaryBackground = const Color(0xFF1A1F24);
  late Color secondaryBackground = const Color(0xFF101213);
  late Color accent1 = const Color(0x4C9489F5);
  late Color accent2 = const Color(0x4E39D2C0);
  late Color accent3 = const Color(0x4D6D5FED);
  late Color accent4 = const Color(0xB31D2428);
  late Color success = const Color(0xFF24A891);
  late Color warning = const Color(0xFFCA6C45);
  late Color error = const Color(0xFFE74852);
  late Color info = const Color(0xFFFFFFFF);

  late Color divider = const Color(0xFF3D323B);
  late Color tertiaryText = const Color(0xFFA33B68);
  late Color disabledText = const Color(0xFF58D1A1);
  late Color disabledBackground = const Color(0xFF29746E);
  late Color grey900 = const Color(0xFF212529);
  late Color successBackground = const Color(0xFF89E768);
  late Color warningBackground = const Color(0xFFFFD159);
  late Color errorBackground = const Color(0xFFFF7387);

  late Color common0 = const Color(0x00FFFFFF);
  late Color common3 = const Color(0xFFFFFFFF);
  late Color common1 = const Color(0x33000000);
  late Color common5 = const Color(0xFFE0E3E7);
  late Color common2 = const Color(0xFF57636C);
  late Color common4 = const Color(0x411D2429);
  late Color grayLight = const Color(0xFF8B97A2);
  late Color common6 = const Color(0xFF5633C1);
  late Color common7 = const Color(0xFFFF3B2F);
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
