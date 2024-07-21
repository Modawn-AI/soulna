import 'package:Soulna/utils/package_exporter.dart';

class TwoButtonBottomWidget extends StatelessWidget {
  final String description;
  final String firstButtonText;
  final String secondButtonText;
  final String? lastText;
  final Future<void> Function() onFirstButtonPressed;
  final Future<void> Function() onSecondButtonPressed;

  const TwoButtonBottomWidget(
      {super.key, required this.description, required this.firstButtonText, required this.secondButtonText, required this.onFirstButtonPressed, required this.onSecondButtonPressed, this.lastText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Icon(
              Icons.error_outline_sharp,
              color: ThemeSetting.of(context).primary,
              size: 56.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            style: ThemeSetting.of(context).headlineSmall,
            textAlign: TextAlign.center,
          ),
          // const SizedBox(height: 6),
          // Text(
          //   description,
          //   style: ThemeSetting.of(context).bodyMedium,
          //   textAlign: TextAlign.center,
          // ),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: CustomButtonWidget(
                  text: firstButtonText,
                  onPressed: () async {
                    await onFirstButtonPressed();
                  },
                  options: CustomButtonOptions(
                    height: 48.h,
                    textStyle: ThemeSetting.of(context).bodyLarge,
                    color: ThemeSetting.of(context).accent1,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(28.0),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                fit: FlexFit.tight,
                child: CustomButtonWidget(
                  text: secondButtonText,
                  onPressed: () async {
                    await onSecondButtonPressed();
                  },
                  options: CustomButtonOptions(
                    height: 48.h,
                    textStyle: ThemeSetting.of(context).bodyLarge,
                    color: ThemeSetting.of(context).primary,
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
          if (lastText != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                lastText!,
                style: ThemeSetting.of(context).bodySmall.copyWith(
                      color: ThemeSetting.of(context).grey900,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
