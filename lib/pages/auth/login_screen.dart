import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/custom_validator_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/state_manager.dart';
import 'package:get/instance_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var authCon = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget.headerBack(context: context),
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
          children: [
            Obx(
              () => CustomTextField(
                controller: authCon.emailCon.value,
                hintText: LocaleKeys.enter_your_email.tr(),
                validator: CustomValidatorWidget.validateEmail(
                    value: authCon.emailCon.value.text),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: authCon.passwordCon.value,
              hintText: LocaleKeys.enter_your_password.tr(),
              isPassword: true,
              validator: CustomValidatorWidget.validatePassword(
                  value: authCon.passwordCon.value.text),
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget.squareButtonOrange(
                context: context,
                text: LocaleKeys.login.tr(),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.pushNamed(mainScreen);
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    context.pushNamed(findPassword);
                  },
                  child: Text(
                    LocaleKeys.find_password.tr(),
                    style: ThemeSetting.of(context).captionLarge,
                  ),
                ),
                ButtonWidget.orangeBorderButton(
                  context: context,
                  text: LocaleKeys.sing_up.tr(),
                  onTap: () => context.pushNamed(signUpAgree),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}