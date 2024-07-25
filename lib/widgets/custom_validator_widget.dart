import 'package:get/get.dart';

class CustomValidatorWidget {
  static String? Function(String?)? validateEmail({String? value}) =>
          (value) {
        if (value == null || value.isEmpty) {
          return 'Email cannot be empty';
        } else if (!GetUtils.isEmail(value)) {
          return 'Enter a valid email address';
        }
        return null;
      };

  static String? Function(String?)? validatePassword({String? value}) =>
          (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      };

  static String? Function(String?)? validateName({String? value}) =>
          (value) {
        if (value == null || value.isEmpty) {
          return 'Name cannot be empty';
        } else if (value.length < 2) {
          return 'Name must be at least 2 characters long';
        }
        return null;
      };

  static String? Function(String?)? validateConfirmPassword({ String? value}) =>
          (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm Password cannot be empty';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      };

  static String? Function(String?)? validatePhoneNumber({String? value}) =>
          (value) {
        if (value == null || value.isEmpty) {
          return 'Phone number cannot be empty';
        } else if (!GetUtils.isPhoneNumber(value)) {
          return 'Enter a valid phone number';
        }
        return null;
      };

  static String? Function(String?)? validateVerificationCode({String? value}) =>
          (value) {
        if (value == null || value.isEmpty) {
          return 'Verification code cannot be empty';
        } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
          return 'Enter a valid 6-digit verification code';
        }
        return null;
      };

}