class UnreadNotificationModel {
  final int count;

  UnreadNotificationModel({
    required this.count,
  });

  factory UnreadNotificationModel.fromJson(Map<String, dynamic> json) {
    return UnreadNotificationModel(
      count: json['count'] as int,
    );
  }
}

class PayloadModel {
  // payload 내부의 id 관련 값들은 int가 아니라 전부 String! (현규님하고 합의된 사항)
  final String type;
  final String contentId;
  final String image;
  final String myImageId;

  PayloadModel({
    required this.type,
    required this.contentId,
    required this.image,
    required this.myImageId,
  });

  factory PayloadModel.fromJson(Map<String, dynamic> json) {
    return PayloadModel(
      type: json['type'] as String,
      contentId: json['contentId'] as String,
      image: json['image'] as String,
      myImageId: json['myImageId'] as String,
    );
  }
}

class NotificationModel {
  final int id;
  final String text;
  final PayloadModel? payload;
  final String? image;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.text,
    this.payload,
    this.image,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      text: json['text'] as String,
      payload: json['payload'] != null ? PayloadModel.fromJson(json['payload']) : null,
      image: json['image'] as String?,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
