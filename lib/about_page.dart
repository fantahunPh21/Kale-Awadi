import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final bool isDarkTheme;

  const AboutPage({super.key, required this.isDarkTheme}); // Accepting isDarkTheme as a parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: isDarkTheme ? Colors.grey[850] : Colors.grey[900],
      ),
      backgroundColor: isDarkTheme ? Colors.grey[800] : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About The Developer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Hello This is Fitsum T. a Flutter developer passionate about creating amazing mobile applications.',
              style: TextStyle(
                fontSize: 18,
                color: isDarkTheme ? Colors.white70 : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Connect with me on GitHub:',
              style: TextStyle(
                fontSize: 18,
                color: isDarkTheme ? Colors.white70 : Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the developer's GitHub profile
              },
              child: const Text(
                'GitHub Profile',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Follow me on Twitter:',
              style: TextStyle(
                fontSize: 18,
                color: isDarkTheme ? Colors.white70 : Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the developer's Twitter profile
              },
              child: const Text(
                'Twitter Profile',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
