import 'package:Soulna/utils/package_exporter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../utils/app_assets.dart';
import '../../widgets/header/header_widget.dart';

class PrivacyPolicyUpdateNoticeScreen extends StatelessWidget {
  const PrivacyPolicyUpdateNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        appBar: HeaderWidget.headerBack(context: context),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w , vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.privacy_policy_update_notice.tr(),
                    style: ThemeSetting.of(context).labelLarge.copyWith(
                        color: ThemeSetting.of(context).primaryText, fontSize: 22.sp,
                    )),
                SizedBox(height: 2.h),
                Text('January 1st, 1990 2:20 PM',
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                        color: ThemeSetting.of(context).disabledText, fontSize: 14.sp,
                    ),
                ),
                  SizedBox(height: 30.h),
                Container(
                  height: 200.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.backgroundImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(LocaleKeys.hello_this_is_soulna.tr(),
                    style: ThemeSetting.of(context).bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}