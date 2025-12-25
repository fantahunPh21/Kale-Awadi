import 'package:flutter/material.dart';
import 'chapter.dart'; // Your Chapter model

class ChapterDetailPage extends StatelessWidget {
  final Chapter chapter;
  final bool isDarkTheme;
  final bool isEnglish;
  final Function(String) onBookmark;
  final double fontSize; // Font size for text
  final String fontFamily; // Font family for text

  const ChapterDetailPage({
    super.key,
    required this.chapter,
    required this.isDarkTheme,
    required this.isEnglish,
    required this.onBookmark,
    required this.fontSize,
    required this.fontFamily,
  });

  // Method to parse and format content based on its type
  String formatContent(dynamic content) {
    if (content is String) {
      return content; // It's a string, return as is
    } else if (content is Map) {
      return content.toString(); // Convert map to string (customize as needed)
    } else if (content is List) {
      return content.join('\n'); // Join list items with new lines
    }
    return 'Unknown Content'; // Fallback
  }

  // Method to navigate to the article detail page
  void _navigateToArticleDetail(BuildContext context, int index) {
    final article = chapter.articles[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailPage(
          titleEn: article.titleEn,
          titleAm: article.titleAm,
          contentEn: formatContent(article.contentEn),
          contentAm: formatContent(article.contentAm),
          isDarkTheme: isDarkTheme,
          fontSize: fontSize,
          fontFamily: fontFamily,
          isEnglish: isEnglish, // Pass the current language selection
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkTheme ? Colors.grey[850] : Colors.grey[200];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          isEnglish
              ? chapter.chapter
              : " ${chapter.chapter}", // Display chapter title
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
          ),
        ),
        backgroundColor: isDarkTheme ? Colors.black87 : Colors.grey,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              onBookmark(isEnglish
                  ? chapter.articles[0].titleEn
                  : chapter.articles[0].titleAm);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Bookmarked: ${isEnglish ? chapter.articles[0].titleEn : chapter.articles[0].titleAm}'),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: backgroundColor,
        child: ListView.builder(
          itemCount: chapter.articles.length,
          itemBuilder: (context, index) {
            final article = chapter.articles[index];
            return Card(
              color: isDarkTheme ? Colors.grey[900] : Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              child: ListTile(
                title: Text(
                  isEnglish ? article.titleEn : article.titleAm,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: isDarkTheme ? Colors.white : Colors.black,
                    fontFamily: fontFamily,
                  ),
                ),
                onTap: () => _navigateToArticleDetail(
                    context, index), // Navigate on title tap
              ),
            );
          },
        ),
      ),
    );
  }
}

// Article Detail Page to show the content of the selected article
class ArticleDetailPage extends StatelessWidget {
  final String titleEn;
  final String titleAm;
  final String contentEn;
  final String contentAm;
  final bool isDarkTheme;
  final double fontSize;
  final String fontFamily;
  final bool isEnglish; // Added language parameter

  const ArticleDetailPage({
    super.key,
    required this.titleEn,
    required this.titleAm,
    required this.contentEn,
    required this.contentAm,
    required this.isDarkTheme,
    required this.fontSize,
    required this.fontFamily,
    required this.isEnglish, // Added language parameter
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkTheme ? Colors.grey[850] : Colors.grey[200];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          isEnglish
              ? titleEn
              : titleAm, // Show title based on selected language
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
          ),
        ),
        backgroundColor: isDarkTheme ? Colors.black87 : Colors.grey,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEnglish
                    ? titleEn
                    : titleAm, // Show title based on selected language
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontFamily: fontFamily,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                isEnglish
                    ? contentEn
                    : contentAm, // Show content based on selected language
                style: TextStyle(
                  fontSize: fontSize,
                  color: isDarkTheme ? Colors.white70 : Colors.black87,
                  fontFamily: fontFamily,
                ),
              ),
              // Optionally display content in the other language
              // Text(
              //   isEnglish ? contentAm : contentEn,
              //   style: TextStyle(
              //     fontSize: fontSize,
              //     color: isDarkTheme ? Colors.white70 : Colors.black87,
              //     fontFamily: fontFamily,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
