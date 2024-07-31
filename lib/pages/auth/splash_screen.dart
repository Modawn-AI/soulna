import 'dart:async';

import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => context.pushReplacementNamed(authScreen),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ThemeSetting.of(context).tertiary,
       ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.of(context).tertiary,
        body: Center(
            child: Image.asset(
          AppAssets.logo,
          height: 90,
          width: 90,
        )),
      ),
    );
  }
}