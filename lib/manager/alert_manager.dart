import 'package:bot_toast/bot_toast.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:group_button/group_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertManager {
  static final AlertManager _instance = AlertManager._internal();

  factory AlertManager() => _instance;

  AlertManager._internal();

  static AlertManager getInstance() {
    return _instance;
  }

  late AlertStyle alertStyle;

  void initialize(BuildContext context) {
    alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      titleStyle: ThemeSetting.of(context).titleLarge,
      titleTextAlign: TextAlign.center,
      descStyle: ThemeSetting.of(context).bodyMedium,
      descTextAlign: TextAlign.center,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: ThemeSetting.of(context).alternate,
      alertPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      descPadding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
      buttonAreaPadding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 20.0),
      titlePadding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
          color: Colors.black,
        ),
      ),
      alertAlignment: Alignment.center,
    );
  }

  Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  void alertOneButtonShow(
    BuildContext context,
    String title,
    String desc,
    String buttonText,
    Function() onPressed,
  ) {
    Alert(
      alertAnimation: fadeAlertAnimation,
      context: context,
      style: alertStyle,
      type: AlertType.none,
      title: title,
      closeFunction: onPressed,
      desc: desc,
      buttons: [
        DialogButton(
          width: 160,
          height: 48,
          radius: BorderRadius.circular(28.0),
          onPressed: () => {
            onPressed(),
            Alert(context: context).dismiss(),
          },
          color: ThemeSetting.of(context).primary,
          child: Text(
            buttonText,
            style: ThemeSetting.of(context).bodyMedium.copyWith(color: ThemeSetting.of(context).primaryText),
          ),
        ),
      ],
    ).show();
  }

  void alertTwoButtonShow(
    BuildContext context,
    String title,
    String desc,
    String oneButtonText,
    String twoButtonText,
    Function() onOnePressed,
    Function() onTwoPressed, {
    bool isExitButton = false,
  }) {
    Alert(
      alertAnimation: fadeAlertAnimation,
      context: context,
      style: alertStyle,
      type: AlertType.none,
      title: title,
      desc: desc,
      closeIcon: isExitButton ? const Icon(Icons.close, color: Colors.black) : null,
      buttons: [
        DialogButton(
          width: 120,
          height: 52,
          radius: BorderRadius.circular(28.0),
          onPressed: () => {
            onOnePressed(),
            Alert(context: context).dismiss(),
          },
          color: ThemeSetting.of(context).grey900,
          child: Text(
            oneButtonText,
            style: ThemeSetting.of(context).bodyMedium.copyWith(color: ThemeSetting.of(context).primaryText),
          ),
        ),
        DialogButton(
          width: 120,
          height: 52,
          radius: BorderRadius.circular(28.0),
          onPressed: () => {
            onTwoPressed(),
            Alert(context: context).dismiss(),
          },
          color: ThemeSetting.of(context).primary,
          child: Text(
            twoButtonText,
            style: ThemeSetting.of(context).bodyMedium.copyWith(color: ThemeSetting.of(context).primaryText),
          ),
        ),
      ],
    ).show();
  }

  void alertDailyShow(
    BuildContext context,
    String title,
    String buttonText,
    List<String> buttonList,
    Function(int index) onPressed,
  ) {
    final selectedIndexNotifier = ValueNotifier<int>(-1);

    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeSetting.of(context).alternate,
          title: Center(
            child: Text(
              title,
              style: ThemeSetting.of(context).headlineMedium,
            ),
          ),
          content: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8, // 화면 너비의 80%로 설정
                    child: GroupButton(
                      isRadio: true,
                      buttons: buttonList,
                      onSelected: (desc, index, isSelected) {
                        selectedIndexNotifier.value = index;
                      },
                      options: GroupButtonOptions(
                        spacing: 10,
                        direction: Axis.vertical,
                        selectedTextStyle: ThemeSetting.of(context).bodyMedium,
                        unselectedTextStyle: ThemeSetting.of(context).bodyMedium,
                        selectedColor: ThemeSetting.of(context).primary,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        alignment: Alignment.center, // 버튼 내용을 중앙 정렬
                        buttonWidth: MediaQuery.of(context).size.width * 0.7, // 버튼 너비를 화면의 70%로 설정
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Center(
              child: ValueListenableBuilder<int>(
                valueListenable: selectedIndexNotifier,
                builder: (context, selectedIndex, child) {
                  return SizedBox(
                    width: 200,
                    child: CustomButtonWidget(
                      text: "OK",
                      onPressed: selectedIndex >= 0
                          ? () {
                              onPressed(selectedIndex);
                              Navigator.of(context).pop();
                            }
                          : null,
                      options: CustomButtonOptions(
                        height: 48,
                        textStyle: ThemeSetting.of(context).bodyLarge,
                        disabledTextColor: ThemeSetting.of(context).primaryText.withOpacity(0.5),
                        color: ThemeSetting.of(context).primary,
                        disabledColor: ThemeSetting.of(context).primary.withOpacity(0.5),
                        borderSide: BorderSide(
                          color: ThemeSetting.of(context).primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(24.0),
                        elevation: 0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  CancelFunc toastMessage(BuildContext context, String message, String iconName, {int duration = 2000}) {
    return BotToast.showCustomNotification(
      duration: Duration(milliseconds: duration),
      animationDuration: const Duration(milliseconds: 500),
      animationReverseDuration: const Duration(milliseconds: 500),
      onlyOne: true,
      crossPage: true,
      align: Alignment.bottomCenter,
      toastBuilder: (cancel) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Card(
          color: ThemeSetting.of(context).grey900.withAlpha(90),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                getToastIconImage(iconName),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: ThemeSetting.of(context).bodySmall.copyWith(
                          color: ThemeSetting.of(context).primaryText,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getToastIconImage(String iconName) {
    switch (iconName) {
      case 'success':
        return Image.asset('assets/icons/icon_checkbox_active.png', width: 24, height: 24);
      case 'fail':
        return Image.asset('assets/icons/icon_circle_exclamation.png', width: 24, height: 24);
      // case 'warning':
      //   return Image.asset('assets/icons/icon_checkbox_active.png', width: 24, height: 24);
      default:
        return Image.asset('assets/icons/icon_checkbox_active.png', width: 24, height: 24);
    }
  }
}
