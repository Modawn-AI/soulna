import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectPhotosBottomSheet {
  static selectPhotoBottomSheet(
      {required BuildContext context,
      required List<Map<String, dynamic>> selectedImages}) {
    return showModalBottomSheet(
      elevation: 0,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              color: ThemeSetting.of(context).info,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  LocaleKeys.please_check_the_selected_photo.tr(),
                  style: ThemeSetting.of(context).titleLarge.copyWith(
                      color: ThemeSetting.of(context).white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 60,
                //width: 60,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  // onReorder: (oldIndex, newIndex) {
                  //   setState(() {
                  //     if (newIndex > oldIndex) {
                  //       newIndex -= 1;
                  //     }
                  //     final item = selectedImages.removeAt(oldIndex);
                  //     selectedImages.insert(newIndex, item);
                  //     //_updateSelectedIndexes(context);
                  //   });
                  //   setState(() {});
                  // },
                  children: List.generate(
                    selectedImages.length,
                    (index) {
                      final image = selectedImages[index];
                      return Container(
                        height: 60,
                        width: 60,
                        key: ValueKey(image),
                        margin: const EdgeInsets.only(right: 5, left: 2),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeSetting.of(context)
                                    .white),
                            color: ThemeSetting.of(context).common4,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                image['path'],
                              ),
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ButtonWidget.gradientButton(
                  context: context,
                  text:
                      '${LocaleKeys.select_a_total_of.tr()}${selectedImages.length} ${LocaleKeys.photos.tr()}',
                  color1: ThemeSetting.of(context).black1,
                  color2: ThemeSetting.of(context).black2,
                  onTap: () {
                    context.pop();
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}