import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_gender_button.dart';
import 'package:Soulna/widgets/custom_snackbar_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/custom_validator_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the ProfileSettingsScreen widget, which provides a screen for users to adjust their profile settings.
// Not linked to any screen
class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String gender = "";
  TextEditingController userNameController = TextEditingController(text: "Stella");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 80),
                  Align(alignment: Alignment.center, child: Image.asset(AppAssets.logo, width: 40.w, height: 40.h)),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      "${LocaleKeys.howdy.tr()}\n${LocaleKeys.hows_you_day_going.tr()}",
                      style: ThemeSetting.of(context).labelLarge,
                    ),
                  ),
                  const SizedBox(height: 65),
                  Text(
                    LocaleKeys.name.tr(),
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                          color: ThemeSetting.of(context).primary,
                        ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: userNameController,
                    hintText: LocaleKeys.enter_your_name.tr(),
                    validator: CustomValidatorWidget.validateName(value: LocaleKeys.enter_your_name.tr()),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    LocaleKeys.gender.tr(),
                    style: ThemeSetting.of(context).captionLarge.copyWith(color: ThemeSetting.of(context).primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomGenderToggleButton(
                    onGenderSelected: (p0) {
                      gender = p0;
                    },
                  ),
                  const SizedBox(height: 180),
                  ButtonWidget.roundedButtonOrange(
                      context: context,
                      color: ThemeSetting.of(context).black2,
                      text: LocaleKeys.save.tr(),
                      onTap: () {
                        if (_formKey.currentState!.validate() && gender != "") {
                        } else {
                          CustomSnackBarWidget.showSnackBar(
                            context: context,
                            message: LocaleKeys.enter_your_name.tr(),
                            color: ThemeSetting.of(context).primaryText,
                          );
                        }
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
