import 'package:easy_localization/easy_localization.dart';
import '../../utils/package_exporter.dart';
import '../../widgets/header/header_widget.dart';

class NoticeScreen extends StatefulWidget {
  NoticeScreen({super.key});

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List<String> noticeList = [
    LocaleKeys.all.tr(),
    LocaleKeys.notice.tr(),
    LocaleKeys.update.tr(),
    LocaleKeys.information.tr(),
    LocaleKeys.Other.tr(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithTitle(
        context: context,
        title: LocaleKeys.notice.tr(),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.w),
            child: SizedBox(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: noticeList.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.0),
                      margin: EdgeInsets.all(4.r),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ThemeSetting.of(context).primaryText
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(
                          color: isSelected
                              ? ThemeSetting.of(context).primaryText
                              : ThemeSetting.of(context).common0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0.0),
                        child: Text(
                          noticeList[index],
                          style: TextStyle(
                            color: isSelected ?ThemeSetting.of(context).secondaryBackground: ThemeSetting.of(context).primaryText,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10.h),

          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return listTile(
                  title: LocaleKeys.notice.tr(),
                  description: LocaleKeys.privacy_policy_update_notice.tr(), context: context,
                  date: 'January 1st, 1990 2:20 PM',
                  onTap: () {
                    context.pushNamed(privacyPolicyUpdateNoticeScreen);
                  },
                );
              },
            ),
          ),
      // if(selectedIndex == 1)
      //      Expanded(
      //       child: Center(child: Text(LocaleKeys.notice.tr())),
      //     ),
      // if(selectedIndex == 2)
      //      Expanded(
      //       child: Expanded(
      //         child: Center(child: Text(LocaleKeys.update.tr())),
      //       ),
      //     ),
      // if(selectedIndex == 3)
      //      Expanded(
      //       child: Center(child: Text(LocaleKeys.information.tr())),
      //     ),
      // if(selectedIndex == 4)
      //      Expanded(
      //       child:  Center(child: Text(LocaleKeys.Other.tr())),
      //     ),
        ],
      ),
    );
  }


  listTile({required String title, required String description,
  required BuildContext context,
    required GestureTapCallback onTap,
    required String date,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Padding(
  padding:  EdgeInsets.symmetric(horizontal: 16.w),
  child: GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        Text(
          title,
          style: ThemeSetting.of(context).captionMedium.copyWith(
            color: ThemeSetting.of(context).primary,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          description,
          style: ThemeSetting.of(context).bodyMedium,
        ),
        SizedBox(height: 5.h),
        Text(
          date,
          style: ThemeSetting.of(context).captionMedium.copyWith(
            color: ThemeSetting.of(context).disabledText,
          ),
        ),
        SizedBox(height: 5.h),
      ],
    ),
  ),
    ),
      Divider(
        color: ThemeSetting.of(context).common2,
        thickness: 2,
      ),
    ],
  );
}