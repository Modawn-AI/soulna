import 'package:Soulna/utils/package_exporter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../widgets/custom_checkbox_widget.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/header/header_widget.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        appBar: HeaderWidget.headerWithTitle(
            context: context, title: 'Account Settings'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.email.tr(),
                style: ThemeSetting.of(context).captionMedium.copyWith(
                      color: ThemeSetting.of(context).primary,
                    ),
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: TextEditingController(),
                hintText: LocaleKeys.enter_your_email.tr(),
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
                controller: TextEditingController(),
                hintText: LocaleKeys.enter_your_password.tr(),
                onTap: () {
                  context.pushNamed('NewPasswordScreen');
                },
                readOnly: true,
                suffix: const Icon(Icons.keyboard_arrow_right),
              ),
              SizedBox(height: 20.h),
              Text(
                LocaleKeys.optional_terms_agreement.tr(),
                style: ThemeSetting.of(context).captionMedium.copyWith(
                      color: ThemeSetting.of(context).primary,
                    ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  context.pushNamed('DateOfBirthScreen');
                },
                child: Row(
                  children: [
                    CustomCheckbox(
                      initialValue: false,
                      onChanged: (value) {},
                    ),
                    Text(
                      LocaleKeys.select.tr(),
                      style: ThemeSetting.of(context).captionMedium.copyWith(
                            color: ThemeSetting.of(context).secondaryText,
                          ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      LocaleKeys.marketing_consent.tr(),
                      style: ThemeSetting.of(context).captionLarge.copyWith(
                            color: ThemeSetting.of(context).primaryText,
                          ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: ThemeSetting.of(context).primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}