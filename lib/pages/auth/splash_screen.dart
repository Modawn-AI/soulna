import 'dart:async';

import 'package:Soulna/utils/app_assets.dart';

import '../../utils/package_exporter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () =>context.goNamed(authScreen) ,);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: ThemeSetting.of(context).tertiary,
          body: Center(
      child: Image.asset(
    AppAssets.logo,
    height: 90,
    width: 90,
          )),
        );
  }
}