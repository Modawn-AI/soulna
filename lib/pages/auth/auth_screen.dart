import 'package:Soulna/widgets/custom_gender_button.dart';
import 'package:easy_localization/easy_localization.dart';
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

  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.of(context).tertiary,
        body: SizedBox(
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
      ),
    );
  }

  Widget _buildSecondaryWidget() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: ThemeSetting.of(context).white,
        border: Border.all(color: ThemeSetting.of(context).white),
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
                            color: ThemeSetting.of(context).black2,
                          ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Image.asset(
                      AppAssets.soulnaText,
                      height: 20,
                      width: 96,
                      color: ThemeSetting.of(context).black2,
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  LocaleKeys.join_now_and_check_your_fortune.tr(),
                  style: ThemeSetting.of(context)
                      .bodySmall
                      .copyWith(color: ThemeSetting.of(context).black2),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: CustomButtonWidget(
                    text: 'text',
                    textIcon: Image.asset(
                      AppAssets.apple,
                      height: 16,
                      width: 16,
                      color: isSelected.first == true
                          ? ThemeSetting.of(context).white
                          : ThemeSetting.of(context).black2,
                    ),
                    onPressed: () {
                      setState(() {
                        isSelected = [true, false];
                      });
                    },
                    options: CustomButtonOptions(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: ThemeSetting.of(context).common0),
                        height: 56,
                        color: isSelected.first == true
                            ? ThemeSetting.of(context).black2
                            : ThemeSetting.of(context).white,
                        textStyle: ThemeSetting.of(context).headlineLarge))),
            const SizedBox(width: 8),
            Expanded(
                child: CustomButtonWidget(
                    text: 'text',
                    textIcon: Image.asset(
                      AppAssets.google,
                      height: 16,
                      width: 16,
                    ),
                    onPressed: () {
                      setState(() {
                        isSelected = [false, true];
                      });
                    },
                    options: CustomButtonOptions(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: ThemeSetting.of(context).common0),
                        height: 56,
                        color: isSelected.last == true
                            ? ThemeSetting.of(context).black2
                            : ThemeSetting.of(context).white,
                        textStyle: ThemeSetting.of(context)
                            .headlineLarge))), // Spacing between buttons
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
                  .copyWith(color: ThemeSetting.of(context).black2),
              height: 50,
              width: double.infinity,
              borderRadius: BorderRadius.circular(12),
              color: ThemeSetting.of(context).white,
              borderSide: BorderSide(color: ThemeSetting.of(context).common0)),
        ),
        const SizedBox(
          height: 15,
        ),
      ]),
    );
  }
}