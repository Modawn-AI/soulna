import 'dart:io';

import 'package:Soulna/generated/locale_keys.g.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/nav.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/theme_setting.dart';
import '../../widgets/button/button_widget.dart';
import '../../widgets/custom_snackbar_widget.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/custom_validator_widget.dart';

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
  body: Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Form(
      key: _inquiryFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
           LocaleKeys.please_feel_free_to_inquire_about_any_questions_you_have.tr(),
              style: ThemeSetting.of(context).labelSmall.copyWith(
                color: ThemeSetting.of(context).primaryText,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              LocaleKeys.inquiry_category.tr(),
              style: ThemeSetting.of(context).captionMedium.copyWith(
                color: ThemeSetting.of(context).primary,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 10.h),
            CustomDropdownButton(
              items: inquiryTList,
              selectedItem: _selectedItem,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem = newValue;
                });
              },
            ),
            SizedBox(height: 20.h),
            Text(
              LocaleKeys.inquiries.tr(),
              style: ThemeSetting.of(context).captionMedium.copyWith(
                color: ThemeSetting.of(context).primary,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              controller: inquiryController,
              hintText: LocaleKeys.enter_inquiry_name.tr(),
              validator: CustomValidatorWidget.validateName(
                  value:  LocaleKeys.enter_inquiry_name.tr(),
            ),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              maxLength: 80,
              controller: inquiryDescriptionController,
              hintText: LocaleKeys.enter_inquiry_des.tr(),
              maxLines: 8,
              validator: CustomValidatorWidget.validateName(
                  value:  LocaleKeys.enter_inquiry_des.tr(),
            ),
            ),
            SizedBox(height: 10.h),

            SingleChildScrollView(
              scrollDirection:
              Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      if(selectedImages.length < 5){
                        showModalBottomSheet(
                    backgroundColor: ThemeSetting.of(context).secondaryBackground,
                      context: context, builder: (context) {
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
                             icon:   Icons.camera_alt,
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
                      height: 60.h,
                      width:  60.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(

                        border: Border.all( color: ThemeSetting.of(context).common0),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         Image.asset(
                           AppAssets.camera,
                            width: 24.w,
                            height: 24.h,
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
                  SizedBox(width: 6.w),
                  selectedImages.isNotEmpty
                      ?  SizedBox(
                        height: 60.h,
                        child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, i) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 60.h,
                                width: 60.w,
                                margin: EdgeInsets.only(right: 6.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                    image:
                                    FileImage(File(selectedImages[i].path)),
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
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  height: 14.h,
                                  width: 14.w,
                                  decoration: BoxDecoration(
                                    color: ThemeSetting.of(context).black2,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: ThemeSetting.of(context).secondaryBackground,
                                    size: 8.sp,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ):Container(),

                ],
              ),
            ),
            SizedBox(height: 100.h),
            ButtonWidget.roundedButtonOrange(
              context: context,
              width: double.infinity,
              color: ThemeSetting.of(context).primaryText,
              text: LocaleKeys.one_one_inquiry.tr(),
              onTap: () {
              if (_inquiryFormKey.currentState!.validate() && _selectedItem != null) {
                context.pop();
                }else{
                CustomSnackBarWidget.showSnackBar(
                  context: context,
                  message: LocaleKeys.please_enter_inquiry_or_select_category.tr(),
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
    );
  }
  listTileCameraGalleryPicker({
    required BuildContext context,
    GestureTapCallback? onTap,
    required String title,
    required IconData icon,
}){
    return ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: ThemeSetting.of(context).bodyMedium,
        ),
        trailing: Icon(
          icon,
          color: ThemeSetting.of(context).primary,
        )
    );
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
              child: Text(item,

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
        underline: Container( ),
        hint: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            LocaleKeys.select_inquiry_category.tr(),
            style: ThemeSetting.of(context).bodyMedium,
          ),
        ),
        icon: Padding(
          padding:  EdgeInsets.only(right: 8.w),
          child: const Icon(Icons.keyboard_arrow_down),
        ),
      ),
    );
  }
}