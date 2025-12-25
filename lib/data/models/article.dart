import 'app_language.dart';

class Article {
  final String number;
  final String title;
  final String body;
  final String? bodyAm; // Amharic version
  final String? numberAm; // Amharic number
  final String? titleAm; // Amharic title

  const Article({
    required this.number,
    required this.title,
    required this.body,
    this.bodyAm,
    this.numberAm,
    this.titleAm,
  });

  String displayNumber(AppLanguage lang) {
    if (lang == AppLanguage.am && numberAm != null && numberAm!.isNotEmpty) {
      return numberAm!;
    }
    return number;
  }

  String displayTitle(AppLanguage lang) {
    if (lang == AppLanguage.am && titleAm != null && titleAm!.isNotEmpty) {
      return titleAm!;
    }
    return title;
  }

  String displayNumberAndTitle(AppLanguage lang) {
    final num = displayNumber(lang);
    final tit = displayTitle(lang);
    return '$num $tit'.trim();
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      number: json['number'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      bodyAm: json['bodyAm'] as String?,
      numberAm: json['numberAm'] as String?,
      titleAm: json['titleAm'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'body': body,
      if (bodyAm != null) 'bodyAm': bodyAm,
      if (numberAm != null) 'numberAm': numberAm,
      if (titleAm != null) 'titleAm': titleAm,
    };
  }
}

