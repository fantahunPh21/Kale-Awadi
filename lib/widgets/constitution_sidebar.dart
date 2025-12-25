import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/chapter.dart';
import '../data/models/article.dart';
import '../data/models/app_language.dart';
import '../providers/language_provider.dart';

class ConstitutionSidebar extends StatefulWidget {
  final List<Chapter> chapters;
  final Chapter? selectedChapter;
  final Article? selectedArticle;
  final Function(Chapter, Article) onArticleSelected;
  final VoidCallback? onToggle;

  const ConstitutionSidebar({
    super.key,
    required this.chapters,
    this.selectedChapter,
    this.selectedArticle,
    required this.onArticleSelected,
    this.onToggle,
  });

  @override
  State<ConstitutionSidebar> createState() => _ConstitutionSidebarState();
}

class _ConstitutionSidebarState extends State<ConstitutionSidebar> {
  final Map<String, bool> _expandedChapters = {};

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final lang = languageProvider.lang;

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Sidebar header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.menu_book,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Chapters',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (widget.onToggle != null)
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: widget.onToggle,
                    tooltip: 'Collapse sidebar',
                  ),
              ],
            ),
          ),
          // Chapters list
          Expanded(
            child: ListView.builder(
              itemCount: widget.chapters.length,
              itemBuilder: (context, chapterIndex) {
                final chapter = widget.chapters[chapterIndex];
                final isExpanded = _expandedChapters[chapter.number] ?? false;
                final isSelected = widget.selectedChapter?.number == chapter.number;

                return Column(
                  children: [
                    // Chapter header
                    InkWell(
                      onTap: () {
                        setState(() {
                          _expandedChapters[chapter.number] = !isExpanded;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        color: isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : null,
                        child: Row(
                          children: [
                            Icon(
                              isExpanded
                                  ? Icons.expand_more
                                  : Icons.chevron_right,
                              size: 20,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                chapter.displayTitle(lang),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontFamily: lang == AppLanguage.am
                                          ? 'NotoEthiopic'
                                          : null,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer
                                          : null,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Articles list (when expanded)
                    if (isExpanded)
                      ...chapter.articles.map((article) {
                        final isArticleSelected =
                            widget.selectedChapter?.number == chapter.number &&
                                widget.selectedArticle?.number == article.number;

                        return InkWell(
                          onTap: () {
                            widget.onArticleSelected(chapter, article);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 44,
                              right: 16,
                              top: 10,
                              bottom: 10,
                            ),
                            color: isArticleSelected
                                ? Theme.of(context).colorScheme.secondaryContainer
                                : null,
                            child: Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isArticleSelected
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    article.displayNumberAndTitle(lang).isEmpty
                                        ? chapter.displayTitle(lang)
                                        : article.displayNumberAndTitle(lang),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontFamily: lang == AppLanguage.am
                                              ? 'NotoEthiopic'
                                              : null,
                                          color: isArticleSelected
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer
                                              : null,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

