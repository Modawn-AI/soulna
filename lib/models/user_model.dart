import 'package:Soulna/models/ten_twelve_model.dart';

class UserModel {
  final String name;
  final String birthdate;
  final String timeOfBirth;
  final String gender;
  final String language;
  final TenTwelveModel tenTwelve;

  UserModel({
    required this.name,
    required this.birthdate,
    required this.timeOfBirth,
    required this.gender,
    required this.language,
    required this.tenTwelve,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      birthdate: json['birthdate'],
      timeOfBirth: json['time_of_birth'],
      gender: json['gender'],
      language: json['language'],
      tenTwelve: TenTwelveModel.fromJson(json['tentwelve']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthdate': birthdate,
      'time_of_birth': timeOfBirth,
      'gender': gender,
      'language': language,
      'tentwelve': tenTwelve.toJson(),
    };
  }
}

class UserInfoData {
  UserModel? _userModel;
  get userModel => _userModel;

  String _imageType = '';
  get imageType => _imageType;

  void updateUserInfo(UserModel userModel) {
    _userModel = userModel;
  }

  void updateImageType(String imageType) {
    _imageType = imageType;
  }
}
