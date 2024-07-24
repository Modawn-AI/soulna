import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';


class FindPassword extends StatefulWidget {

  const FindPassword({super.key,});

  @override
  State<FindPassword> createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ThemeSetting.of(context).secondaryBackground,
          appBar: HeaderWidget.headerWithTitle(
              context: context,
             title: LocaleKeys.find_password.tr()
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            children: [

              CustomTextField(
                  controller: TextEditingController(),
                  hintText: LocaleKeys.enter_your_email_for_signed_up_for.tr(),
                  suffix: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: ButtonWidget.roundedButtonOrange(
                        context: context,
                        height: 30,
                        text: LocaleKeys.confirm.tr(),
                        color: ThemeSetting.of(context).primaryText),
                  )),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: TextEditingController(),
                hintText: LocaleKeys.enter_verification_code.tr(),
                suffix: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    '04:38',
                    style: ThemeSetting.of(context)
                        .captionLarge
                        .copyWith(color: ThemeSetting.of(context).primary),
                  ),
                ),
              ),
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
                  onTap: () {}),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}