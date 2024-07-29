import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../utils/package_exporter.dart';
import '../../widgets/custom_tab_bar_widget.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});
  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isExpanded = false;
  List filterList = [];
  int selectedIndex = 0;

  List<String> inquiryTList = [
    LocaleKeys.all.tr(),
    LocaleKeys.awaiting_response.tr(),
    LocaleKeys.response_completed.tr(),
  ];

  List inquiryList = [
    {
      'title': LocaleKeys.service.tr(),
      'description': LocaleKeys.how_do_you_create_a_diary.tr(),
      'date': "January 1st, 1990 2:20 PM",
      'response': LocaleKeys.response_completed.tr(),
    },
    {
      'title': LocaleKeys.service.tr(),
      'description': LocaleKeys.how_do_you_create_a_diary.tr(),
      'date': "January 1st, 1990 2:20 PM",
      'response': LocaleKeys.awaiting_response.tr(),
    },
  ];

  List faqList = [
    {
      'question':
          LocaleKeys.can_i_get_a_fortune_telling_even_if_I_dont_know.tr(),
      'date': "January 1st, 1990 2:20 PM",
      'description': LocaleKeys.i_want_to_update_my_autobiography_des.tr(),
      'isExpand': false,
    },
    {
      'question': LocaleKeys.how_do_you_create_a_diary.tr(),
      'date': "January 1st, 1990 2:20 PM",
      'description': LocaleKeys.i_want_to_update_my_autobiography_des.tr(),
      'isExpand': false,
    },
    {
      'question': LocaleKeys.i_want_to_update_my_autobiography.tr(),
      'date': "January 1st, 1990 2:20 PM",
      'description': LocaleKeys.i_want_to_update_my_autobiography_des.tr(),
      'isExpand': false,
    },
  ];
  @override
  void initState() {
    super.initState();
    filterList = inquiryList;
    _tabController = TabController(length: 2, vsync: this);
  }

  void filterListByTitle(String title) {
    setState(() {
      if (title == LocaleKeys.all.tr()) {
        filterList = inquiryList;
      } else {
        filterList =
            inquiryList.where((item) => item['response'] == title).toList();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: HeaderWidget.headerWithTitle(
            context: context, title: LocaleKeys.customer_service.tr()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomTabBar(
          tabs: [
            Tab(text: LocaleKeys.FAQ.tr()),
            Tab(text: LocaleKeys.one_one_inquiry.tr()),
          ],
          tabViews: [
            faqWidget(context: context),
            inquiryWidget(context: context),
          ],
          tabController: _tabController,
        ),
      ),
    );
  }

  Widget faqWidget({
    required BuildContext context,
  }) {
    return ListView.builder(
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GestureDetector(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5.h),
                            Text(
                              LocaleKeys.service.tr(),
                              style: ThemeSetting.of(context)
                                  .captionMedium
                                  .copyWith(
                                    color: ThemeSetting.of(context).primary,
                                  ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              faqList[index]['question'],
                              style: ThemeSetting.of(context).bodyMedium,
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              faqList[index]['date'],
                              style: ThemeSetting.of(context)
                                  .captionMedium
                                  .copyWith(
                                    color:
                                        ThemeSetting.of(context).disabledText,
                                  ),
                            ),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              faqList[index]['isExpand'] =
                                  !faqList[index]['isExpand'];
                            });
                          },
                          icon: faqList[index]['isExpand']
                              ? const Icon(Icons.keyboard_arrow_up_sharp)
                              : const Icon(Icons.keyboard_arrow_down_sharp)),
                    ],
                  ),
                ),
              ),
              faqList[index]['isExpand']
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      color: ThemeSetting.of(context).tertiary,
                      child: Text(
                        faqList[index]['description'],
                        style: ThemeSetting.of(context).bodyMedium,
                      ),
                    )
                  : Divider(
                      color: ThemeSetting.of(context).common2,
                      thickness: 2,
                    ),
            ],
          );
        });
  }

  Widget inquiryWidget({
    required BuildContext context,
  }) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        CustomHorizontalListView(
          items: inquiryTList,
          selectedIndex: selectedIndex,
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
              filterListByTitle(inquiryTList[index]);
            });
          },
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView.builder(
                padding: EdgeInsets.only(bottom: 70.h),
                itemCount: filterList.length,
                itemBuilder: (context, index) {
                  return inquiryListTile(
                    i: index,
                    title: filterList[index]['title'],
                    description: filterList[index]['description'],
                    context: context,
                    responseKey: filterList[index]['response'],
                    date: 'January 1st, 1990 2:20 PM',
                    onTap: () {
                      context.pushNamed(privacyPolicyUpdateNoticeScreen);
                    },
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: ButtonWidget.roundedButtonOrange(
                  context: context,
                  width: double.infinity,
                  color: ThemeSetting.of(context).primaryText,
                  text: LocaleKeys.one_one_inquiry.tr(),
                  onTap: () {
                    context.pushNamed(oneToOneScreen);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  inquiryListTile(
          {required String title,
          required String description,
          required BuildContext context,
          required GestureTapCallback onTap,
          required String date,
          required int i,
          required String responseKey}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  ButtonWidget.squareButtonOrange(
                    context: context,
                    height: 30.h,
                    text: responseKey,
                    buttonBackgroundColor: filterList[i]['response'] ==
                            LocaleKeys.awaiting_response.tr()
                        ? ThemeSetting.of(context).primary
                        : ThemeSetting.of(context).common0,
                    textStyle: ThemeSetting.of(context).captionMedium.copyWith(
                          color: filterList[i]['response'] ==
                                  LocaleKeys.awaiting_response.tr()
                              ? ThemeSetting.of(context).secondaryBackground
                              : ThemeSetting.of(context).primaryText,
                        ),
                    onTap: () => filterList[i]['response'] ==
                            LocaleKeys.awaiting_response.tr()
                        ? context.pushNamed(responseCompletedScreen)
                        : context.pushNamed(awaitingResponseScreen),
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