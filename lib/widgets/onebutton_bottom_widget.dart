import 'package:Soulna/utils/package_exporter.dart';

class OneButtonBottomWidget extends StatelessWidget {
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const OneButtonBottomWidget({
    super.key,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            description,
            style: ThemeSetting.of(context).titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.0),
          SizedBox(
            width: double.infinity,
            child: CustomButtonWidget(
              text: buttonText,
              onPressed: () {
                onButtonPressed();
              },
              options: CustomButtonOptions(
                height: 48,
                textStyle: ThemeSetting.of(context).bodyLarge,
                color: ThemeSetting.of(context).secondaryBackground,
                // elevation: 0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(28.0),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
