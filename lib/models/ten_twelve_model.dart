class TenTwelveModel {
  final String picture;
  final String title;
  final String color;
  final Description description;
  final List<String> hashtag;

  TenTwelveModel({
    required this.picture,
    required this.title,
    required this.color,
    required this.description,
    required this.hashtag,
  });

  factory TenTwelveModel.fromJson(Map<String, dynamic> json) {
    return TenTwelveModel(
      picture: json['picture'],
      title: json['title'],
      color: json['color'],
      description: Description.fromJson(json['description']),
      hashtag: List<String>.from(json['hashtag']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'picture': picture,
      'title': title,
      'color': color,
      'description': description.toJson(),
      'hashtag': hashtag,
    };
  }
}

class Description {
  final List<TenTwelveText> text;

  Description({
    required this.text,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    var textList = json['text'] as List;
    List<TenTwelveText> textItems = textList.map((i) => TenTwelveText.fromJson(i)).toList();

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

class TenTwelveText {
  final String title;
  final String paragraph;

  TenTwelveText({
    required this.title,
    required this.paragraph,
  });

  factory TenTwelveText.fromJson(Map<String, dynamic> json) {
    return TenTwelveText(
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
