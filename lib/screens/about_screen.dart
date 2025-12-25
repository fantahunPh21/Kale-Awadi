import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/app_language.dart';
import '../providers/language_provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final lang = languageProvider.lang;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Icon/Logo placeholder
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.menu_book,
                  size: 60,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // App Name
            Center(
              child: Text(
                'Qale Awadi Constitution',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Version 1.0.0',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            const SizedBox(height: 32),
            // Description
            Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'This Qale Awadi (Ecclesiastical Constitution) may be cited as The Parish Council "Qale Awadi" (Bylaw) revised for the fourth time and enacted in 2009 E.C. (2017) to strengthen the unity and administration of the Ethiopian Orthodox Tewahedo Church.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                    height: 1.6,
                  ),
            ),
            const SizedBox(height: 24),
            // Features
            Text(
              'Features',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            _buildFeatureItem(
              context,
              lang,
              Icons.menu_book,
              'Read Articles',
              'Browse and read all chapters and articles',
            ),
            _buildFeatureItem(
              context,
              lang,
              Icons.search,
              'Search',
              'Search through all articles quickly',
            ),
            _buildFeatureItem(
              context,
              lang,
              Icons.bookmark,
              'Bookmarks',
              'Save your favorite articles for later',
            ),
            _buildFeatureItem(
              context,
              lang,
              Icons.translate,
              'Bilingual',
              'Switch between English and Amharic',
            ),
            const SizedBox(height: 32),
            // Copyright
            Center(
              child: Text(
                '© 2024 Qale Awadi Constitution App',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    AppLanguage lang,
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: lang == AppLanguage.am ? 'NotoEthiopic' : null,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

