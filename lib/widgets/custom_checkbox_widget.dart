import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/package_exporter.dart';

class CustomCheckbox extends StatefulWidget {
  final bool initialValue;
  final String? text1;
  final String? text2;
  final Color? color1;
  final Color? color2;
  final bool showIcon;
  final void Function()? onChanged;

  const CustomCheckbox(
      {Key? key,
      this.initialValue = false,
      this.onChanged,
      this.text1,
      this.text2,
      this.color1,
      this.color2,
      this.showIcon = true})
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
      widget.onChanged!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onChanged ?? _toggleCheckbox,
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: widget.initialValue
                  ? ThemeSetting.of(context).primary
                  : ThemeSetting.of(context).common1,
              border: Border.all(
                  color: widget.initialValue
                      ? ThemeSetting.of(context).primary
                      : ThemeSetting.of(context).common1,
                  width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: widget.showIcon == true
                ? Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      AppAssets.check,
                      width: 12,
                      height: 12,
                      color: widget.initialValue
                          ? ThemeSetting.of(context).secondaryBackground
                          : ThemeSetting.of(context).grayLight,
                    ))
                : SizedBox(),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}