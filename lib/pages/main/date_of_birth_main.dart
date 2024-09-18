import 'dart:convert';

import 'package:Soulna/models/ten_twelve_model.dart';
import 'package:Soulna/models/user_model.dart';
import 'package:Soulna/pages/main/animation_screen.dart';
import 'package:Soulna/provider/ten_twelve_provider.dart';
import 'package:Soulna/utils/app_assets.dart';
import 'package:Soulna/utils/locale.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/button/button_widget.dart';
import 'package:Soulna/widgets/custom_checkbox_widget.dart';
import 'package:Soulna/widgets/custom_gender_button.dart';
import 'package:Soulna/widgets/custom_ios_date_picker.dart';
import 'package:Soulna/widgets/custom_textfield_widget.dart';
import 'package:Soulna/widgets/custom_time_range_widget.dart';
import 'package:Soulna/widgets/header/header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

// This file defines the DateOfBirthMain widget, which is used for entering the date of birth.
//Main screen -> set date of birth

class DateOfBirthMain extends StatefulWidget {
  const DateOfBirthMain({super.key});

  @override
  State<DateOfBirthMain> createState() => _DateOfBirthMainState();
}

class _DateOfBirthMainState extends State<DateOfBirthMain> {
  final PageController _pageController = PageController();
  bool isChecked = false;
  int _currentPage = 0;

  String selectedGender = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  TenTwelveModel? _tenTwelveModel;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    _nameController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page?.round() ?? 0;
    });
  }

  String generateUserJson() {
    String timeOfBirth = isChecked ? "Don't know" : "${_startTime?.format(context)} - ${_endTime?.format(context)}";

    Map<String, dynamic> userMap = {
      "name": _nameController.text,
      "birthdate": _birthdateController.text,
      "time_of_birth": timeOfBirth,
      "gender": selectedGender,
      "language": CustomLocale.getLanguageCodeToName(context.locale.languageCode),
    };

    return jsonEncode(userMap);
  }

  Future<void> _callApiAndNavigate() async {
    final apiCallFuture = _mockApiCall();

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimationScreen(
          apiFuture: apiCallFuture,
          useLottieAnimation: true,
          onApiComplete: (result) {
            if (result) {
              context.read<TenTwelveProvider>().setTenTwelveModel(_tenTwelveModel!);

              context.pushReplacementNamed(tenTwelveScreen, queryParameters: {
                'isCreateTenTwelve': 'true',
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('API call failed. Please try again.')),
              );
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  Future<bool> _mockApiCall() async {
    try {
      String userJson = generateUserJson();
      dynamic response = await ApiCalls().tenTwelveCall(info: userJson);
      if (response == null) {
        return false;
      }
      if (response['status'] == 'success') {
        _tenTwelveModel = TenTwelveModel.fromJson(response['tentwelve']['ten_twelve']);
        UserModel model = UserModel.fromJson(response['user_data']);
        GetIt.I.get<UserInfoData>().updateUserInfo(model);
        return true;
      }
      return false;
    } catch (e) {
      if (e is CustomException) {
        debugPrint('CustomException in _mockApiCall: ${e.message}');
      } else {
        debugPrint('Unexpected error in _mockApiCall: $e');
      }
      return false;
    }
  }

  void _handleDateSelected(DateTime date) {
    setState(() {
      _birthdateController.text = DateFormat('yyyy/MM/dd').format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ThemeSetting.of(context).secondaryBackground,
        appBar: HeaderWidget.headerBack(
            context: context,
            onTap: () async {
              FocusScope.of(context).unfocus();
              if (_currentPage == 0) {
                context.goNamed(mainScreen);
              } else {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildDateOfBirthPage(),
              _buildEditProfilePage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateOfBirthPage() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            children: [
              Text(
                LocaleKeys.please_set_your_date_of_birth.tr(),
                style: ThemeSetting.of(context).labelSmall.copyWith(
                      color: ThemeSetting.of(context).primaryText,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Image.asset(
                      AppAssets.logo,
                      height: 17,
                      width: 17,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      LocaleKeys.create_tentwelve_desc.tr(),
                      style: ThemeSetting.of(context).captionMedium,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              CustomDatePicker(
                onDateSelected: _handleDateSelected,
              ),
              const SizedBox(height: 40),
              Text(
                LocaleKeys.time_text.tr(),
                style: ThemeSetting.of(context).captionMedium.copyWith(
                      color: ThemeSetting.of(context).primary,
                    ),
              ),
              const SizedBox(height: 10),
              CustomRangeTimePicker(
                initialStartTime: const TimeOfDay(hour: 23, minute: 0),
                initialEndTime: const TimeOfDay(hour: 01, minute: 0),
                onStartTimeChanged: (startTime) {
                  _startTime = startTime;
                },
                onEndTimeChanged: (endTime) {
                  _endTime = endTime;
                },
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Row(
                  children: [
                    CustomCheckbox(
                      initialValue: isChecked,
                      showIcon: isChecked,
                      onChanged: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                    ),
                    Text(
                      LocaleKeys.dont_know_my_time.tr(),
                      style: ThemeSetting.of(context).captionMedium.copyWith(
                            color: ThemeSetting.of(context).primaryText,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: ButtonWidget.roundedButtonOrange(
              context: context,
              color: ThemeSetting.of(context).black2,
              text: LocaleKeys.next_text.tr(),
              onTap: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditProfilePage() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    width: 100,
                    height: 100,
                    AppAssets.user,
                    fit: BoxFit.cover,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      AppAssets.camera,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                LocaleKeys.name_text.tr(),
                style: ThemeSetting.of(context).captionLarge.copyWith(color: ThemeSetting.of(context).primary),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _nameController,
                hintText: LocaleKeys.enter_your_name.tr(),
              ),
              const SizedBox(height: 30),
              Text(
                LocaleKeys.gender_text.tr(),
                style: ThemeSetting.of(context).captionLarge.copyWith(color: ThemeSetting.of(context).primary),
              ),
              const SizedBox(height: 10),
              CustomGenderToggleButton(
                onGenderSelected: (gender) {
                  selectedGender = gender;
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: ButtonWidget.roundedButtonOrange(
            context: context,
            width: MediaQuery.of(context).size.width,
            color: ThemeSetting.of(context).black2,
            text: LocaleKeys.create_tentwelve_button.tr(),
            onTap: _callApiAndNavigate,
          ),
        ),
      ],
    );
  }
}
