import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/custom_tab_bar_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the TermsAndConditions widget, which displays the terms and conditions of the application.

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> with SingleTickerProviderStateMixin {
  List termsAndConditionList = [
    {
      'title': LocaleKeys.article_1.tr(),
      'description': LocaleKeys.article_1_des.tr(),
    },
    {
      'title': LocaleKeys.article_2.tr(),
      'description': LocaleKeys.article_2_des.tr(),
    },
  ];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithTitle(
        context: context,
        title: LocaleKeys.terms_and_conditions.tr(),
      ),
      body: SafeArea(
        child: CustomTabBar(
          tabs: [
            Tab(text: LocaleKeys.terms_and_conditions.tr()),
            Tab(text: LocaleKeys.privacy_policy.tr()),
          ],
          tabViews: [
            termsAndConditions(),
            Center(
              child: Text(
                LocaleKeys.privacy_policy.tr(),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
          tabController: _tabController,
        ),
      ),
    );
  }

  termsAndConditions() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      itemCount: termsAndConditionList.length,
      itemBuilder: (BuildContext context, i) {
        return termsAndConditionBox(
          context: context,
          title: termsAndConditionList[i]['title'],
          description: termsAndConditionList[i]['description'],
        );
      },
    );
  }

  termsAndConditionBox({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 10.h),
        Text(
          description,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 14.sp,
              ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
