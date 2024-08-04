import 'dart:convert';

import 'package:Soulna/utils/json.dart';
import 'package:Soulna/models/notification_model.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:dio/dio.dart';

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

  Future<dynamic> getUserData() async {
    try {
      final data = await NetworkManager().getRequest('user/profile');
      if (data['data'] == null) return null;
      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      debugPrint('getUserData: $e');
      return null;
    }
  }

  Future<dynamic> tenTwelveCall({required String info}) async {
    try {
      String encodeData = JsonBase64Service.encodeJsonToBase64(jsonDecode(info));
      final data = await NetworkManager().postRequest('content/tentwelve', {"data": encodeData});
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

  Future<dynamic> sajuDailyCall({required String info}) async {
    try {
      // String encodeData = JsonBase64Service.encodeJsonToBase64(jsonDecode(info));
      final data = await NetworkManager().postRequest('content/daily', {"data": ""});
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

  Future<dynamic> journalDailyCall({required List<String> info}) async {
    try {
      dynamic payload = {
        "image": info
      };
      String jsonString = jsonEncode(payload);
      String encodeData = JsonBase64Service.encodeJsonToBase64(jsonDecode(jsonString));
      final data = await NetworkManager().postRequest('content/journal', {"data": encodeData});
      if (data['data'] == null) return null;

      dynamic decodeData = JsonBase64Service.decodeBase64ToJson(data['data']);
      return decodeData;
    } catch (e) {
      if (e is CustomException) {
        debugPrint('CustomException in contentPurchase: ${e.message}');
        rethrow;
      } else {
        debugPrint('Unexpected error in contentPurchase: $e');
        throw CustomException('Unexpected error occurred', 'UNEXPECTED_ERROR');
      }
    }
  }

}
