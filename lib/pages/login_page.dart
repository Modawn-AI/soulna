import 'dart:io';

import 'package:Soulna/manager/social_manager.dart';
import 'package:Soulna/utils/package_exporter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ThemeSetting.of(context).primaryBackground,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    LocaleKeys.common_login_sync_title.tr(),
                    style: ThemeSetting.of(context).titleMedium.copyWith(
                          color: ThemeSetting.of(context).primaryText,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  if (Platform.isIOS)
                    SizedBox(
                      width: double.infinity,
                      child: CustomButtonWidget(
                        text: LocaleKeys.common_login_apple.tr(),
                        icon: Image.asset(
                          "assets/icons/icon_apple.png",
                          height: 24,
                          color: ThemeSetting.of(context).primaryText,
                        ),
                        onPressed: () async {
                          await SocialManager.getInstance().loginWithApple(callback: (value) {
                            if (value.isNotEmpty) {
                              context.goNamed("UserInfoInputPage");
                            }
                          });
                        },
                        options: CustomButtonOptions(
                          height: 48,
                          textStyle: ThemeSetting.of(context).bodyLarge.copyWith(
                                color: ThemeSetting.of(context).primaryText,
                              ),
                          color: ThemeSetting.of(context).primary,
                          // elevation: 0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                          elevation: 0,
                        ),
                      ),
                    ),
                  if (Platform.isAndroid)
                    SizedBox(
                      width: double.infinity,
                      child: CustomButtonWidget(
                        text: LocaleKeys.common_login_google.tr(),
                        icon: Image.asset(
                          "assets/icons/icon_google.png",
                          height: 24,
                        ),
                        onPressed: () async {
                          await SocialManager.getInstance().loginWithGoogle(callback: (value) {
                            if (value.isNotEmpty) {
                              // onLoginUpdate(context, value);
                              context.goNamed("UserInfoInputPage");
                            }
                          });
                        },
                        options: CustomButtonOptions(
                          height: 48,
                          textStyle: ThemeSetting.of(context).bodyLarge,
                          color: ThemeSetting.of(context).primary,
                          // elevation: 0,
                          borderSide: BorderSide(
                            color: ThemeSetting.of(context).secondary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                          elevation: 0,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      text: context.locale.languageCode == "ko" ? "회원가입과 함께 " : "With membership registration",
                      style: ThemeSetting.of(context).captionLarge.copyWith(
                            color: ThemeSetting.of(context).grey900,
                          ),
                      children: [
                        TextSpan(
                          text: context.locale.languageCode == "ko" ? " 및 " : "and",
                          style: ThemeSetting.of(context).captionLarge.copyWith(
                                color: ThemeSetting.of(context).grey900,
                              ),
                        ),
                        TextSpan(
                          text: context.locale.languageCode == "ko" ? "에 동의합니다." : "I agree to the",
                          style: ThemeSetting.of(context).captionLarge.copyWith(
                                color: ThemeSetting.of(context).grey900,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onLoginUpdate(BuildContext context, dynamic response, {bool isGuestLogin = false}) {
    if (response != null) {}
  }

  Widget _buildHeader() {
    return Container(
      height: 360,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, ThemeSetting.of(context).primaryBackground],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'For the better you',
              style: ThemeSetting.of(context).titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
