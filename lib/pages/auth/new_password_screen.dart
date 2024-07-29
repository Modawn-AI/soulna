import 'package:Soulna/controller/auth_controller.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/custom_validator_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/instance_manager.dart';

import '../../widgets/button/button_widget.dart';
import '../../widgets/custom_snackbar_widget.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/header/header_widget.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var authCon = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        appBar: HeaderWidget.headerWithTitle(context: context, title: ''),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            children: [
              Text(
                LocaleKeys.please_enter_the_new_password.tr(),
                style: ThemeSetting.of(context).labelSmall.copyWith(
                      color: ThemeSetting.of(context).primaryText,
                    ),
              ),
              SizedBox(height: 20.h),
              Text(
                LocaleKeys.password.tr(),
                style: ThemeSetting.of(context).captionMedium.copyWith(
                      color: ThemeSetting.of(context).primary,
                    ),
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: authCon.newPasswordCon.value,
                hintText: LocaleKeys.enter_your_new_password.tr(),
                isPassword: true,
                validator: CustomValidatorWidget.validatePassword(
                    value: authCon.newPasswordCon.value.text),
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: authCon.conPasswordCon.value,
                hintText: LocaleKeys.reEnter_your_new_password.tr(),
                isPassword: true,
                inputAction: TextInputAction.done,
                validator: CustomValidatorWidget.validateConfirmPassword(
                    value: authCon.conPasswordCon.value.text),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: ButtonWidget.gradientButton(
                    context: context,
                    text: LocaleKeys.change_password_and_log_in.tr(),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (authCon.newPasswordCon.value.text !=
                            authCon.conPasswordCon.value.text) {
                          CustomSnackBarWidget.showSnackBar(
                            context: context,
                            message: 'Both password does not match',

                          );
                          return;
                        }
                        context.goNamed(loginScreen);
                      }
                    },
                    color1: ThemeSetting.of(context).black1,
                    color2: ThemeSetting.of(context).black2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}