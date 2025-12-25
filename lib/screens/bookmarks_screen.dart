import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/chapter.dart';
import '../data/models/article.dart';
import '../data/models/app_language.dart';
import '../providers/bookmark_provider.dart';
import '../providers/language_provider.dart';
import '../widgets/article_content.dart';

class BookmarksScreen extends StatefulWidget {
  final List<Chapter> chapters;

  const BookmarksScreen({
    super.key,
    required this.chapters,
  });

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  Chapter? _selectedChapter;
  Article? _selectedArticle;

  void _onArticleSelected(Chapter chapter, Article article) {
    setState(() {
      _selectedChapter = chapter;
      _selectedArticle = article;
    });
  }

  void _goBack() {
    setState(() {
      _selectedChapter = null;
      _selectedArticle = null;
    });
  }

  List<MapEntry<Chapter, Article>> _getBookmarkedArticles() {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
    final bookmarked = <MapEntry<Chapter, Article>>[];

    for (final chapter in widget.chapters) {
      for (final article in chapter.articles) {
        if (bookmarkProvider.isBookmarked(chapter.number, article.number)) {
          bookmarked.add(MapEntry(chapter, article));
        }
      }
    }

    return bookmarked;
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final lang = languageProvider.lang;

    if (_selectedChapter != null && _selectedArticle != null) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (!didPop) {
            _goBack();
          }
        },
        child: ArticleContent(
          chapter: _selectedChapter,
          article: _selectedArticle,
          onToggleSidebar: null,
        ),
      );
    }

    final bookmarkedArticles = _getBookmarkedArticles();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmarks',
          style: TextStyle(
            fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
          ),
        ),
      ),
      body: bookmarkedArticles.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No bookmarks yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bookmark articles to read them later',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final entry = bookmarkedArticles[index];
                final chapter = entry.key;
                final article = entry.value;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      article.displayNumberAndTitle(lang),
                      style: TextStyle(
                        fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                      ),
                    ),
                    subtitle: Text(
                      chapter.displayTitle(lang),
                      style: TextStyle(
                        fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        bookmarkProvider.removeBookmark(
                          chapter.number,
                          article.number,
                        );
                        setState(() {}); // Refresh the list
                      },
                      tooltip: 'Remove bookmark',
                    ),
                    onTap: () => _onArticleSelected(chapter, article),
                  ),
                );
              },
            ),
    );
  }
}

