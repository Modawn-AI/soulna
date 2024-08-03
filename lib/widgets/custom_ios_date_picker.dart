import 'package:Soulna/utils/package_exporter.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.onDateSelected,
  });

  final ValueChanged<DateTime> onDateSelected;

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  final List<int> dates = List.generate(31, (index) => index + 1);
  final List<int> years = List.generate(DateTime.now().year - 1920 + 1, (index) => 1920 + index);

  int selectedMonth = DateTime.now().month - 1;
  int selectedDate = DateTime.now().day - 1;
  int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ThemeSetting.of(context).secondaryBackground, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 150,
      child: Stack(
        children: [
          Center(child: Container(height: 50, color: ThemeSetting.isLightTheme(context) ? ThemeSetting.of(context).tertiary : ThemeSetting.of(context).common2)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPicker(context, months, selectedMonth, (index) {
                setState(() {
                  selectedMonth = index;
                  _notifyDateSelected();
                });
              }, isMonth: true),
              _buildPicker(context, dates, selectedDate, (index) {
                setState(() {
                  selectedDate = index;
                  _notifyDateSelected();
                });
              }),
              _buildPicker(context, years, selectedYear, (index) {
                setState(() {
                  selectedYear = years[index];
                  _notifyDateSelected();
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPicker(BuildContext context, List<dynamic> items, int selectedItem, ValueChanged<int> onSelectedItemChanged, {bool isMonth = false}) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: FixedExtentScrollController(initialItem: selectedItem),
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Center(
              child: Text(
                isMonth ? items[index] : items[index].toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: index == selectedItem
                      ? ThemeSetting.isLightTheme(context)
                      ? ThemeSetting.of(context).primary
                      : ThemeSetting.of(context).common0
                      : ThemeSetting.of(context).grayLight,
                ),
              ),
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }

  void _notifyDateSelected() {
    final selectedDateTime = DateTime(selectedYear, selectedMonth + 1, selectedDate + 1);
    widget.onDateSelected(selectedDateTime);
  }
}
