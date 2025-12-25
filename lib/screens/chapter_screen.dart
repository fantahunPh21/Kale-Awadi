import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/chapter.dart';
import '../data/models/app_language.dart';
import '../providers/language_provider.dart';
import '../widgets/article_card.dart';
import '../widgets/language_switch.dart';
import 'article_screen.dart';

class ChapterScreen extends StatelessWidget {
  final Chapter chapter;

  const ChapterScreen({
    super.key,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final lang = languageProvider.lang;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          chapter.displayTitle(lang),
          style: TextStyle(
            fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
          ),
        ),
        actions: const [
          LanguageSwitch(),
        ],
      ),
      body: chapter.articles.isEmpty
          ? Center(
              child: Text(
                'No articles added yet for this chapter.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: chapter.articles.length,
              itemBuilder: (context, index) {
                final article = chapter.articles[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ArticleScreen(
                            chapter: chapter,
                            article: article,
                          ),
                        ),
                      );
                    },
                    child: ArticleCard(
                      chapter: chapter,
                      article: article,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

