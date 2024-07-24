import 'dart:developer';

import 'package:Soulna/pages/auth/signUp_additionalInfo.dart';
import 'package:Soulna/pages/auth/signUp_agree.dart';
import 'package:Soulna/pages/auth/signUp_email.dart';
import 'package:Soulna/pages/auth/signUp_password.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_checkbox_widget.dart';
import 'package:Soulna/widgets/custom_switchtile_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../utils/app_assets.dart';
import '../../utils/package_exporter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  PageController pageController = PageController(initialPage: 0);
  List pageList = [];
  @override
  Widget build(BuildContext context) {
    pageList = [
      SignupAgree(controller: pageController),
      SignupEmail(controller: pageController),
      SignUpPassword(controller: pageController),
      SignUpAdditionalInfo(controller: pageController)
    ];
    return PageView.builder(
      allowImplicitScrolling: false,
      pageSnapping: false,
      physics: NeverScrollableScrollPhysics(),
      itemCount: pageList.length,
      controller: pageController,
      onPageChanged: (value) {},
      itemBuilder: (context, index) {
        return pageList[index];
      },
    );
  }
}