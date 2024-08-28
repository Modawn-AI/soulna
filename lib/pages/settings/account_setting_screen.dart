import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_checkbox_widget.dart';
import 'package:Soulna/widgets/custom_dialog_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the AccountSettingScreen widget, which provides a screen for users to manage their account settings.
//Drawer -> settings icon -> account settings
class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        appBar: HeaderWidget.headerWithTitle(context: context, title: LocaleKeys.account_settings.tr()),
        body: SafeArea(
          child: Padding(
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
                const SizedBox(height: 10),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: LocaleKeys.enter_your_email.tr(),
                ),
                const SizedBox(height: 40),
                Text(
                  LocaleKeys.password.tr(),
                  style: ThemeSetting.of(context).captionMedium.copyWith(
                        color: ThemeSetting.of(context).primary,
                      ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: LocaleKeys.enter_your_password.tr(),
                  onTap: () {
                    context.pushNamed(newPasswordScreen);
                  },
                  readOnly: true,
                  suffix: const Icon(Icons.keyboard_arrow_right),
                ),
                const SizedBox(height: 40),
                Text(
                  LocaleKeys.optional_terms_agreement.tr(),
                  style: ThemeSetting.of(context).captionMedium.copyWith(
                        color: ThemeSetting.of(context).primary,
                      ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(dateOfBirthScreen);
                  },
                  child: Row(
                    children: [
                      CustomCheckbox(
                        initialValue: isChecked,
                        onChanged: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                      ),
                      Text(
                        LocaleKeys.select.tr(),
                        style: ThemeSetting.of(context).captionMedium.copyWith(
                              color: ThemeSetting.of(context).secondaryText,
                            ),
                      ),
                      const SizedBox(width: 6),
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
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonWidget.borderButton(
                    context: context,
                    borderColor: ThemeSetting.of(context).common0,
                    textColor: ThemeSetting.of(context).captionMedium.color,
                    text: LocaleKeys.withdrawal_from_membership.tr(),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => CustomDialogWidget(
                                context: context,
                                confirmText: LocaleKeys.Sure.tr(),
                                content: LocaleKeys.withdraw_delete_your_account.tr(),
                                onConfirm: () {
                                  // context.pushNamedAndRemoveUntil('LoginScreen', (route) => false);
                                },
                                title: LocaleKeys.membership_withdrawal.tr(),
                              ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
