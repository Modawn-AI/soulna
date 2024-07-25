import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:Soulna/utils/app_assets.dart';
import '../../utils/package_exporter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AnimationController logoAnimationController,
      containerAnimationController;
  bool isContainerVisible = false;

  @override
  void initState() {
    super.initState();
    logoAnimationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this)
      ..forward().whenComplete(() => _showContainer());
    containerAnimationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
  }

  void _showContainer() {
    setState(() => isContainerVisible = true);
    containerAnimationController.forward();
  }

  @override
  void dispose() {
    logoAnimationController.dispose();
    containerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).tertiary,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(flex: isContainerVisible ? 1 : 2),
            SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                      .animate(logoAnimationController),
              child: Image.asset(AppAssets.logo, height: 90),
            ),
            if (isContainerVisible) ...[
              const Spacer(),
              SlideTransition(
                position:
                    Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                        .animate(containerAnimationController),
                child: _buildSecondaryWidget(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryWidget() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: ThemeSetting.of(context).secondaryBackground,
        boxShadow: [const BoxShadow(blurRadius: 5, offset: Offset(0, 3))],
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.asset(
          AppAssets.hello,
          width: 50,
          height: 50,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.get_Started.tr(),
                      style: ThemeSetting.of(context).titleMedium.copyWith(
                            color: ThemeSetting.of(context).primaryText,
                          ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Image.asset(
                      AppAssets.soulnaText,
                      height: 20,
                      width: 96,
                      color: ThemeSetting.of(context).primaryText,
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  LocaleKeys.join_now_and_check_your_fortune.tr(),
                  style: ThemeSetting.of(context).bodySmall,
                )
              ],
            ),
            Image.asset(
              AppAssets.character,
              width: 68,
              height: 62,
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
                child: CustomButtonWidget(
              text: '',
              onPressed: () {},
              options: CustomButtonOptions(
                  height: 50,
                  borderRadius: BorderRadius.circular(12),
                  color: ThemeSetting.of(context).primaryText),
              textIcon: Image.asset(
                AppAssets.apple,
                height: 20,
                width: 20,
              ),
            )),
            const SizedBox(
              width: 9,
            ),
            Expanded(
                child: CustomButtonWidget(
              text: '',
              onPressed: () {},
              options: CustomButtonOptions(
                  height: 50,
                  borderRadius: BorderRadius.circular(12),
                  color: ThemeSetting.of(context).secondaryBackground,
                  borderSide:
                      BorderSide(color: ThemeSetting.of(context).common0)),
              textIcon: Image.asset(
                AppAssets.google,
                height: 20,
                width: 20,
              ),
            ))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButtonWidget(
          text: LocaleKeys.continue_with_Email.tr(),
          onPressed: () => context.pushNamed(loginScreen),
          options: CustomButtonOptions(
              textStyle: ThemeSetting.of(context)
                  .titleSmall
                  .copyWith(color: ThemeSetting.of(context).primaryText),
              height: 50,
              width: double.infinity,
              borderRadius: BorderRadius.circular(12),
              color: ThemeSetting.of(context).secondaryBackground,
              borderSide: BorderSide(color: ThemeSetting.of(context).common0)),
        ),
        const SizedBox(
          height: 15,
        ),
      ]),
    );
  }
}