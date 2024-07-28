import '../utils/package_exporter.dart';

class CustomHashtagFunction{
 static TextSpan getStyledText({required BuildContext context,required String text, required List<String> keywords}) {
    final List<TextSpan> spans = [];
    final RegExp regex = RegExp(r"\b\w+\b");
    final matches = regex.allMatches(text);

    int lastMatchEnd = 0;
    for (final match in matches) {
      final word = match.group(0);
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: ThemeSetting.of(context).bodyMedium.copyWith(
            color: ThemeSetting.of(context).primaryText,
          ),
        ));
      }
      spans.add(TextSpan(
        text: word,
        style: ThemeSetting.of(context).bodyMedium.copyWith(
          color: keywords.contains(word)
              ? ThemeSetting.of(context).primary
              : ThemeSetting.of(context).primaryText,
        ),
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: ThemeSetting.of(context).bodyMedium.copyWith(
          color: ThemeSetting.of(context).primaryText,
        ),
      ));
    }

    return TextSpan(children: spans);
  }
}