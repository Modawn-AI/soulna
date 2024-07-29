import '../utils/package_exporter.dart';

class CustomDividerWidget extends StatelessWidget {
  final double? thickness;
  final Color? color;
  const CustomDividerWidget({super.key,this.thickness,this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color:color?? ThemeSetting.of(context).common2,
      thickness:thickness?? 4,
    );
  }
}