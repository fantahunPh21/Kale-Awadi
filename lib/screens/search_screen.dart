import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/chapter.dart';
import '../data/models/article.dart';
import '../data/models/app_language.dart';
import '../providers/language_provider.dart';
import '../widgets/article_content.dart';

class SearchScreen extends StatefulWidget {
  final List<Chapter> chapters;

  const SearchScreen({
    super.key,
    required this.chapters,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Article> _searchResults = [];
  Chapter? _selectedChapter;
  Article? _selectedArticle;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final results = <Article>[];
    for (final chapter in widget.chapters) {
      for (final article in chapter.articles) {
        // Search in both English and Amharic versions
        final searchText = '${article.number} ${article.title} ${article.body} '
            '${article.numberAm ?? ''} ${article.titleAm ?? ''} ${article.bodyAm ?? ''}'
            .toLowerCase();
        if (searchText.contains(query.toLowerCase())) {
          results.add(article);
        }
      }
    }

    setState(() {
      _searchResults = results;
    });
  }

  void _onArticleSelected(Article article) {
    // Find the chapter for this article
    Chapter? chapter;
    for (final ch in widget.chapters) {
      if (ch.articles.contains(article)) {
        chapter = ch;
        break;
      }
    }

    if (chapter != null) {
      setState(() {
        _selectedChapter = chapter;
        _selectedArticle = article;
      });
    }
  }

  void _goBack() {
    setState(() {
      _selectedChapter = null;
      _selectedArticle = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(
            fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search articles...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _performSearch,
            ),
          ),
          // Search results
          Expanded(
            child: _searchResults.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchController.text.isEmpty
                              ? 'Start typing to search...'
                              : 'No results found',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontFamily:
                                    lang == AppLanguage.am ? 'NotoEthiopic' : null,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final article = _searchResults[index];
                      // Find chapter for this article
                      Chapter? chapter;
                      for (final ch in widget.chapters) {
                        if (ch.articles.contains(article)) {
                          chapter = ch;
                          break;
                        }
                      }

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            article.displayNumberAndTitle(lang),
                            style: TextStyle(
                              fontFamily:
                                  lang == AppLanguage.am ? 'NotoEthiopic' : null,
                            ),
                          ),
                          subtitle: Text(
                            chapter != null
                                ? chapter.displayTitle(lang)
                                : '',
                            style: TextStyle(
                              fontFamily:
                                  lang == AppLanguage.am ? 'NotoEthiopic' : null,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _onArticleSelected(article),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

