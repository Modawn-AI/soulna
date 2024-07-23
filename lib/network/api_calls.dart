import 'dart:convert';

import 'package:Soulna/utils/json.dart';
import 'package:Soulna/models/notification_model.dart';
import 'package:Soulna/utils/package_exporter.dart';

class ApiCalls {
  Future<String> versionInfo() async {
    var data = await NetworkManager().getRequest('init');

    String version = data['version'];
    NetworkManager().setVersion(version);

    return version;
  }

  Future<dynamic> googleLogin(String idToken) async {
    try {
      var data = await NetworkManager().postRequest('auth/login/google', {
        'id_token': idToken,
      });

      // if (data != null) {
      //   debugPrint('guestLogin: ${data['accessToken']}');
      //   await NetworkManager().saveTokens(data['accessToken'], data['refreshToken']);
      // }

      return data;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> appleLogin(String idToken) async {
    try {
      var data = await NetworkManager().postRequest('auth/login/apple', {
        'id_token': idToken,
      });

      return data;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> todayDataCall() async {
    try {
      var data = await NetworkManager().getRequest('audio/today');
      if (data['data'] == null) return null;
      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      debugPrint('todayDataCall: $e');
    }
  }

  Future<dynamic> getUserData() async {
    try {
      final data = await NetworkManager().getRequest('dearme/user-data');
      if (data['data'] == null) return null;
      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      debugPrint('getUserData: $e');
      return null;
    }
  }

  Future<dynamic> getDateToLetter(String date) async {
    try {
      final data = await NetworkManager().getRequest('dearme/play/$date');
      if (data['data'] == null) return null;
      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      debugPrint('getDateToLetter: $e');
      return null;
    }
  }

  Future<dynamic> onboardingLetter({required String info}) async {
    try {
      String encodeData = JsonBase64Service.encodeJsonToBase64(jsonDecode(info));
      final data = await NetworkManager().postRequest('content/onboarding_letter', {"data": encodeData});
      if (data['data'] == null) return null;

      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      if (e is CustomException) {
        debugPrint('CustomException in snsLogin: ${e.message}');
        rethrow;
      } else {
        debugPrint('Unexpected error in contentPurchase: $e');
        throw CustomException('Unexpected error occurred', 'UNEXPECTED_ERROR');
      }
    }
  }

  Future<dynamic> getLetterList() async {
    try {
      final data = await NetworkManager().getRequest('dearme/user-list');
      if (data['data'] == null) return null;
      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      debugPrint('getLetterList: $e');
      return null;
    }
  }

  Future<dynamic> setDailyCardAnswer({required String info}) async {
    try {
      String encodeData = JsonBase64Service.encodeJsonToBase64(jsonDecode(info));
      final data = await NetworkManager().postRequest('user/card_edit', {"data": encodeData});
      if (data['data'] == null) return null;

      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      if (e is CustomException) {
        debugPrint('CustomException in snsLogin: ${e.message}');
        rethrow;
      } else {
        debugPrint('Unexpected error in contentPurchase: $e');
        throw CustomException('Unexpected error occurred', 'UNEXPECTED_ERROR');
      }
    }
  }

  Future<dynamic> updateUserInfo({required String info}) async {
    try {
      String encodeData = JsonBase64Service.encodeJsonToBase64(jsonDecode(info));
      final data = await NetworkManager().postRequest('user/profile_edit', {"data": encodeData});
      if (data['data'] == null) return null;

      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      if (e is CustomException) {
        debugPrint('CustomException in snsLogin: ${e.message}');
        rethrow;
      } else {
        debugPrint('Unexpected error in contentPurchase: $e');
        throw CustomException('Unexpected error occurred', 'UNEXPECTED_ERROR');
      }
    }
  }

/*
{
  "FCM": "cN9ztd7HTPS5AMPgA12345:APA91bHCKNVTdRNZKx0aBc1234567890abcdefghijklmnopqrstuvwxyz1234567890",
  "notification_preferences": {
    "consent": true,
    "notification": true,
    "time_of_the_alarm": "08:00:00",
    "time_zone_offset": "+09:00"
  }
}
*/

  Future<dynamic> notificationTokenSave({required String info}) async {
    try {
      String encodeData = JsonBase64Service.encodeJsonToBase64(jsonDecode(info));
      final data = await NetworkManager().postRequest('notification/push', {"data": encodeData});
      if (data['data'] == null) return null;

      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      if (e is CustomException) {
        debugPrint('CustomException in snsLogin: ${e.message}');
        rethrow;
      } else {
        debugPrint('Unexpected error in contentPurchase: $e');
        throw CustomException('Unexpected error occurred', 'UNEXPECTED_ERROR');
      }
    }
  }

  // api/audio/upload

  Future<bool> getUnreadNotification() async {
    try {
      var data = await NetworkManager().getRequest('notification/unread/count');
      UnreadNotificationModel unread = UnreadNotificationModel.fromJson(data);
      return unread.count > 0 ? true : false;
    } catch (e) {
      debugPrint('🚨 api_calls.dart > getUnreadNotification: $e');
      rethrow;
    }
  }
}
