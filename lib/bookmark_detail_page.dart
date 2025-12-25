import 'package:flutter/material.dart';

class BookmarkDetailPage extends StatelessWidget {
  final String text;
  final bool isDarkTheme;

  const BookmarkDetailPage({super.key, required this.text, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark Detail'),
        backgroundColor: isDarkTheme ? Colors.grey[850] : Colors.grey,
      ),
      backgroundColor: isDarkTheme ? Colors.grey[800] : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
