import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';

class JsonBase64Service {
  static final Logger _logger = Logger('JsonBase64Service');
  static String encodeJsonToBase64(Map<String, dynamic> data) {
    try {
      String jsonString = jsonEncode(data);
      String base64Encoded = base64Encode(utf8.encode(jsonString));
      _logger.fine('Successfully encoded JSON to Base64: ${base64Encoded.substring(0, min(50, base64Encoded.length))}...');
      return base64Encoded;
    } catch (e) {
      _logger.severe('Error encoding JSON to Base64: $e');
      rethrow;
    }
  }

  static Map<String, dynamic> decodeBase64ToJson(String base64String) {
    try {
      String jsonString = utf8.decode(base64Decode(base64String));
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      _logger.fine('Successfully decoded Base64 to JSON: ${jsonData.toString().substring(0, min(50, jsonData.toString().length))}...');
      return jsonData;
    } catch (e) {
      _logger.severe('Error decoding Base64 to JSON: $e');
      rethrow;
    }
  }

  static Map<String, dynamic> processRequestData(Map<String, dynamic> requestData) {
    try {
      if (!requestData.containsKey('data')) {
        throw ArgumentError("Request data must contain a 'data' field");
      }

      String base64String = requestData['data'];
      return decodeBase64ToJson(base64String);
    } catch (e) {
      _logger.severe('Error processing request data: $e');
      rethrow;
    }
  }

  static Map<String, String> prepareResponseData(Map<String, dynamic> responseData) {
    try {
      String base64Encoded = encodeJsonToBase64(responseData);
      return {'data': base64Encoded};
    } catch (e) {
      _logger.severe('Error preparing response data: $e');
      rethrow;
    }
  }

  static Future<String> encodeFileToBase64(String filePath) async {
    try {
      File file = File(filePath);
      List<int> fileBytes = await file.readAsBytes();
      String base64Encoded = base64Encode(fileBytes);
      _logger.fine('Successfully encoded file to Base64: ${base64Encoded.substring(0, min(50, base64Encoded.length))}...');
      return base64Encoded;
    } catch (e) {
      _logger.severe('Error encoding file to Base64: $e');
      rethrow;
    }
  }
}

int min(int a, int b) => (a < b) ? a : b;
