import 'package:Soulna/utils/const.dart';
import 'package:Soulna/utils/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String provider;
  final VoiceCloneModel voiceClone;
  final PersonalInfoModel personalInfo;
  final NotificationModel notificationPreferences;
  final ChallengesModel challenges;
  final SubscriptionModel subscription;
  final String s3VoiceRecordingUrl;

  UserModel({
    required this.uid,
    required this.provider,
    required this.voiceClone,
    required this.personalInfo,
    required this.notificationPreferences,
    required this.challenges,
    required this.subscription,
    required this.s3VoiceRecordingUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      provider: json['provider'] as String? ?? '',
      voiceClone: json['voice_clone'] != null ? VoiceCloneModel.fromJson(json['voice_clone'] as Map<String, dynamic>) : VoiceCloneModel(consent: false, timestamp: DateTime.now()),
      personalInfo: json['personal_info'] != null ? PersonalInfoModel.fromJson(json['personal_info'] as Map<String, dynamic>) : PersonalInfoModel(name: '', age: 0, language: '', occupation: ''),
      notificationPreferences: json['notification_preferences'] != null
          ? NotificationModel.fromJson(json['notification_preferences'] as Map<String, dynamic>)
          : NotificationModel(consent: false, timeOfTheAlarm: '', timeZoneOffset: ''),
      challenges: json['challenges'] != null ? ChallengesModel.fromJson(json['challenges'] as Map<String, dynamic>) : ChallengesModel(mainChallenges: '', fears: '', goals: '', stress: ''),
      subscription: json['subscription'] != null
          ? SubscriptionModel.fromJson(json['subscription'] as Map<String, dynamic>)
          : SubscriptionModel(plan: '', startDate: DateTime.now(), endDate: DateTime.now(), isActive: false),
      s3VoiceRecordingUrl: json['s3_voice_recording_url'] as String? ?? '',
    );
  }
}

class VoiceCloneModel {
  final bool consent;
  final DateTime timestamp;

  VoiceCloneModel({
    required this.consent,
    required this.timestamp,
  });

  factory VoiceCloneModel.fromJson(Map<String, dynamic> json) {
    return VoiceCloneModel(
      consent: json['consent'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

class PersonalInfoModel {
  final String name;
  final int age;
  final String language;
  final String occupation;

  PersonalInfoModel({
    required this.name,
    required this.age,
    required this.language,
    required this.occupation,
  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      name: json['name'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      language: json['language'] as String? ?? '',
      occupation: json['occupation'] as String? ?? '',
    );
  }
}

class NotificationModel {
  final bool consent;
  final String timeOfTheAlarm;
  final String timeZoneOffset;

  NotificationModel({
    required this.consent,
    required this.timeOfTheAlarm,
    required this.timeZoneOffset,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      consent: json['consent'] as bool,
      timeOfTheAlarm: json['time_of_the_alarm'] as String,
      timeZoneOffset: json['time_zone_offset'] as String,
    );
  }
}

class ChallengesModel {
  final String mainChallenges;
  final String fears;
  final String goals;
  final String stress;

  ChallengesModel({
    required this.mainChallenges,
    required this.fears,
    required this.goals,
    required this.stress,
  });

  factory ChallengesModel.fromJson(Map<String, dynamic> json) {
    return ChallengesModel(
      mainChallenges: json['main_challenges'] as String? ?? '',
      fears: json['fears'] as String? ?? '',
      goals: json['goals'] as String? ?? '',
      stress: json['stress'] as String? ?? '',
    );
  }
}

class SubscriptionModel {
  final String plan;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  SubscriptionModel({
    required this.plan,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      plan: json['plan'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      isActive: json['is_active'] as bool,
    );
  }
}

class UserInfoData {
  OnboardingData onboardingData = OnboardingData();

  UserModel? _userInfo;
  get userInfo => _userInfo;

  String? _pushToken;
  get pushToken => _pushToken;

  void updateUserInfo(UserModel userInfo) {
    _userInfo = userInfo;
  }

  void updatePushToken(String pushToken) {
    _pushToken = pushToken;
  }

  Future<String?> getIdToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await user.getIdToken();
    }
    return null;
  }
}

class OnboardingData {
  PersonalInfoModel? _personalInfo;
  get personalInfo => _personalInfo;
  ChallengesModel? _challenges;
  get challenges => _challenges;
  SubscriptionModel? _subScription;
  get subScription => _subScription;

  void updatePersonalInfo(PersonalInfoModel personalInfo) {
    _personalInfo = personalInfo;
  }

  void updateChallenges(ChallengesModel challenges) {
    _challenges = challenges;
  }

  void updateSubScription(SubscriptionModel subScription) {
    _subScription = subScription;
  }

  String? _onboardingLetter;
  Future<String> get onboardingLetter async {
    _onboardingLetter ??= await SharedPreferencesManager.getString(key: kOnboardingDataSPKey);
    return _onboardingLetter!;
  }

  void updateOnboardingLetter(String letter) {
    _onboardingLetter = letter;
    SharedPreferencesManager.setString(key: kOnboardingDataSPKey, value: letter);
  }

  String? _onboardingVoiceUrl;
  Future<String> get onboardingVoiceUrl async {
    _onboardingVoiceUrl ??= await SharedPreferencesManager.getString(key: kOnboardingAudioSPKey);
    return _onboardingVoiceUrl!;
  }

  void updateOnboardingVoiceUrl(String url) {
    _onboardingVoiceUrl = url;
    SharedPreferencesManager.setString(key: kOnboardingAudioSPKey, value: url);
  }
}
