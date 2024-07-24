import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: HeaderWidget.headerBack(context: context),
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
        children: [
          CustomTextField(
            controller: TextEditingController(),
            hintText: LocaleKeys.enter_your_email.tr(),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: TextEditingController(),
            hintText: LocaleKeys.enter_your_password.tr(),
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonWidget.squareButtonOrange(
              context: context, text: LocaleKeys.login.tr(), onTap: () {}),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.find_password.tr(),
                style: ThemeSetting.of(context).captionLarge,
              ),
              ButtonWidget.orangeBorderButton(
                  context: context,
                  text: LocaleKeys.sing_up.tr(),
                  onTap: () => context.pushNamed('SignUpScreen')),
            ],
          ),
        ],
      ),
    ));
  }
}