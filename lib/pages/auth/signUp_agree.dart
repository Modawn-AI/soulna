import 'dart:developer';

import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_checkbox_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

//This file defines the SignUpAgree widget, which presents terms and conditions for users to agree to during the sign-up process.
//step 1
class SignupAgree extends StatefulWidget {
  const SignupAgree({
    super.key,
  });

  @override
  State<SignupAgree> createState() => _SignupAgreeState();
}

class _SignupAgreeState extends State<SignupAgree> {
  bool allSelected = false;
  List<bool> bottomCheck = [false, false, false];

  void _toggleAllSelected(bool? value) {
    setState(() {
      log('value ${allSelected}');
      for (int i = 0; i < bottomCheck.length; i++) {
        setState(() {
          log('old ${bottomCheck[i]}');
          bottomCheck[i] = allSelected;
          log('new ${bottomCheck[i]}');
        });
      }
    });
  }

  void _toggleBottomCheckbox(int index, bool? value) {
    setState(() {
      bottomCheck[index] = value ?? false;
      allSelected = bottomCheck.skip(1).every((v) => v);
      if (!bottomCheck[index]) allSelected = false;
    });
  }

  List<Map<String, dynamic>> bottomCheckboxes = [];

  @override
  Widget build(BuildContext context) {
    bottomCheckboxes = [
      {'text1': LocaleKeys.required.tr(), 'text2': "  ${LocaleKeys.marketing_consent.tr()}", 'textColor1': ThemeSetting.of(context).primary},
      {'text1': LocaleKeys.required.tr(), 'text2': "  ${LocaleKeys.collect_and_use_personal_information.tr()}", 'textColor1': ThemeSetting.of(context).primary},
      {'text1': LocaleKeys.select.tr(), 'text2': "  ${LocaleKeys.marketing_consent.tr()}", 'textColor1': ThemeSetting.of(context).grayLight},
    ];
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithCustomAction(
        context: context,
        percent: 0.25,
        pageIndex: '1',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          children: [
            Text(
              LocaleKeys.hello.tr(),
              style: ThemeSetting.of(context).labelSmall,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                LocaleKeys.please_agree_to_the_terms.tr(),
                style: ThemeSetting.of(context).labelSmall,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 10,
                  child: Row(
                    children: [
                      CustomCheckbox(
                        initialValue: bottomCheck.every((element) => element),
                        onChanged: () {
                          setState(() {
                            allSelected = !allSelected;
                            for (int i = 0; i < bottomCheck.length; i++) {
                              setState(() {
                                bottomCheck[i] = allSelected;
                              });
                            }
                          });

                          //_toggleAllSelected(v);
                        },
                      ),
                      Flexible(child: Text(LocaleKeys.agree_to_the_full_terms.tr(), style: ThemeSetting.of(context).headlineLarge.copyWith(color: ThemeSetting.of(context).primaryText))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              color: ThemeSetting.of(context).common1,
            ),
            const SizedBox(
              height: 10,
            ),
            ...List.generate(bottomCheckboxes.length, (index) {
              return checkBoxRow(
                context: context,
                onChanged: () {
                  setState(() {
                    bottomCheck[index] = !bottomCheck[index];
                  });
                },
                value: bottomCheck[index],
                text1: bottomCheckboxes[index]['text1'],
                text2: bottomCheckboxes[index]['text2'],
                textColor1: bottomCheckboxes[index]['textColor1'],
              );
            }),
            const SizedBox(
              height: 59,
            ),
            if (bottomCheck[0] && bottomCheck[1] == true) ButtonWidget.gradientButton(context: context, text: LocaleKeys.next.tr(), color1: ThemeSetting.of(context).black1, color2: ThemeSetting.of(context).black2, onTap: () => context.pushNamed(signUpEmail)),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  checkBoxRow({required BuildContext context, required String text1, required String text2, required bool value, Color? textColor1, void Function()? onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 10,
            child: Row(
              children: [
                CustomCheckbox(initialValue: value, onChanged: onChanged),
                Flexible(
                  child: RichText(
                    text: TextSpan(text: text1, style: ThemeSetting.of(context).captionLarge.copyWith(color: textColor1 ?? ThemeSetting.of(context).primary), children: [TextSpan(text: text2, style: ThemeSetting.of(context).captionLarge)]),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              child: Image.asset(
            AppAssets.next,
            width: 14,
            height: 14,
          ))
        ],
      ),
    );
  }
}
