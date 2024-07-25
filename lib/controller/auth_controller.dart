import 'package:get/get.dart';

import '../utils/package_exporter.dart';

class AuthController extends GetxController{

  final emailCon = TextEditingController().obs;
  final passwordCon = TextEditingController().obs;
  final newPasswordCon = TextEditingController().obs;
  final conPasswordCon = TextEditingController().obs;
  final nameCon = TextEditingController().obs;
  final emailVerificationCodeCon = TextEditingController().obs;
  final genderSelection =''.obs;

  final showVerificationCode = false.obs;

  @override
  void dispose() {
    emailCon.value.clear();
    passwordCon.value.clear();
    newPasswordCon.value.clear();
    conPasswordCon.value.clear();
    nameCon.value.clear();
    emailVerificationCodeCon.value.clear();
    genderSelection.value = '';
    super.dispose();
  }
}