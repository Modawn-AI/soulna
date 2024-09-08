import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  final String buttonTitle;

  const WebViewPage({
    super.key,
    required this.title,
    required this.url,
    this.buttonTitle = '',
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    // #docregion webview_controller
    controller
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
          onPageFinished: (String url) {
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
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://we-ar.kr')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  // #docregion webview_widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).white,
      appBar: AppBar(
        backgroundColor: ThemeSetting.of(context).white,
        title: Text(
          widget.title,
          style: ThemeSetting.of(context).titleSmall,
        ),
        leading: IconButton(
          icon: Image.asset(
            "assets/icons/icon_arrow_left.png",
            height: 24,
            color: ThemeSetting.of(context).black1,
          ),
          onPressed: () async {
            if (await _controller.canGoBack()) {
              await _controller.goBack();
            } else {
              context.pop();
            }
          },
        ),
        actions: [
          if (widget.buttonTitle.isNotEmpty)
            Row(
              children: [
                CustomButtonWidget(
                  text: "LocaleKeys.create_text.tr()",
                  isTextBack: true,
                  onPressed: () async {
                    _sendEmail(context);
                  },
                  showLoadingIndicator: true,
                  options: CustomButtonOptions(
                    width: 96,
                    height: 32,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    textStyle: ThemeSetting.of(context).titleSmall.copyWith(
                          color: ThemeSetting.of(context).white,
                        ),
                    color: ThemeSetting.of(context).black1,
                    alignment: MainAxisAlignment.start,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                )
              ],
            ),
        ],
        centerTitle: true,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  // #enddocregion webview_widget

  Future<void> openDialog(HttpAuthRequest httpRequest) async {
    final TextEditingController usernameTextController = TextEditingController();
    final TextEditingController passwordTextController = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  autofocus: true,
                  controller: usernameTextController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: passwordTextController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // Explicitly cancel the request on iOS as the OS does not emit new
            // requests when a previous request is pending.
            TextButton(
              onPressed: () {
                httpRequest.onCancel();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                httpRequest.onProceed(
                  WebViewCredential(
                    user: usernameTextController.text,
                    password: passwordTextController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Authenticate'),
            ),
          ],
        );
      },
    );
  }

  void _sendEmail(BuildContext context) async {
    // UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    String osVersionInfo = '';
    String deviceModelInfo = '';
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var brand = androidInfo.brand;
      var deviceModel = androidInfo.model;
      var osVersion = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      osVersionInfo = "OS - $osVersion : SDK - $sdkInt";
      deviceModelInfo = "$brand $deviceModel";
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      // var deviceModel = iosInfo.model;
      var deviceName = iosInfo.utsname.machine;
      var osVersion = iosInfo.systemVersion;
      var systemName = iosInfo.systemName;
      osVersionInfo = "$systemName $osVersion";
      deviceModelInfo = deviceName;
    }
    final Email email = Email(
      // body: LocaleKeys.report_email_body_text.tr(namedArgs: {
      //   "uuid": userProvider.user.userId,
      //   "OS_info": osVersionInfo,
      //   "app_version": kAppVersion,
      //   "language_info": context.locale.languageCode,
      //   "device_info": deviceModelInfo,
      // }),
      body: "",
      subject: " LocaleKeys.report_email_title_text.tr()",
      recipients: ["cto@modawn.ai"],
      attachmentPaths: [],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
}
