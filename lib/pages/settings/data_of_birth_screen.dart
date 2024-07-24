import 'package:Soulna/utils/package_exporter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/header/header_widget.dart';


class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen({super.key});

  @override
  State<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  DateTime selectedDate = DateTime(1990, 1, 1);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerWithTitle(context: context, title:''),
      body: Container(
        color: ThemeSetting.of(context).secondaryBackground,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              Text(
                LocaleKeys.please_set_your_date_of_birth.tr(),
                style: ThemeSetting.of(context)
                    .labelSmall
                    .copyWith(
                  color: ThemeSetting.of(context).primaryText,
                ),
              ),
              SizedBox(
                height: 100,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: ThemeSetting.of(context).headlineLarge.copyWith(
                        color: ThemeSetting.of(context).primary,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(

                    initialDateTime: selectedDate,
                    mode: CupertinoDatePickerMode.date,
                    maximumYear: DateTime.now().year,

                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() {
                        selectedDate = newDateTime;
                      });
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}