import 'package:Soulna/utils/package_exporter.dart';

class RadioOption<T> {
  final T value;
  final String label;

  RadioOption({required this.value, required this.label});
}

class RadioGroup<T> extends StatefulWidget {
  final List<RadioOption<T>> options;
  final T? initialValue;
  final ValueChanged<T?> onChanged;

  const RadioGroup({
    super.key,
    required this.options,
    this.initialValue,
    required this.onChanged,
  });

  @override
  _RadioGroupState<T> createState() => _RadioGroupState<T>();
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        return RadioListTile<T>(
          contentPadding: EdgeInsets.zero,
          title: Text(
            option.label,
            style: ThemeSetting.of(context).bodyMedium,
          ),
          value: option.value,
          groupValue: _selectedValue,
          activeColor: Colors.black,
          onChanged: (T? value) {
            setState(() {
              _selectedValue = value;
            });
            widget.onChanged(value);
          },
        );
      }).toList(),
    );
  }
}
