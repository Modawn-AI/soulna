class SajuDailyInfo {
  final String dailyGanji;
  final SajuDescription sajuDescription;
  final List<String> hashtag;
  final List<Keyword> keyword;

  SajuDailyInfo({
    required this.dailyGanji,
    required this.sajuDescription,
    required this.hashtag,
    required this.keyword,
  });

  factory SajuDailyInfo.fromJson(Map<String, dynamic> json) {
    return SajuDailyInfo(
      dailyGanji: json['daily_ganji'],
      sajuDescription: SajuDescription.fromJson(json['description']),
      hashtag: List<String>.from(json['hashtag']),
      keyword: List<Keyword>.from(json['keyword'].map((k) => Keyword.fromJson(k))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'daily_ganji': dailyGanji,
      'description': sajuDescription.toJson(),
      'hashtag': hashtag,
      'keyword': keyword.map((k) => k.toJson()).toList(),
    };
  }
}

class SajuDescription {
  final String title;
  final List<SajuTextDetail> sajuTextList;

  SajuDescription({
    required this.title,
    required this.sajuTextList,
  });

  factory SajuDescription.fromJson(Map<String, dynamic> json) {
    var textList = json['text'] as List;
    List<SajuTextDetail> textItems = textList.map((i) => SajuTextDetail.fromJson(i)).toList();

    return SajuDescription(
      title: json['title'],
      sajuTextList: textItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': sajuTextList.map((e) => e.toJson()).toList(),
    };
  }
}

class SajuTextDetail {
  final String title;
  final String paragraph;

  SajuTextDetail({
    required this.title,
    required this.paragraph,
  });

  factory SajuTextDetail.fromJson(Map<String, dynamic> json) {
    return SajuTextDetail(
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

class Keyword {
  final String text;
  final String emoji;

  Keyword({
    required this.text,
    required this.emoji,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) {
    return Keyword(
      text: json['text'],
      emoji: json['emoji'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'emoji': emoji,
    };
  }
}

class SajuDailyService {
  SajuDailyInfo? _sajuDailyInfo;

  get sajuDailyInfo => _sajuDailyInfo;

  void setSajuDailyInfo(SajuDailyInfo info) {
    _sajuDailyInfo = info;
  }
}
