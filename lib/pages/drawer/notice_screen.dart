import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the NoticeScreen widget, which displays notices to the user.
//All, Notice, Update, Information, Other

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
    LocaleKeys.other_text.tr(), // other
  ];

  List allList = [
    {"title": "Notice", "description": "Privacy policy update notice", "date": "January 1st, 1990 2:20 PM"},
    {"title": "Update", "description": "iOS Error Update Notification", "date": "January 1st, 1990 2:20 PM"},
    {"title": "Other", "description": "Inactive User Deactivation Notice", "date": "January 1st, 1990 2:20 PM"},
    {"title": "Information", "description": "Instructions for using Soluna", "date": "January 1st, 1990 2:20 PM"},
    {"title": "Notice", "description": "Privacy policy update notice", "date": "January 1st, 1990 2:20 PM"},
    {"title": "Update", "description": "iOS Error Update Notification", "date": "January 1st, 1990 2:20 PM"},
    {"title": "Other", "description": "Inactive User Deactivation Notice", "date": "January 1st, 1990 2:20 PM"},
    {"title": "Information", "description": "Instructions for using Soluna", "date": "January 1st, 1990 2:20 PM"},
  ];

  List filterList = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    filterList = allList; // Initialize filterList with allList
  }

  void filterListByTitle(String title) {
    setState(() {
      if (title == LocaleKeys.all.tr()) {
        filterList = allList;
      } else {
        filterList = allList.where((item) => item['title'] == title).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithTitle(
        context: context,
        title: LocaleKeys.notice.tr(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                        filterListByTitle(noticeList[index]);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0.0),
                        margin: EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? ThemeSetting.of(context).primaryText : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: isSelected ? ThemeSetting.of(context).primaryText : ThemeSetting.of(context).common0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0.0),
                          child: Text(
                            noticeList[index],
                            style: TextStyle(
                              color: isSelected ? ThemeSetting.of(context).secondaryBackground : ThemeSetting.of(context).primaryText,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: filterList.length,
                itemBuilder: (context, index) {
                  return listTile(
                    title: filterList[index]['title'],
                    description: filterList[index]['description'],
                    context: context,
                    date: filterList[index]['date'],
                    onTap: () {
                      context.pushNamed(privacyPolicyUpdateNoticeScreen);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  listTile({
    required String title,
    required String description,
    required BuildContext context,
    required GestureTapCallback onTap,
    required String date,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    title,
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                          color: ThemeSetting.of(context).primary,
                        ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: ThemeSetting.of(context).bodyMedium,
                  ),
                  SizedBox(height: 10),
                  Text(
                    date,
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                          color: ThemeSetting.of(context).disabledText,
                        ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          CustomDividerWidget(
            thickness: 2,
          ),
        ],
      );
}
