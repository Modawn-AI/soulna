import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';

class Subscription {
  static final authCon = Get.put(AuthController());
  static subscriptionWidget({required BuildContext context}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeSetting.of(context).secondaryBackground,
    ));

    return showModalBottomSheet(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      //isDismissible: false,
      backgroundColor: ThemeSetting.of(context).primaryText.withOpacity(0.5),
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))],
            color: ThemeSetting.of(context).tertiary,
          ),
          child: ListView(
            padding: const EdgeInsets.only(top: 30, right: 25, left: 25),
            children: [
              Image.asset(
                AppAssets.logo,
                height: 37,
                width: 37,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 31, right: 30, top: 30),
                child: Text(
                  LocaleKeys.enjoy_soulna_features.tr(),
                  textAlign: TextAlign.center,
                  style: ThemeSetting.of(context).labelLarge,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              rawWidget(text: LocaleKeys.check_your_fortune_today.tr(), context: context),
              const SizedBox(
                height: 10,
              ),
              rawWidget(text: LocaleKeys.check_today_diary.tr(), context: context),
              const SizedBox(
                height: 10,
              ),
              rawWidget(text: LocaleKeys.check_your_journal.tr(), context: context),
              const SizedBox(
                height: 31,
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 11),
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(border: Border.all(color: ThemeSetting.of(context).primaryText), color: ThemeSetting.of(context).primary, borderRadius: BorderRadius.circular(12)),
                    height: 80.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.yearly.tr(), // yearly
                            style: ThemeSetting.of(context).headlineLarge),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('\$39.99', style: ThemeSetting.of(context).headlineLarge),
                            Text(
                              '\$3.33/month',
                              style: ThemeSetting.of(context).captionLarge.copyWith(color: ThemeSetting.isLightTheme(context) ? ThemeSetting.of(context).secondaryBackground.withOpacity(0.5) : ThemeSetting.of(context).white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    height: 23.h,
                    width: 61.w,
                    margin: const EdgeInsets.only(left: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: ThemeSetting.of(context).primaryText, borderRadius: BorderRadius.circular(25)),
                    child: Text('Save 72%',
                        style: ThemeSetting.of(context).bodySmall.copyWith(
                              color: ThemeSetting.of(context).secondaryBackground,
                            )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(color: ThemeSetting.of(context).white, borderRadius: BorderRadius.circular(12)),
                height: 70.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.monthly.tr(), // monthly
                      style: ThemeSetting.of(context).headlineLarge.copyWith(color: ThemeSetting.of(context).black2),
                    ),
                    Text('\$11.99/month', style: ThemeSetting.of(context).headlineLarge.copyWith(color: ThemeSetting.of(context).black2)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ButtonWidget.gradientButtonWithImage(
                  context: context,
                  text: LocaleKeys.start.tr(), // start
                  onTap: () {
                    context.pop();
                    authCon.isPremium.value = true;
                    // _animationController = AnimationController(
                    //   duration: const Duration(milliseconds: 500),
                    //   vsync: this,
                    // );
                    // _slideAnimation = Tween<Offset>(
                    //   begin: const Offset(1, 0),
                    //   end: Offset.zero,
                    // ).animate(CurvedAnimation(
                    //   parent: _animationController,
                    //   curve: Curves.easeInOut,
                    // ));

                    // _animationController.forward();
                  }),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  LocaleKeys.restore_purchases.tr(), // restore_purchases
                  style: ThemeSetting.of(context).captionMedium,
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  LocaleKeys.purchases_des.tr(), // purchases_des
                  style: ThemeSetting.of(context).displaySmall.copyWith(color: ThemeSetting.of(context).primaryText.withOpacity(0.7)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40)
            ],
          ),
        );
      },
    );
  }

  static rawWidget({required String text, required BuildContext context}) {
    return Row(
      children: [
        Image.asset(
          AppAssets.check,
          width: 14,
          height: 14,
          color: ThemeSetting.of(context).primaryText,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: ThemeSetting.of(context).bodyMedium,
        ),
      ],
    );
  }
}
