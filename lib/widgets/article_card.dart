import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/chapter.dart';
import '../data/models/article.dart';
import '../data/models/app_language.dart';
import '../providers/language_provider.dart';

class ArticleCard extends StatelessWidget {
  final Chapter chapter;
  final Article article;
  final VoidCallback? onTap;

  const ArticleCard({
    super.key,
    required this.chapter,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final lang = languageProvider.lang;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.displayNumberAndTitle(lang),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            lang == AppLanguage.am && article.bodyAm != null
                ? article.bodyAm!
                : article.body,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                ),
          ),
        ],
      ),
    );
  }
}

