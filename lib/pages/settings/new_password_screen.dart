import 'package:Soulna/utils/package_exporter.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/header/header_widget.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithTitle(context: context, title:''),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                 LocaleKeys.please_enter_the_new_password.tr(),
                  style: ThemeSetting.of(context)
                      .labelSmall
                      .copyWith(
                    color: ThemeSetting.of(context).primaryText,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  LocaleKeys.password.tr(),
                  style: ThemeSetting.of(context)
                      .captionMedium
                      .copyWith(
                    color: ThemeSetting.of(context).primary,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Enter your new password',
                  isPassword: true,
                ),

                SizedBox(height: 10.h),
                CustomTextField(
                  controller: TextEditingController(),
                  hintText: 'Re-enter your new password',
                  isPassword: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 50.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
            child: CustomButtonWidget(
              text: LocaleKeys.change.tr(),
              onPressed: (){},
              options: CustomButtonOptions(
                elevation: 0,
                height: 50.h,
                width: double.infinity,
                color: ThemeSetting.of(context).primaryText,
                borderRadius: BorderRadius.circular(50.r),
                     textStyle: ThemeSetting.of(context)
                    .headlineLarge
                    .copyWith(fontWeight: FontWeight.w500
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}