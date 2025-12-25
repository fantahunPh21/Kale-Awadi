class Chapter {
  final String chapter; // Chapter title
  final List<Article> articles; // List of articles

  Chapter({required this.chapter, required this.articles});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    var articlesFromJson =
        json['articles'] as List? ?? []; // Handle possible null list
    List<Article> articleList =
        articlesFromJson.map((i) => Article.fromJson(i)).toList();

    return Chapter(
      chapter: json['chapter'] as String? ??
          'Unknown Chapter', // Provide a default value
      articles: articleList,
    );
  }
}

class Article {
  final String titleEn;
  final String titleAm;
  final dynamic contentEn; // Use dynamic to accommodate both String and Object
  final dynamic contentAm; // Use dynamic for the same reason

  Article({
    required this.titleEn,
    required this.titleAm,
    required this.contentEn,
    required this.contentAm,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      titleEn: json['titleEn'] as String? ??
          'Default Title En', // Provide a default value
      titleAm: json['titleAm'] as String? ??
          'Default Title Am', // Provide a default value
      contentEn: json['contentEn'] ?? 'Default Content En', // Handle null
      contentAm: json['contentAm'] ?? 'Default Content Am', // Handle null
    );
  }

  // Method to parse content based on its type
  String parseContent(dynamic content) {
    if (content is String) {
      return content; // It's a string, return as is
    } else if (content is Map) {
      // Handle object content, customize as needed
      return 'Content as an object'; // Example handling
    } else if (content is List) {
      // Handle list content
      return content.join('\n'); // Join list items with new lines
    }
    return 'Unknown Content'; // Fallback
  }

  // Method to get formatted content
  String getFormattedContentEn() {
    return parseContent(contentEn);
  }

  String getFormattedContentAm() {
    return parseContent(contentAm);
  }
}
