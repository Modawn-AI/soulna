import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme_setting.dart';

class CustomTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> tabViews;
  final TabController tabController;

  const CustomTabBar({
    required this.tabs,
    required this.tabViews,
    required this.tabController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: tabs,

          indicatorColor: ThemeSetting.of(context).primaryText,
          labelColor: ThemeSetting.of(context).primaryText,
          labelStyle: ThemeSetting.of(context).headlineLarge.copyWith(fontSize: 14.sp),
          unselectedLabelStyle: ThemeSetting.of(context).headlineLarge.copyWith(fontSize: 14.sp),
          unselectedLabelColor: ThemeSetting.of(context).disabledText,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3.0,
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: tabViews,
          ),
        ),
      ],
    );
  }
}
class CustomHorizontalListView extends StatefulWidget {
  final List<String> items;
  final Function(int) onItemSelected;
  final int selectedIndex;

  const CustomHorizontalListView({
    required this.items,
    required this.onItemSelected,
    required this.selectedIndex,
    super.key,
  });

  @override
  _CustomHorizontalListViewState createState() => _CustomHorizontalListViewState();
}

class _CustomHorizontalListViewState extends State<CustomHorizontalListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: SizedBox(
        height: 40.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            bool isSelected = widget.selectedIndex == index;
            return GestureDetector(
              onTap: () {
                widget.onItemSelected(index);
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
                    widget.items[index],
                    style: TextStyle(
                      color: isSelected
                          ? ThemeSetting.of(context).secondaryBackground
                          : ThemeSetting.of(context).primaryText,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}