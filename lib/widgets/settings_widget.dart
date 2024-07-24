import '../utils/package_exporter.dart';

class SettingsWidget extends StatelessWidget {
  final String title;
  final String image;
  final BuildContext context;
  final GestureTapCallback onTap;
  final Widget? child;
  const SettingsWidget(
      {super.key,
      required this.title,
      required this.image,
      required this.context,
      required this.onTap,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(
              image,
              width: 26.h,
              height: 26.h,
            ),
            SizedBox(width: 10.w),
            Text(
              title,
              style: ThemeSetting.of(context).bodyMedium.copyWith(
                    color: ThemeSetting.of(context).primaryText,
                    fontSize: 16.sp,
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