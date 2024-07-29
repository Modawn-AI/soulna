import 'package:Soulna/utils/package_exporter.dart';

class CustomSnackBarWidget {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: ThemeSetting.of(context)
              .headlineMedium

        ),
        backgroundColor: color ?? ThemeSetting.of(context).primaryText,
      ),
    );
  }
}