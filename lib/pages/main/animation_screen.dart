import 'dart:async';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// This file defines the AnimationScreen widget, which is used for displaying animations.

class AnimationScreen extends StatefulWidget {
  final Future<bool> apiFuture;
  final String screenName;
  const AnimationScreen({super.key, required this.apiFuture, required this.screenName});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  double percent = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: -1).animate(_controller);

    _startAnimation();
    _waitForApiResult();
  }

  void _startAnimation() {
    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) async {
        // setState(() {
        percent += 0.25;
        if (percent >= 1) {
          // String? ani = await SharedPreferencesManager.getString(
          //     key: SharedprefString.animationScreen);
          // Timer(
          //   const Duration(milliseconds: 800),
          //   () => context.pushReplacementNamed(widget.screenName),
          // );
          //setState(() {});
          timer.cancel();
        }
        //});
      },
    );

    // _timer = Timer.periodic(
    //   const Duration(milliseconds: 100),
    //   (timer) {
    //     if (mounted) {
    //       setState(() {
    //         percent += 0.05;
    //         if (percent >= 1) {
    //           percent = 1;
    //           timer.cancel(); // Stop the timer once percent reaches 1
    //         }
    //       });
    //     }
    //   },
    // );
  }

  void _waitForApiResult() async {
    bool result = await widget.apiFuture;
    if (result) {
      Navigator.of(context).pop(); // AnimationScreen을 닫습니다.
    } else {
      // API 호출 실패 처리
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('API call failed. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeSetting.of(context).black1,
    ));
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).black1,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value * 2 * 3.141592653589793,
                    child: child,
                  );
                },
                child: Image.asset(
                  AppAssets.logo,
                  height: 58,
                  width: 58,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                LocaleKeys.wait_a_moment.tr(),
                style: ThemeSetting.of(context).headlineLarge,
              ),
              const SizedBox(
                height: 53,
              ),
              Container(
                width: 200,
                alignment: Alignment.center,
                child: LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  width: 200,
                  lineHeight: 6,
                  animation: true,
                  percent: percent,
                  barRadius: const Radius.circular(100),
                ),
              ),
              Spacer(),
              Text(
                "${LocaleKeys.copyright.tr()}${DateTime.now().year}${LocaleKeys.soulna_all_rights_reserved.tr()}",
                style: ThemeSetting.of(context).headlineLarge.copyWith(color: ThemeSetting.of(context).secondaryText, fontSize: 12),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
