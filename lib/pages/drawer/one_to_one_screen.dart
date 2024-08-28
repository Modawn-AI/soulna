import 'dart:io';
import 'package:Soulna/generated/locale_keys.g.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/nav.dart';
import 'package:Soulna/utils/theme_setting.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_snackbar_widget.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/custom_validator_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

// This file defines the OneToOneScreen widget, which provides a screen for one-to-one interactions.
// The user can make inquiries and upload images.

class OneToOneScreen extends StatefulWidget {
  const OneToOneScreen({super.key});

  @override
  State<OneToOneScreen> createState() => _OneToOneScreenState();
}

class _OneToOneScreenState extends State<OneToOneScreen> {
  TextEditingController inquiryController = TextEditingController();
  TextEditingController inquiryDescriptionController = TextEditingController();
  List<File> selectedImages = [];
  List<XFile> xfilePick = [];
  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final imageFile = await picker.pickImage(source: source);
    xfilePick.add(imageFile!);
    setState(
      () {
        if (xfilePick.isNotEmpty) {
          selectedImages.add(File(xfilePick.last.path));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
    setState(() {});
  }

  final _inquiryFormKey = GlobalKey<FormState>();
  List<String> inquiryTList = [
    LocaleKeys.all.tr(),
    LocaleKeys.awaiting_response.tr(),
    LocaleKeys.response_completed.tr(),
  ];
  String? _selectedItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: HeaderWidget.headerBack(context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _inquiryFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    LocaleKeys.inquire_about_any_questions.tr(),
                    style: ThemeSetting.of(context).labelSmall.copyWith(
                          color: ThemeSetting.of(context).primaryText,
                        ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    LocaleKeys.inquiry_category.tr(),
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                          color: ThemeSetting.of(context).primary,
                          fontSize: 14.sp,
                        ),
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownButton(
                    items: inquiryTList,
                    selectedItem: _selectedItem,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  Text(
                    LocaleKeys.inquiries.tr(),
                    style: ThemeSetting.of(context).captionMedium.copyWith(
                          color: ThemeSetting.of(context).primary,
                          fontSize: 14.sp,
                        ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: inquiryController,
                    hintText: LocaleKeys.enter_inquiry_name.tr(),
                    validator: CustomValidatorWidget.validateName(
                      value: LocaleKeys.enter_inquiry_name.tr(),
                    ),
                  ),
                  const SizedBox(height: 6),
                  CustomTextField(
                    maxLength: 80,
                    controller: inquiryDescriptionController,
                    hintText: LocaleKeys.enter_inquiry_des.tr(),
                    maxLines: 8,
                    inputAction: TextInputAction.done,
                    validator: CustomValidatorWidget.validateName(
                      value: LocaleKeys.enter_inquiry_des.tr(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (selectedImages.length < 5) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      alignment: Alignment.center,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          listTileCameraGalleryPicker(
                                            context: context,
                                            onTap: () {
                                              getImage(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                            title: LocaleKeys.camera.tr(),
                                            icon: Icons.camera_alt,
                                          ),
                                          listTileCameraGalleryPicker(
                                            context: context,
                                            onTap: () {
                                              getImage(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                            title: LocaleKeys.gallery.tr(),
                                            icon: Icons.photo,
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              CustomSnackBarWidget.showSnackBar(
                                context: context,
                                message: LocaleKeys.you_can_upload_up_to_5_images.tr(),
                                color: ThemeSetting.of(context).primaryText,
                              );
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: ThemeSetting.of(context).common0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAssets.camera,
                                  width: 24,
                                  height: 24,
                                  color: ThemeSetting.of(context).primary,
                                ),
                                Text(
                                  "${selectedImages.length}/5",
                                  style: ThemeSetting.of(context).captionMedium.copyWith(
                                        color: ThemeSetting.of(context).disabledText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        selectedImages.isNotEmpty
                            ? SizedBox(
                                height: 60,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: selectedImages.length,
                                    itemBuilder: (context, i) {
                                      return Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            margin: const EdgeInsets.only(right: 6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: FileImage(File(selectedImages[i].path)),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedImages.removeAt(i);
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(bottom: 10),
                                              height: 14,
                                              width: 14,
                                              decoration: BoxDecoration(
                                                color: ThemeSetting.of(context).black2,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                color: ThemeSetting.of(context).white,
                                                size: 8,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ButtonWidget.roundedButtonOrange(
                    context: context,
                    width: double.infinity,
                    color: ThemeSetting.of(context).black2,
                    text: LocaleKeys.one_one_inquiry.tr(),
                    onTap: () {
                      if (_inquiryFormKey.currentState!.validate() && _selectedItem != null) {
                        context.pop();
                      } else {
                        CustomSnackBarWidget.showSnackBar(
                          context: context,
                          message: LocaleKeys.please_enter_inquiry_select_category.tr(),
                          color: ThemeSetting.of(context).primaryText,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  listTileCameraGalleryPicker({
    required BuildContext context,
    GestureTapCallback? onTap,
    required String title,
    required IconData icon,
  }) {
    return ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: ThemeSetting.of(context).bodyMedium,
        ),
        trailing: Icon(
          icon,
          color: ThemeSetting.of(context).primary,
        ));
  }
}

class CustomDropdownButton extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onChanged;

  const CustomDropdownButton({
    required this.items,
    required this.onChanged,
    this.selectedItem,
    super.key,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ThemeSetting.of(context).common0,
        ),
      ),
      child: DropdownButton<String>(
        value: _selectedItem,
        isExpanded: true,
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                item,
                style: ThemeSetting.of(context).bodyMedium,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
          widget.onChanged(newValue);
        },
        underline: Container(),
        hint: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            LocaleKeys.select_inquiry_category.tr(),
            style: ThemeSetting.of(context).bodyMedium,
          ),
        ),
        icon: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: const Icon(Icons.keyboard_arrow_down),
        ),
      ),
    );
  }
}
