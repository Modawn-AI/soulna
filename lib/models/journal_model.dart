class JournalModel {
  final String title;
  final List<String> uploadedImages;
  final List<ContentItem> content;
  final List<String> hashtags;

  JournalModel({
    required this.title,
    required this.uploadedImages,
    required this.content,
    required this.hashtags,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      title: json['title'],
      uploadedImages: List<String>.from(json['uploaded_journal_img']),
      content: (json['content'] as List).map((item) => ContentItem.fromJson(item)).toList(),
      hashtags: List<String>.from(json['hashtags']),
    );
  }
}

class ContentItem {
  final String image;
  final String text;

  ContentItem({
    required this.image,
    required this.text,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      image: json['image'],
      text: json['text'],
    );
  }
}

class JournalService {
  JournalModel? _journalModel;
  get journalModel => _journalModel;

  void updateJournal(JournalModel journalModel) {
    _journalModel = journalModel;
  }
}
