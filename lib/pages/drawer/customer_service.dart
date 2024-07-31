import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_divider_widget.dart';
import 'package:Soulna/widgets/custom_tab_bar_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the CustomerService widget, which provides a screen for customer service interactions.

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
      'question':
      LocaleKeys.can_i_get_a_fortune_telling_even_if_I_dont_know.tr(),
      'date': "January 1st, 1990 2:20 PM",
      'description': LocaleKeys.i_want_to_update_my_autobiography_des.tr(),
      'isExpand': false,
    },
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
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
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
    return ListView.separated(
      itemCount: faqList.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          initiallyExpanded: false,

          // expandedAlignment: Alignment.centerLeft,
          // expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                LocaleKeys.service.tr(),
                style: ThemeSetting.of(context).captionMedium.copyWith(
                      color: ThemeSetting.of(context).primary,
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                faqList[index]['question'],
                style: ThemeSetting.of(context).bodyMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                faqList[index]['date'],
                style: ThemeSetting.of(context).captionMedium.copyWith(
                      color: ThemeSetting.of(context).disabledText,
                    ),
              ),
            ],
          ),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              color: ThemeSetting.isLightTheme(context)
                  ? ThemeSetting.of(context).tertiary
                  : ThemeSetting.of(context).info,
              child: Text(
                faqList[index]['description'],
                style: ThemeSetting.of(context)
                    .bodyMedium
                    .copyWith(color: ThemeSetting.of(context).black2),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDividerWidget(
          thickness: 1,
          color: ThemeSetting.of(context).common0,
        );
      },
    );
  }

  Widget inquiryWidget({
    required BuildContext context,
  }) {
    return Column(
      children: [
        SizedBox(height: 15),
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
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
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
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: ButtonWidget.roundedButtonOrange(
            context: context,
            width: double.infinity,
            color: ThemeSetting.of(context).black2,
            text: LocaleKeys.one_one_inquiry.tr(),
            onTap: () {
              context.pushNamed(oneToOneScreen);
            },
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
            padding: EdgeInsets.symmetric(horizontal: 18),
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
                  ButtonWidget.squareButtonOrange(
                    context: context,
                    height: 30.h,
                    text: responseKey,
                    buttonBackgroundColor: filterList[i]['response'] ==
                            LocaleKeys.awaiting_response.tr()
                        ? ThemeSetting.of(context).common0
                        : ThemeSetting.of(context).primary,
                    textStyle: ThemeSetting.of(context).captionMedium.copyWith(
                          color: filterList[i]['response'] ==
                                  LocaleKeys.awaiting_response.tr()
                              ? ThemeSetting.of(context).secondaryBackground
                              : ThemeSetting.of(context).white,
                        ),
                    onTap: () => filterList[i]['response'] ==
                            LocaleKeys.awaiting_response.tr()
                        ? context.pushNamed(awaitingResponseScreen)
                        : context.pushNamed(responseCompletedScreen),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          CustomDividerWidget(
            thickness: 1,
            color: ThemeSetting.of(context).common0,
          ),
        ],
      );
}