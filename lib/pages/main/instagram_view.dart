import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_login/insta_login.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Soulna/utils/const.dart';

class InstagramView extends StatefulWidget {
  const InstagramView({
    Key? key,
    this.redirectUrl,
    this.onComplete,
    this.instaAppId,
    this.instaAppSecret,
    this.javascriptChannel = 'InstaLogin',
  }) : super(key: key);

  final String? redirectUrl, instaAppId, instaAppSecret, javascriptChannel;
  final Function(String, String, String)? onComplete;

  @override
  State<InstagramView> createState() => _InstagramViewState();
}

class _InstagramViewState extends State<InstagramView> {
  late final WebViewController controller;
  final Instaservices services = Instaservices();
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkConnectionStatus();
    if (!kIsWeb) {
      _initializeWebViewController();
    }
  }

  Future<void> _checkConnectionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isConnected = prefs.getString(kInstagramTokenSP) != null;
    });
  }

  void _initializeWebViewController() {
    final WebViewController control = WebViewController.fromPlatformCreationParams(
      const PlatformWebViewControllerCreationParams(),
    );

    control
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
            Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
        ''');
          },
          onNavigationRequest: (NavigationRequest request) async {
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) async {
            debugPrint('url change to ${change.url}');
            final url = change.url ?? '';
            debugPrint('url: $url');
            if (url.contains(widget.redirectUrl ?? '')) {
              await onRedirectUrl(url);
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        widget.javascriptChannel ?? '',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..runJavaScript(widget.javascriptChannel ?? '')
      ..loadRequest(
        Uri.parse(
          services.getUrl(
            appid: widget.instaAppId ?? '',
            redirectUrl: widget.redirectUrl ?? '',
          ),
        ),
      );

    controller = control;
  }

  Future<void> onRedirectUrl(String url) async {
    final code = services.getAuthorizationCode(
      url: url,
      redirectUrl: widget.redirectUrl ?? '',
    );
    setState(() {});
    await services
        .getTokenAndUserID(
      code: code,
      appid: widget.instaAppId ?? '',
      redirectUrl: widget.redirectUrl ?? '',
      appSecret: widget.instaAppSecret ?? '',
    )
        .then(
      (token) async {
        debugPrint('isDone: $token');
        if (token.isNotEmpty) {
          await services
              .getUsername(
            accesstoken: token['access_token'].toString(),
            userid: token['user_id'].toString(),
          )
              .then(
            (username) async {
              debugPrint('username: $username');
              await _saveConnectionStatus(token['access_token'].toString());
              setState(() {
                _isConnected = true;
                widget.onComplete!(
                  token['access_token'].toString(),
                  token['user_id'].toString(),
                  username,
                );
              });
              Navigator.of(context).pop();
            },
          );
        }
      },
    );
  }

  Future<void> _saveConnectionStatus(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kInstagramTokenSP, token);
  }

  Future<void> disconnect() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kInstagramTokenSP);
    setState(() {
      _isConnected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Connection'),
        actions: [
          if (_isConnected)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: disconnect,
            ),
        ],
      ),
      body: SafeArea(
        child: _isConnected
            ? const Center(child: Text('Connected to Instagram'))
            : kIsWeb
                ? const Center(child: Text('Web version is under construction'))
                : WebViewWidget(controller: controller),
      ),
    );
  }
}
