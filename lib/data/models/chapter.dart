import 'article.dart';
import 'app_language.dart';

class Chapter {
  final String number;
  final String heading;
  final String? headingAm; // Amharic version
  final String? numberAm; // Amharic number
  final List<Article> articles;

  const Chapter({
    required this.number,
    required this.heading,
    this.headingAm,
    this.numberAm,
    required this.articles,
  });

  String displayTitle(AppLanguage lang) {
    if (lang == AppLanguage.am) {
      // If headingAm exists, use it directly (it already contains the full Amharic title)
      if (headingAm != null && headingAm!.isNotEmpty) {
        return headingAm!;
      }
      // Fallback: if headingAm is not available, try to use numberAm + heading
      // But this shouldn't happen if data is properly set up
      if (numberAm != null && numberAm!.isNotEmpty) {
        return '$numberAm $heading';
      }
    }
    return '$number $heading';
  }

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      number: json['number'] as String,
      heading: json['heading'] as String,
      headingAm: json['headingAm'] as String?,
      numberAm: json['numberAm'] as String?,
      articles: (json['articles'] as List<dynamic>)
          .map((article) => Article.fromJson(article as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'heading': heading,
      if (headingAm != null) 'headingAm': headingAm,
      if (numberAm != null) 'numberAm': numberAm,
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }
}

