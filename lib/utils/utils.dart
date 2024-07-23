import 'dart:convert';
import 'dart:io';

import 'package:Soulna/utils/package_exporter.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  // static Future<String> createDeeplink(String deepLinkUrl, String parameterName, Map<String, String> parameter) async {
  //   DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
  //     uriPrefix: kDeepLinkCreatePrefix,
  //     link: Uri.parse('$deepLinkUrl?$parameterName=${parameter['param'] ?? ''}'),
  //     androidParameters: const AndroidParameters(
  //       packageName: kGooglePackageName,
  //       minimumVersion: 1,
  //     ),
  //     iosParameters: const IOSParameters(
  //       bundleId: kAppleBundleId,
  //       minimumVersion: '0',
  //       appStoreId: kAppStoreId,
  //     ),
  //     socialMetaTagParameters: SocialMetaTagParameters(
  //       title: parameter['title'],
  //       description: parameter['description'],
  //       imageUrl: Uri.parse(parameter['imageUrl']!),
  //     ),
  //   );

  //   // final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
  //   // return dynamicLink.toString();

  //   final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  //   return dynamicLink.shortUrl.toString();
  // }

  static void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static void copyToClipboard(BuildContext context, String copyUrl, String description) async {
    await Clipboard.setData(ClipboardData(text: copyUrl));
    AlertManager().toastMessage(context, description, "success");
  }

  static String encodeToBase64(dynamic conversation) {
    String jsonStr = jsonEncode(conversation); // JSON으로 변환
    String base64Str = base64Encode(utf8.encode(jsonStr)); // Base64로 인코딩
    return base64Str;
  }

  static Future<String> decodeAndSaveAudioFile(String base64Audio, {String fileName = 'response_audio'}) async {
    final bytes = base64Decode(utf8.decode(base64Audio.codeUnits)); // Base64 디코딩
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.mp3');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  static String extractDate(String input) {
    List<String> parts = input.split('/');
    String fileName = parts.last;
    String dateString = fileName.split('.').first;

    return dateString;
  }

  static String formatDate(String date) {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);
    return DateFormat('MMMM d').format(parsedDate) + getDayOfMonthSuffix(parsedDate.day) + DateFormat(', yyyy').format(parsedDate);
  }

  static String getDayOfMonthSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static String cardCreateJsonString(String date, String actionType, String response) {
    Map<String, dynamic> cardInfo = {"action_type": actionType, "response": response};

    Map<String, dynamic> jsonStructure = {
      date: {
        "card": [cardInfo]
      }
    };

    return jsonEncode(jsonStructure);
  }

  static String userInfoCreateJsonString(Map<String, dynamic> personalInfo, Map<String, dynamic> challenges) {
    Map<String, dynamic> jsonStructure = {
      "personal_info": personalInfo,
      "challenges": challenges,
    };

    return jsonEncode(jsonStructure);
  }

  static String getTimezoneOffset() {
    DateTime now = DateTime.now();
    Duration offset = now.timeZoneOffset;
    String sign = offset.isNegative ? '-' : '+';
    int hours = offset.inHours.abs();
    int minutes = offset.inMinutes.abs() % 60;
    return '$sign${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}
