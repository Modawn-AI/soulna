import 'package:Soulna/utils/package_exporter.dart';

class SettingsWidget extends StatelessWidget {
  final String title;
  final String image;
  final BuildContext context;
  final GestureTapCallback onTap;
  final Widget? child;
  const SettingsWidget({super.key, required this.title, required this.image, required this.context, required this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              image,
              width: 26,
              height: 26,
              color: ThemeSetting.of(context).primaryText,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: ThemeSetting.of(context).bodyMedium.copyWith(
                    color: ThemeSetting.of(context).primaryText,
                    fontSize: 16,
                  ),
            ),
            const Spacer(),
            child ?? Container(),
          ],
        ),
      ),
    );
  }
}
