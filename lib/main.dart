import 'package:flutter/material.dart';
import 'chapter_list_page.dart'; // Import the ChapterListPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bilingual Chapters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: ChapterListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
