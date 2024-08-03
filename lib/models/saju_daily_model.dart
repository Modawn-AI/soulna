class SajuDailyInfo {
  final String dailyGanji;
  final Description description;
  final List<String> hashtag;
  final List<String> keyword;

  SajuDailyInfo({
    required this.dailyGanji,
    required this.description,
    required this.hashtag,
    required this.keyword,
  });

  factory SajuDailyInfo.fromJson(Map<String, dynamic> json) {
    return SajuDailyInfo(
      dailyGanji: json['daily_ganji'],
      description: Description.fromJson(json['description']),
      hashtag: List<String>.from(json['hashtag']),
      keyword: List<String>.from(json['keyword']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'daily_ganji': dailyGanji,
      'description': description.toJson(),
      'hashtag': hashtag,
      'keyword': keyword,
    };
  }
}

class Description {
  final List<TextDetail> text;

  Description({
    required this.text,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    var textList = json['text'] as List;
    List<TextDetail> textItems = textList.map((i) => TextDetail.fromJson(i)).toList();

    return Description(
      text: textItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text.map((e) => e.toJson()).toList(),
    };
  }
}

class TextDetail {
  final String title;
  final String paragraph;

  TextDetail({
    required this.title,
    required this.paragraph,
  });

  factory TextDetail.fromJson(Map<String, dynamic> json) {
    return TextDetail(
      title: json['title'],
      paragraph: json['paragraph'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'paragraph': paragraph,
    };
  }
}
