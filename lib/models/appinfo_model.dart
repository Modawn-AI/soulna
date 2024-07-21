class AppInfoModel {
  final String url;
  final bool isUpdate;
  final bool serverStatus;
  final String serverVersion;
  final String description;
  final bool usingPromotion;
  final String serverEnvironment;

  AppInfoModel({
    required this.url,
    required this.isUpdate,
    required this.serverStatus,
    required this.serverVersion,
    required this.description,
    required this.usingPromotion,
    required this.serverEnvironment,
  });

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    return AppInfoModel(
      url: json['url'] as String,
      isUpdate: json['isUpdate'] as bool,
      serverStatus: json['serverStatus'] as bool,
      serverVersion: json['serverVersion'] as String,
      description: json['description'] as String,
      usingPromotion: json['usingPromotion'] as bool,
      serverEnvironment: json['serverEnvironment'] as String,
    );
  }
}

class AppInfoData {
  AppInfoModel? _appInfo;

  get appInfo => _appInfo;

  void updateAppInfo(AppInfoModel appInfo) {
    _appInfo = appInfo;
  }
}
