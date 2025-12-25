import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/chapter.dart';
import '../data/models/article.dart';
import '../data/models/app_language.dart';
import '../providers/language_provider.dart';
import '../providers/bookmark_provider.dart';
import '../widgets/language_switch.dart';

class ArticleScreen extends StatelessWidget {
  final Chapter chapter;
  final Article article;

  const ArticleScreen({
    super.key,
    required this.chapter,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final lang = languageProvider.lang;

    final isBookmarked = bookmarkProvider.isBookmarked(
      chapter.number,
      article.number,
    );

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              title: Text(
                chapter.displayTitle(lang),
                style: TextStyle(
                  fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  ),
                  onPressed: () {
                    bookmarkProvider.toggleBookmark(
                      chapter.number,
                      article.number,
                    );
                  },
                  tooltip: isBookmarked ? 'Remove bookmark' : 'Add bookmark',
                ),
                const LanguageSwitch(),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapter.displayTitle(lang),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily:
                                lang == AppLanguage.am ? 'NotoEthiopic' : null,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${article.number} ${article.title}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontFamily:
                                lang == AppLanguage.am ? 'NotoEthiopic' : null,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      lang == AppLanguage.am && article.bodyAm != null
                          ? article.bodyAm!
                          : article.body,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontFamily:
                                lang == AppLanguage.am ? 'NotoEthiopic' : null,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

