import 'dart:async';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// This file defines the AnimationScreen widget, which is used for displaying animations.

class AnimationScreen extends StatefulWidget {
  final Future<bool> apiFuture;
  final Function(bool) onApiComplete;
  final bool useLottieAnimation;

  const AnimationScreen({
    super.key,
    required this.apiFuture,
    required this.onApiComplete,
    required this.useLottieAnimation,
  });

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showWaitMessage = false;
  Timer? _waitMessageTimer;
  double _percent = 0.0;
  Timer? _percentTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: -1).animate(_controller);

    _waitForApiResult();
    _startWaitMessageTimer();
    _startPercentAnimation();
  }

  void _startWaitMessageTimer() {
    _waitMessageTimer = Timer(const Duration(seconds: 10), () {
      setState(() {
        _showWaitMessage = true;
      });
    });
  }

  void _startPercentAnimation() {
    const firstPhaseDuration = Duration(seconds: 10);
    const secondPhaseDuration = Duration(seconds: 20);
    const intervalDuration = Duration(milliseconds: 100);

    final firstPhaseIntervals = firstPhaseDuration.inMilliseconds ~/ intervalDuration.inMilliseconds;
    final secondPhaseIntervals = secondPhaseDuration.inMilliseconds ~/ intervalDuration.inMilliseconds;

    final firstPhaseIncrement = 0.9 / firstPhaseIntervals;
    final secondPhaseIncrement = 0.1 / secondPhaseIntervals;

    int currentInterval = 0;

    _percentTimer = Timer.periodic(intervalDuration, (timer) {
      currentInterval++;

      if (currentInterval <= firstPhaseIntervals) {
        // First phase: 0% to 90% in 10 seconds
        setState(() {
          _percent += firstPhaseIncrement;
        });
      } else if (currentInterval <= firstPhaseIntervals + secondPhaseIntervals) {
        // Second phase: 90% to 100% in 20 seconds
        setState(() {
          _percent += secondPhaseIncrement;
        });
      } else {
        timer.cancel();
      }

      if (_percent >= 1.0) {
        timer.cancel();
      }
    });
  }

  void _waitForApiResult() async {
    bool result = await widget.apiFuture;
    _waitMessageTimer?.cancel();
    _percentTimer?.cancel();
    setState(() {
      _percent = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 200)); // 최종 100% 상태를 잠시 보여줌
    widget.onApiComplete(result);
  }

  @override
  void dispose() {
    _controller.dispose();
    _waitMessageTimer?.cancel();
    _percentTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).black1,
      body: SafeArea(
        child: widget.useLottieAnimation ? _buildLottieAnimation() : _buildDefaultAnimation(),
      ),
    );
  }

  Widget _buildLottieAnimation() {
    return Stack(
      children: [
        Positioned.fill(
          child: Lottie.asset(
            'assets/lottie/saju_loading.json',
            frameRate: FrameRate.max,
            repeat: true,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value * 2 * 3.141592653589793,
                child: child,
              );
            },
            child: Image.asset(
              AppAssets.logo,
              height: 30,
              width: 30,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 80,
                  animation: false,
                  lineHeight: 4,
                  percent: _percent,
                  barRadius: const Radius.circular(10),
                  progressColor: ThemeSetting.of(context).primary,
                  backgroundColor: ThemeSetting.of(context).secondaryBackground,
                ),
              ),
              if (_showWaitMessage) ...[
                const SizedBox(height: 20),
                Text(
                  "LocaleKeys.please_wait_a_little_longer.tr()",
                  style: ThemeSetting.of(context).bodyMedium.copyWith(color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAnimation() {
    return Center(
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
          const SizedBox(height: 20),
          Text(
            LocaleKeys.wait_a_moment.tr(),
            style: ThemeSetting.of(context).headlineLarge,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 80,
              animation: false,
              lineHeight: 6,
              percent: _percent,
              barRadius: const Radius.circular(10),
              progressColor: ThemeSetting.of(context).primary,
              backgroundColor: ThemeSetting.of(context).secondaryBackground,
            ),
          ),
          if (_showWaitMessage) ...[
            const SizedBox(height: 20),
            Text(
              "LocaleKeys.please_wait_a_little_longer.tr()",
              style: ThemeSetting.of(context).bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}
