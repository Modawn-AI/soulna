import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/custom_validator_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

//This file defines the SignUpEmail widget, which collects the user's email address during the sign-up process.
//step 2
class SignupEmail extends StatefulWidget {
  const SignupEmail({super.key});

  @override
  State<SignupEmail> createState() => _SignupEmailState();
}

class _SignupEmailState extends State<SignupEmail> {
  final authCon = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithCustomAction(
        context: context,
        pageIndex: '2',
        percent: 0.50,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            children: [
              Text(
                LocaleKeys.please_enter_your_email.tr(),
                style: ThemeSetting.of(context).labelSmall,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                LocaleKeys.email_text.tr(),
                style: ThemeSetting.of(context).captionLarge.copyWith(color: ThemeSetting.of(context).primary),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: authCon.emailCon.value,
                  hintText: LocaleKeys.please_enter_your_email.tr(),
                  validator: CustomValidatorWidget.validateEmail(value: authCon.emailCon.value.text),
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: ButtonWidget.roundedButtonOrange(
                        context: context,
                        height: 30,
                        text: LocaleKeys.confirm_text.tr(),
                        color: ThemeSetting.of(context).black2,
                        onTap: () {
                          authCon.showVerificationCode.value = true;
                          authCon.update();
                        }),
                  )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => authCon.showVerificationCode.value
                  ? CustomTextField(
                      controller: authCon.emailVerificationCodeCon.value,
                      hintText: LocaleKeys.enter_verification_code.tr(),
                      inputAction: TextInputAction.done,
                      validator: CustomValidatorWidget.validateVerificationCode(value: authCon.emailVerificationCodeCon.value.text),
                      suffix: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Text(
                          '04:38',
                          style: ThemeSetting.of(context).captionLarge.copyWith(color: ThemeSetting.of(context).primary),
                        ),
                      ),
                    )
                  : Container()),
              const SizedBox(
                height: 15,
              ),
              Text(
                LocaleKeys.enter_verification_code_des.tr(),
                style: ThemeSetting.of(context).captionMedium,
              ),
              const SizedBox(
                height: 85,
              ),
              ButtonWidget.gradientButton(
                  context: context,
                  text: LocaleKeys.next_text.tr(),
                  color1: ThemeSetting.of(context).black1,
                  color2: ThemeSetting.of(context).black2,
                  onTap: () {
                    authCon.showVerificationCode.value = true;
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      context.pushNamed(signUpPassword);
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
