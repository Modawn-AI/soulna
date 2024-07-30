import 'package:Soulna/utils/package_exporter.dart';

class CustomSwitchTile extends StatefulWidget {
  final bool initialValue;
  final String? text1;
  final String? text2;
  final Color? activeColor;
  final Color? inactiveColor;
  final ValueChanged<bool>? onChanged;
  // final void Function(bool)? onChanged

  const CustomSwitchTile({
    Key? key,
    this.initialValue = false,
    this.onChanged,
    this.text1,
    this.text2,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  _CustomSwitchTileState createState() => _CustomSwitchTileState();
}

class _CustomSwitchTileState extends State<CustomSwitchTile> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    _isSwitched = widget.initialValue;
  }

  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitched = value;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_isSwitched);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 40,
      color: Colors.transparent,
      child: SwitchListTile(
        hoverColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        title: Row(
          children: [
            if (widget.text1 != null)
              Text(widget.text1!, style: TextStyle(color: widget.activeColor)),
            if (widget.text2 != null)
              Text(widget.text2!,
                  style: TextStyle(color: widget.inactiveColor)),
          ],
        ),
        value:  widget.initialValue,
        onChanged: widget.onChanged ?? _toggleSwitch,
        thumbColor: WidgetStateProperty.all( widget.initialValue
            ? ThemeSetting.of(context).secondaryBackground
            : ThemeSetting.of(context).secondaryBackground),
        trackOutlineColor: WidgetStateProperty.all(
          widget.initialValue
              ? ThemeSetting.of(context).primary
              : ThemeSetting.of(context).common1,
        ),
        selectedTileColor:  widget.initialValue
            ? ThemeSetting.of(context).secondaryBackground
            : ThemeSetting.of(context).primary,
        activeColor:
            widget.activeColor ?? ThemeSetting.of(context).secondaryBackground,
        inactiveThumbColor: widget.inactiveColor ??
            ThemeSetting.of(context).secondaryBackground,
        activeTrackColor: widget.activeColor?.withOpacity(0.5) ??
            ThemeSetting.of(context).primary,
        inactiveTrackColor: widget.inactiveColor?.withOpacity(0.5) ??
            ThemeSetting.of(context).common2,
      ),
    );
  }
}