import 'package:Soulna/utils/package_exporter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:Soulna/widgets/button/button_widget.dart';

class CustomDialogWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String content;
  final String confirmText;
  final VoidCallback onConfirm;

  const CustomDialogWidget({
    required this.context,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      content: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: ThemeSetting.of(context).labelLarge.copyWith(
                    fontSize: 20.sp,
                    color: ThemeSetting.of(context).primaryText,
                  ),
            ),
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: ThemeSetting.of(context).bodyMedium.copyWith(
                      color: ThemeSetting.of(context).primaryText,
                    ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Expanded(
                  child: ButtonWidget.roundedButtonGrey(
                    context: context,
                    text: LocaleKeys.cancel_text.tr(),
                    onTap: () => context.pop(),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ButtonWidget.roundedButtonOrange(
                    context: context,
                    text: confirmText,
                    onTap: onConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
