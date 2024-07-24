import 'package:flutter/material.dart';

import '../../utils/theme_setting.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
    ));
  }
}