import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';

class CustomCheckbox extends StatefulWidget {
  final bool initialValue;
  final String? text1;
  final String? text2;
  final Color? color1;
  final Color? color2;
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox(
      {Key? key,
      this.initialValue = false,
      this.onChanged,
      this.text1,
      this.text2,
      this.color1,
      this.color2})
      : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckbox,
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: _isChecked
                  ? ThemeSetting.of(context).primary
                  : ThemeSetting.of(context).common1,
              border: Border.all(
                  color: _isChecked
                      ? ThemeSetting.of(context).primary
                      : ThemeSetting.of(context).common1,
                  width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: _isChecked
                    ? Image.asset(
                        AppAssets.check,
                        width: 12,
                        height: 12,
                        color: _isChecked
                            ? ThemeSetting.of(context).secondaryBackground
                            : ThemeSetting.of(context).grayLight,
                      )
                    : Container()),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}