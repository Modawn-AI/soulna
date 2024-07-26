import 'package:Soulna/utils/package_exporter.dart';

import 'package:get/get.dart';

class CustomSnackBarWidget {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message),
            backgroundColor: color ?? Theme.of(context).primaryColor,
        ),
    );
  }
}