import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/custom_ios_date_picker.dart';

class ShowDatePickerBottomSheet{

  static showDatePicker({required BuildContext context,required void Function(DateTime) onDateSelected}){
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomDatePicker(onDateSelected: onDateSelected);
      },
    );
  }
}