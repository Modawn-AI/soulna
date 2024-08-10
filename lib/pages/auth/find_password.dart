import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/custom_validator_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

//This file defines the FindPassword widget, which provides a screen for users to recover their password.
class FindPassword extends StatefulWidget {
  const FindPassword({
    super.key,
  });

  @override
  State<FindPassword> createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {
  final _formKey = GlobalKey<FormState>();
  var authCon = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithTitle(context: context, title: LocaleKeys.find_password.tr()),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            children: [
              CustomTextField(
                  controller: authCon.emailCon.value,
                  hintText: LocaleKeys.enter_your_email_for_signed_up_for.tr(),
                  validator: CustomValidatorWidget.validateEmail(value: authCon.emailCon.value.text),
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: ButtonWidget.roundedButtonOrange(
                        context: context,
                        height: 30,
                        text: LocaleKeys.confirm.tr(),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        color: ThemeSetting.of(context).black2),
                  )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => authCon.showVerificationCode.value
                  ? CustomTextField(
                      controller: authCon.emailVerificationCodeCon.value,
                      hintText: LocaleKeys.enter_verification_code.tr(),
                      validator: CustomValidatorWidget.validateVerificationCode(value: authCon.emailVerificationCodeCon.value.text),
                      inputAction: TextInputAction.done,
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
                  text: LocaleKeys.authenticate_and_find_the_password.tr(),
                  color1: ThemeSetting.of(context).black1,
                  color2: ThemeSetting.of(context).black2,
                  onTap: () {
                    authCon.showVerificationCode.value = true;
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      context.pushNamed(newPasswordScreen);
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
