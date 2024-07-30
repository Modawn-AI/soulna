import 'package:Soulna/utils/package_exporter.dart';


class CustomTextField extends StatefulWidget {
  final bool readOnly;
  final String hintText;
  final String? labelText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int maxLines;
  final bool isPassword;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  // final ValueChanged<String>? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final Color? fillColor;
  final bool autoFocus;
  final Widget? suffix;
  final int? maxLength;

  CustomTextField(
      {this.hintText = '',
      this.readOnly = false,
      this.labelText,
      required this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.validator,
      // this.onSubmit,
      this.onChanged,
      this.capitalization = TextCapitalization.none,
      this.onTap,
      this.fillColor,
      this.isPassword = false,
      this.autoFocus = false,
      this.suffix,this.maxLength});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: ThemeSetting.of(context).bodySmall,
     autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: ThemeSetting.of(context).primary,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: widget.autoFocus,
      //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
      obscureText: widget.isPassword ? _obscureText : false,
     // inputFormatters:
      // widget.inputType == TextInputType.phone
      //     ? <TextInputFormatter>[
      //         FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
      //       ]
      //     : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,

        // filled: true,
        // fillColor: widget.fillColor ?? ThemeSetting.of(context).secondaryBackground,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ThemeSetting.of(context).common0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ThemeSetting.of(context).common0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ThemeSetting.of(context).primary)),
        hintStyle: ThemeSetting.of(context).bodySmall,

        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).hintColor.withOpacity(0.3)),
                onPressed: _toggle,
              )
            : widget.suffix,
      ),
      onTap: widget.onTap,
      validator: widget.validator,
      // onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
      //     : widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}