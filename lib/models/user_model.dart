class UserModel {
  final String name;
  final String birthdate;
  final String timeOfBirth;
  final String gender;
  final String language;

  UserModel({
    required this.name,
    required this.birthdate,
    required this.timeOfBirth,
    required this.gender,
    required this.language,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      birthdate: json['birthdate'],
      timeOfBirth: json['time_of_birth'],
      gender: json['gender'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthdate': birthdate,
      'time_of_birth': timeOfBirth,
      'gender': gender,
      'language': language,
    };
  }
}
