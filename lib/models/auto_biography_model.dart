class AutoBiographyModelModel {
  final String title;
  final String albumType;
  final List<String> uploadedImages;
  final List<ABContentItem> content;
  final List<String> hashtags;

  AutoBiographyModelModel({
    required this.title,
    required this.albumType,
    required this.uploadedImages,
    required this.content,
    required this.hashtags,
  });

  factory AutoBiographyModelModel.fromJson(Map<String, dynamic> json) {
    return AutoBiographyModelModel(
      title: json['title'],
      albumType: json['album_type'],
      uploadedImages: List<String>.from(json['uploaded_journal_img']),
      content: (json['content'] as List).map((item) => ABContentItem.fromJson(item)).toList(),
      hashtags: List<String>.from(json['hashtags']),
    );
  }
}

class ABContentItem {
  final String image;
  final String text;

  ABContentItem({
    required this.image,
    required this.text,
  });

  factory ABContentItem.fromJson(Map<String, dynamic> json) {
    return ABContentItem(
      image: json['image'],
      text: json['text'],
    );
  }
}

class AutoBiographyService {
  AutoBiographyModelModel? _autoBiographyModel;
  get autoBiographyModel => _autoBiographyModel;

  void updateAutoBiography(AutoBiographyModelModel autoBiographyModel) {
    _autoBiographyModel = autoBiographyModel;
  }
}
