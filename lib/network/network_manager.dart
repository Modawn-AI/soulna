import 'dart:async';

import 'package:Soulna/manager/social_manager.dart';
import 'package:Soulna/utils/json.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:Soulna/utils/const.dart';
import 'package:Soulna/utils/shared_preference.dart';

const kTokenKey = 'token';

class CustomException implements Exception {
  final String message;
  final String code;

  CustomException(this.message, this.code);

  @override
  String toString() {
    return 'CustomException: $message (code: $code)';
  }
}

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  factory NetworkManager() => _instance;

  NetworkManager._internal();
  final TokenService _tokenService = TokenService();
  final SocialManager _authService = SocialManager.getInstance();

  final String _versionUrlApi = "https://app.getdear.me/api"; // 테스트 서버 URL
  String _baseUrlApi = "https://app.getdear.me/api"; // 테스트 서버 URL
  get baseUrlApi => _baseUrlApi;

  // 인증 토큰
  String _bearerToken = '';
  String _refreshToken = '';
  Locale? locale;
  final Dio _dio = Dio();

  // 버전 정보
  final String version = '1.0.0';

  bool _isRefreshing = false;
  final List<QueuedRequest> _requestQueue = [];

  get bearerToken => _bearerToken;

  get refreshToken => _refreshToken;

  String asQueryParams(Map<String, dynamic> map) => map.entries.map((e) => "${e.key}=${e.value}").join('&');

  void initNetwork() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'App-Version': version,
      },
    );
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('interceptors Request: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('interceptors Response: ${response.statusCode} ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('Error: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  void setBaseUrlApi(String url) {
    _baseUrlApi = url;
  }

  void setBearerToken(String token) {
    if (token.isEmpty) return;
    _dio.options.headers['Authorization'] = 'Bearer $token';
    _bearerToken = token;
  }

  void setRefreshToken(String token) {
    _refreshToken = token;
  }

  void setLocale(Locale locale) {
    locale = locale;
    _dio.options.headers['Accept-Language'] = locale.languageCode;
  }

  void setVersion(String version) {
    _dio.options.headers['App-Version'] = version;
  }

  Future<String?> _refreshAccessToken() async {
    try {
      final User? user = await SocialManager.getInstance().refreshAccessToken();
      if (user != null) {
        final String? newAccessToken = await _authService.getAccessToken();
        final String? newRefreshToken = user.refreshToken;
        if (newAccessToken != null && newRefreshToken != null) {
          await _tokenService.saveTokens(newAccessToken, newRefreshToken);
        }
        return newAccessToken;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> _getValidAccessToken() async {
    String? accessToken = await _tokenService.getAccessToken();
    if (accessToken == null || _authService.isAccessTokenExpired(accessToken)) {
      accessToken = await _refreshAccessToken();
      if (accessToken == null) {
        final user = await _authService.signInWithGoogle(); // 여기서 Google 또는 Apple 로그인을 시도해야 함
        if (user != null) {
          accessToken = await _authService.getAccessToken();
          final refreshToken = user.refreshToken;
          if (accessToken != null && refreshToken != null) {
            await _tokenService.saveTokens(accessToken, refreshToken);
          }
        }
      }
    }
    return accessToken;
  }

  Future<dynamic> postVersionRequest(String appVersion) async {
    try {
      var url = '$_versionUrlApi/init';
      var response = await _dio.post(url, data: {'version': appVersion});

      if (response.statusCode == 200) {
        setBaseUrlApi(response.data['url']);
        return response.data;
      } else if (response.statusCode == 401) {
        throw CustomException('Unauthorized', 'UNAUTHORIZED');
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getRequest(String endpoint, {Map<String, dynamic>? params}) async {
    return _enqueueRequest(() async {
      // await _ensureTokenIsValid();
      params ??= {};
      String url = '$_baseUrlApi/$endpoint';
      if (params!.isNotEmpty) {
        final lastUriPart = _baseUrlApi.split('/').last;
        final needsParamSpecifier = !lastUriPart.contains('?');
        url = '$url${needsParamSpecifier ? '?' : ''}${asQueryParams(params!)}';
      }
      return await _dio.get(url);
    });
  }

  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> data) async {
    return _enqueueRequest(() async {
      // await _ensureTokenIsValid();
      var url = '$_baseUrlApi/$endpoint';
      return await _dio.post(url, data: data);
    });
  }

  Future<dynamic> postRequestList(String endpoint, List<Map<String, dynamic>> data) async {
    return _enqueueRequest(() async {
      // await _ensureTokenIsValid();
      var url = '$_baseUrlApi/$endpoint';
      return await _dio.post(url, data: data);
    });
  }

  Future<dynamic> uploadFile(String endpoint, Map<String, dynamic> data) async {
    return _enqueueRequest(() async {
      // await _ensureTokenIsValid();
      String encodeData = JsonBase64Service.encodeJsonToBase64(data);
      var url = '$_baseUrlApi/$endpoint';
      return await _dio.post(url, data: {"data": encodeData});
    });
  }

  Future<void> saveTokens(String accessTokenParam, String refreshTokenParam) async {
    setBearerToken(accessTokenParam);
    setRefreshToken(refreshTokenParam);

    await SharedPreferencesManager.setString(
      key: kAccessTokenSPKey,
      value: accessTokenParam,
    );
    await SharedPreferencesManager.setString(
      key: kRefreshTokenSPKey,
      value: refreshTokenParam,
    );
  }

  Future<String?> getAccessToken() async {
    if (_bearerToken.isNotEmpty) return _bearerToken;
    return await SharedPreferencesManager.getString(key: kAccessTokenSPKey);
  }

  Future<String?> getRefreshToken() async {
    if (_refreshToken.isNotEmpty) return _refreshToken;
    return await SharedPreferencesManager.getString(key: kRefreshTokenSPKey);
  }

  Future<void> refreshTokenIfNeeded() async {
    if (_isRefreshing) return;
    _isRefreshing = true;

    try {
      if (_refreshToken.isEmpty) {
        SharedPreferencesManager.deleteAllKeys("refreshTokenIfNeeded == refreshToken is empty");
        _isRefreshing = false;
        return;
      }
      setBearerToken(_refreshToken);
      final response = await _dio.post('$_baseUrlApi/user/refresh');
      saveTokens(response.data['accessToken'], response.data['refreshToken']);

      _processQueue();
    } catch (e) {
      _handleRefreshError(e);
      // throw CustomException('Failed to refresh token', 'TOKEN_REFRESH_FAILED');
    } finally {
      _isRefreshing = false;
    }
  }

  void _handleRefreshError(dynamic error) {
    while (_requestQueue.isNotEmpty) {
      final queuedRequest = _requestQueue.removeAt(0);
      queuedRequest.completer.completeError(_handleError(error));
    }
  }

  Future<dynamic> _enqueueRequest(Future<Response<dynamic>> Function() requestFunction) async {
    final completer = Completer<dynamic>();
    _requestQueue.add(QueuedRequest(requestFunction, completer));
    debugPrint('Request added to queue. Queue length: ${_requestQueue.length}');
    if (!_isRefreshing) {
      _processQueue();
    }
    return completer.future;
  }

  void _processQueue() {
    debugPrint('Processing queue. Queue length: ${_requestQueue.length}');
    while (_requestQueue.isNotEmpty) {
      final queuedRequest = _requestQueue.removeAt(0);
      queuedRequest.requestFunction().then((response) {
        queuedRequest.completer.complete(response.data);
      }).catchError((error) {
        if (error is DioException && error.response?.statusCode == 401) {
          _handleTokenExpiration(queuedRequest);
        } else {
          queuedRequest.completer.completeError(_handleError(error));
        }
      });
    }
  }

  void _handleTokenExpiration(QueuedRequest queuedRequest) async {
    debugPrint('Handling token expiration. Queue length before: ${_requestQueue.length}');
    _requestQueue.insert(0, queuedRequest);
    await refreshTokenIfNeeded().catchError((error) {
      _handleRefreshError(error);
    });
    if (!_isRefreshing) {
      _processQueue();
    }
    debugPrint('Handling token expiration. Queue length after: ${_requestQueue.length}');
  }

  dynamic _handleError(dynamic error) {
    debugPrint('NetworkManager Error: $error');

    if (error is DioException) {
      final errorData = error.response?.data;
      if (errorData != null && errorData is Map<String, dynamic>) {
        final message = errorData['message'];
        final code = errorData['code'] ?? "UNKNOWN";
        return CustomException(message, code);
      }
    }

    return error;
  }

  Future<void> _ensureTokenIsValid() async {
    final accessToken = await getAccessToken();
    // accessToken이 없으면 게스트 로그인이 필요한 상태
    if (accessToken == null) {
      return;
    }
    DateTime expirationDate = JwtDecoder.getExpirationDate(accessToken);

    debugPrint(expirationDate.toString());
    if (JwtDecoder.isExpired(accessToken)) {
      await refreshTokenIfNeeded();
    }
  }
}

class QueuedRequest {
  final Future<Response<dynamic>> Function() requestFunction;
  final Completer<dynamic> completer;

  QueuedRequest(this.requestFunction, this.completer);
}

class TokenService {
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await SharedPreferencesManager.setString(key: kAccessTokenSPKey, value: accessToken);
    await SharedPreferencesManager.setString(key: kRefreshTokenSPKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return SharedPreferencesManager.getString(key: kAccessTokenSPKey);
  }

  Future<String?> getRefreshToken() async {
    return SharedPreferencesManager.getString(key: kRefreshTokenSPKey);
  }

  Future<void> clearTokens() async {
    await SharedPreferencesManager.removeString(key: kAccessTokenSPKey);
    await SharedPreferencesManager.removeString(key: kRefreshTokenSPKey);
  }
}
