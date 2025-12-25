import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import '../data/models/chapter.dart';
import 'read_screen.dart';
import 'search_screen.dart';
import 'bookmarks_screen.dart';
import 'about_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final List<Chapter> chapters;

  const MainNavigationScreen({
    super.key,
    required this.chapters,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _currentIndex,
        backgroundColor: const Color(0xFFF5E6D3), // Papyrus cream
        color: const Color(0xFF8B7355), // Papyrus brown
        buttonBackgroundColor: const Color(0xFFD4C4A8), // Light tan
        items: [
          CurvedNavigationBarItem(
            child: const Icon(Icons.menu_book),
            label: 'Read',
          ),
          CurvedNavigationBarItem(
            child: const Icon(Icons.search),
            label: 'Search',
          ),
          CurvedNavigationBarItem(
            child: const Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          CurvedNavigationBarItem(
            child: const Icon(Icons.info),
            label: 'About Us',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return ReadScreen(chapters: widget.chapters);
      case 1:
        return SearchScreen(chapters: widget.chapters);
      case 2:
        return BookmarksScreen(chapters: widget.chapters);
      case 3:
        return const AboutScreen();
      default:
        return ReadScreen(chapters: widget.chapters);
    }
  }
}

