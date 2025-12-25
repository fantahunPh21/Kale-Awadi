import 'package:flutter/material.dart';
import '../data/models/chapter.dart';
import '../data/models/article.dart';
import '../widgets/constitution_sidebar.dart';
import '../widgets/article_content.dart';

class HomeScreen extends StatefulWidget {
  final List<Chapter> chapters;

  const HomeScreen({
    super.key,
    required this.chapters,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Chapter? _selectedChapter;
  Article? _selectedArticle;
  bool _isSidebarExpanded = false;

  void _onArticleSelected(Chapter chapter, Article article) {
    setState(() {
      _selectedChapter = chapter;
      _selectedArticle = article;
      // Auto-close sidebar when article is selected (optional UX improvement)
      _isSidebarExpanded = false;
    });
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    // Auto-select first article if available
    if (widget.chapters.isNotEmpty) {
      final firstChapter = widget.chapters.first;
      if (firstChapter.articles.isNotEmpty) {
        _selectedChapter = firstChapter;
        _selectedArticle = firstChapter.articles.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Content area (always visible)
        ArticleContent(
          chapter: _selectedChapter,
          article: _selectedArticle,
          onToggleSidebar: _toggleSidebar,
        ),
        // Overlay backdrop (closes sidebar when tapped)
        if (_isSidebarExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleSidebar,
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
          ),
        // Sidebar (overlay)
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: _isSidebarExpanded ? 0 : -280,
          top: 0,
          bottom: 0,
          width: 280,
          child: Material(
            elevation: 8,
            child: ConstitutionSidebar(
              chapters: widget.chapters,
              selectedChapter: _selectedChapter,
              selectedArticle: _selectedArticle,
              onArticleSelected: _onArticleSelected,
              onToggle: _toggleSidebar,
            ),
          ),
        ),
      ],
    );
  }
}

