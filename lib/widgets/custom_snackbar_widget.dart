import 'package:Soulna/utils/package_exporter.dart';

import 'package:get/get.dart';

class CustomSnackBarWidget {
  static void showSnackBar({
    required BuildContext context,
    required String text,
    Color? color,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    Get.snackbar(
      text,
      text,
      messageText: Text(
        text,
        style: ThemeSetting.of(context).captionMedium.copyWith(
              color: ThemeSetting.of(context).primaryText,
            ),
      ),
      backgroundColor: color ?? ThemeSetting.of(context).secondaryBackground,
      snackPosition: SnackPosition.BOTTOM,
      duration: duration,
      margin: EdgeInsets.all(10),
      borderRadius: 8,
    );
  }
}