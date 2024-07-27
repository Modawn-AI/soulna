import '../utils/package_exporter.dart';

class CustomDatePicker extends StatefulWidget {


  const CustomDatePicker({
    Key? key,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {


  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<int> dates = List.generate(31, (index) => index + 1);
  final List<int> years =
  List.generate(DateTime.now().year - 1990 + 1, (index) => 1990 + index);

  int selectedMonth = DateTime.now().month - 1;
  int selectedDate = DateTime.now().day;
  int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 150, // Height to show only 3 items
      child: Stack(
        children: [
          Center(
              child: Container(
                  height: 50,
                  color: ThemeSetting.of(context).tertiary)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPicker(context, months, selectedMonth, (index) {
                setState(() {
                  selectedMonth = index;
                });
              }, isMonth: true),
              _buildPicker(context, dates, selectedDate, (index) {
                setState(() {
                  selectedDate = index;
                });
              }),
              _buildPicker(context, years, selectedYear, (index) {
                setState(() {
                  selectedYear = index;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPicker(BuildContext context, List<dynamic> items,
      int selectedItem, ValueChanged<int> onSelectedItemChanged,
      {bool isMonth = false}) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        controller: FixedExtentScrollController(initialItem: selectedItem),
        itemExtent: 50,

        //perspective: 0.005,
        //diameterRatio: 1.2,
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
                      ? ThemeSetting.of(context).primary
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
}