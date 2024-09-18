import 'package:flutter/material.dart';

class CustomLocale {
  static String getLanguageCodeToName(String languageCode) {
    switch (languageCode) {
      case 'zh':
        return "Chinese";
      case 'en':
        return "English";
      case 'fr':
        return "French";
      case 'de':
        return "German";
      case 'ja':
        return "Japanese";
      case 'ko':
        return "Korean";
      case 'mn':
        return "Mongolian";
      default:
        return 'English';
    }
  }

  static Locale getLanguageCode(String languageName) {
    switch (languageName) {
      case 'Chinese':
        return const Locale('zh');
      case 'English':
        return const Locale('en');
      case 'French':
        return const Locale('fr');
      case 'German':
        return const Locale('de');
      case 'Japanese':
        return const Locale('ja');
      case 'Korean':
        return const Locale('ko');
      case 'Mongolian':
        return const Locale('mn');
      default:
        return const Locale('en');
    }
  }

  static Locale getLanguageCountryCode(String languageName) {
    switch (languageName) {
      case 'Chinese':
        return const Locale('zh', 'CN');
      case 'English':
        return const Locale('en', 'US');
      case 'French':
        return const Locale('fr', 'FR');
      case 'German':
        return const Locale('de', 'DE');
      case 'Japanese':
        return const Locale('ja', 'JP');
      case 'Korean':
        return const Locale('ko', 'KR');
      case 'Mongolian':
        return const Locale('mn', 'MN');
      default:
        return const Locale('en', 'US');
    }
  }

  static String getFlag(String languageCode) {
    switch (languageCode) {
      case 'Chinese':
        return '🇨🇳'; // 대표 국가: China
      case 'English':
        return '🇺🇸'; // 대표 국가: United States
      case 'French':
        return '🇫🇷'; // 대표 국가: France
      case 'German':
        return '🇩🇪'; // 대표 국가: Germany
      case 'Japanese':
        return '🇯🇵'; // 대표 국가: Japan
      case 'Korean':
        return '🇰🇷'; // 대표 국가: South Korea
      case 'Mongolian':
        return '🇲🇳'; // 대표 국가: Mongolia
      default:
        return '🏳'; // 기본 플래그
    }
  }
}
