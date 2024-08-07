import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferencesManager extends ChangeNotifier {
  static const FlutterSecureStorage _preferences = FlutterSecureStorage();

  static Future<void> setString(
      {required String key, required String value}) async {
    await _preferences.write(key: key, value: value);
  }

  static Future<String?> getString({required String key}) async {
    return await _preferences.read(key: key);
  }

  static Future<void> setBool(
      {required String key, required bool value}) async {
    await _preferences.write(key: key, value: value.toString());
  }

  static Future<bool?> getBool({required String key}) async {
    String? value = await _preferences.read(key: key);
    if (value != null) {
      return value.toLowerCase() == 'true';
    }
    return null;
  }

  static Future<String> getStringDefault(String key,
      {String? defaultValue}) async {
    String? value = await _preferences.read(key: key);
    if (value == null) {
      // 키가 존재하지 않을 경우 기본값으로 설정
      value = defaultValue ?? "";
      await _preferences.write(key: key, value: value);
    }

    return value;
  }

  static Future<bool> hasStringData({String? key}) async {
    String? value = await _preferences.read(key: key!);
    bool isKey = false;
    if (value != null) {
      isKey = true;
    }
    return isKey;
  }

  static Future<void> removeString({required String key}) async {
    await _preferences.delete(key: key);
  }

  static Future<void> saveMediaListToSharedPreferences(
      {required List<dynamic> mediaList, required String key}) async {
    final String mediaListJson = jsonEncode(mediaList);
    await _preferences.write(key: key, value: mediaListJson);
  }

  static Future<List<dynamic>> getMediaListFromSharedPreferences(
      {required String key}) async {
    final String? mediaListJson = await _preferences.read(key: key);
    if (mediaListJson != null) {
      return jsonDecode(mediaListJson);
    }
    return [];
  }

  static Future<void> deleteAllKeys(String location) async {
    try {
      await _preferences.deleteAll();
      debugPrint("모든 키가 성공적으로 삭제되었습니다. ----> $location");
    } catch (e) {
      debugPrint("키 삭제 중 오류 발생: $e");
    }
  }
}