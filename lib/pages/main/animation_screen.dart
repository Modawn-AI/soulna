import 'dart:async';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/sharedPref_string.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../utils/shared_preference.dart';

class AnimationScreen extends StatefulWidget {
  final String route;
  const AnimationScreen({super.key, required this.route});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double percent = 0.25;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) async {
        // setState(() {
        percent += 0.25;
        if (percent >= 1) {
        String? ani = await  SharedPreferencesManager.getString(key: SharedprefString.animationScreen);
          Timer(
            const Duration(milliseconds: 800),
            () => context.pushReplacementNamed(
                "${ani.toString()}"),
          );
          setState(() {});
          timer.cancel();
        }
        //});
      },
    );
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: -1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).black1,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              // padding: const EdgeInsets.only(left: 105,right: 60),
              child: LinearPercentIndicator(
                padding: EdgeInsets.zero,
                width: 200,
                lineHeight: 6,
                animation: true,
                percent: percent,
                barRadius: const Radius.circular(100),
              ),
            )
          ],
        ),
      ),
    );
  }
}