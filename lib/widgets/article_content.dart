import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/chapter.dart';
import '../data/models/article.dart';
import '../data/models/app_language.dart';
import '../providers/language_provider.dart';
import '../providers/bookmark_provider.dart';
import 'language_switch.dart';

class ArticleContent extends StatelessWidget {
  final Chapter? chapter;
  final Article? article;
  final VoidCallback? onToggleSidebar;

  const ArticleContent({
    super.key,
    this.chapter,
    this.article,
    this.onToggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final lang = languageProvider.lang;

    return Scaffold(
      appBar: AppBar(
        leading: onToggleSidebar != null
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: onToggleSidebar,
                tooltip: 'Show sidebar',
              )
            : null,
        title: Text(
          chapter != null
              ? chapter!.displayTitle(lang)
              : 'Qale Awadi Constitution',
          style: TextStyle(
            fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
          ),
        ),
        actions: [
          if (chapter != null && article != null && article!.number.isNotEmpty)
            IconButton(
              icon: Icon(
                bookmarkProvider.isBookmarked(chapter!.number, article!.number)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: () {
                bookmarkProvider.toggleBookmark(
                  chapter!.number,
                  article!.number,
                );
              },
              tooltip: bookmarkProvider.isBookmarked(
                        chapter!.number,
                        article!.number,
                      )
                  ? 'Remove bookmark'
                  : 'Add bookmark',
            ),
          const LanguageSwitch(),
        ],
      ),
      body: chapter == null || article == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.article_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select an article to view',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily:
                              lang == AppLanguage.am ? 'NotoEthiopic' : null,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter!.displayTitle(lang),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily:
                              lang == AppLanguage.am ? 'NotoEthiopic' : null,
                        ),
                  ),
                  if (article!.number.isNotEmpty || article!.title.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      article!.displayNumberAndTitle(lang),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontFamily:
                                lang == AppLanguage.am ? 'NotoEthiopic' : null,
                          ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    lang == AppLanguage.am && article!.bodyAm != null
                        ? article!.bodyAm!
                        : article!.body,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontFamily:
                              lang == AppLanguage.am ? 'NotoEthiopic' : null,
                          height: 1.6,
                        ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
    );
  }
}

