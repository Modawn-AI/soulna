import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/custom_dialog_widget.dart';
import 'package:Soulna/widgets/custom_snackbar_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdateDeleteDiaryBottomSheet {
  static updateDeleteDiaryBottomSheet({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: ThemeSetting.of(context).secondaryBackground,
              borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(15), left: Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                  context.pushReplacementNamed(selectPhotoScreen);
                },
                child: Text(
                  LocaleKeys.update_my_diary.tr(),
                  style: ThemeSetting.of(context).bodyMedium,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  context.pop();
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialogWidget(
                      context: context,
                      title: LocaleKeys.delete_my_diary.tr(),
                      content:
                          LocaleKeys.would_you_like_to_delete_the_diary.tr(),
                      confirmText: LocaleKeys.delete.tr(),
                      onConfirm: () {
                        context.pop();
                        CustomSnackBarWidget.showSnackBar(
                            context: context,
                            message: LocaleKeys.it_has_been_deleted.tr());
                      },
                    ),
                  );
                },
                child: Text(
                  LocaleKeys.delete_my_diary.tr(),
                  style: ThemeSetting.of(context).bodyMedium,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}