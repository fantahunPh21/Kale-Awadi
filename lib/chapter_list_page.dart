import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:shared_preferences/shared_preferences.dart';
import 'chapter.dart'; // Your Chapter model
import 'chapter_detail_page.dart'; // Chapter detail page
import 'about_page.dart'; // About page
import 'bookmark_detail_page.dart'; // Bookmarks page

class ChapterListPage extends StatefulWidget {
  const ChapterListPage({super.key});

  @override
  _ChapterListPageState createState() => _ChapterListPageState();
}

class _ChapterListPageState extends State<ChapterListPage> {
  List<Chapter> chapters = [];
  List<String> bookmarks = [];
  bool isDarkTheme = false;
  bool isEnglish = false;
  String searchQuery = '';
  ValueNotifier<double> fontSizeNotifier = ValueNotifier(16.0);
  String fontFamily = 'Roboto'; // Default font family

  @override
  void initState() {
    super.initState();
    loadChapters();
    loadPreferences(); // Load saved preferences
  }

  Future<void> loadChapters() async {
    final String response = await rootBundle.loadString('assets/chapters.json');
    final data = json.decode(response);

    setState(() {
      chapters = (data['chapters'] as List)
          .map((chapter) => Chapter.fromJson(chapter))
          .toList();
      print('Chapters Loaded: $chapters'); // Debugging line
    });
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarks = prefs.getStringList('bookmarks') ?? [];
      isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
      fontSizeNotifier.value = prefs.getDouble('fontSize') ?? 16.0;
      fontFamily = prefs.getString('fontFamily') ?? 'Roboto';
    });
  }

  Future<void> savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('bookmarks', bookmarks);
    await prefs.setBool('isDarkTheme', isDarkTheme);
    await prefs.setDouble('fontSize', fontSizeNotifier.value);
    await prefs.setString('fontFamily', fontFamily);
  }

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
      savePreferences(); // Save preference after toggle
    });
  }

  void toggleLanguage() {
    setState(() {
      isEnglish = !isEnglish; // Toggle between English and Amharic
    });
  }

  void bookmarkText(String text) {
    setState(() {
      bookmarks.add(text);
      savePreferences(); // Save bookmarks after adding
    });
  }

  void deleteBookmark(int index) {
    setState(() {
      bookmarks.removeAt(index);
      savePreferences(); // Save bookmarks after deleting
    });
  }

  List<Chapter> get filteredChapters {
    if (searchQuery.isEmpty) {
      return chapters;
    }
    final filtered = chapters.where((chapter) {
      final titleMatch =
          chapter.chapter.toLowerCase().contains(searchQuery.toLowerCase());
      return titleMatch;
    }).toList();
    print('Filtered Chapters: $filtered'); // Debugging line
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkTheme ? Colors.grey[850] : Colors.grey[200];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'ቃለ-አዋዲ',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSizeNotifier.value,
          ),
        ),
        backgroundColor: isDarkTheme ? Colors.black87 : Colors.grey,
        toolbarHeight: 45,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: toggleLanguage,
          ),
          IconButton(
            icon: Icon(isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: toggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[800],
              ),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Bookmarks',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Bookmarks',
                        style: TextStyle(color: Colors.black)),
                    backgroundColor:
                        isDarkTheme ? Colors.grey[850] : Colors.white,
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: bookmarks.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              bookmarks[index],
                              style: const TextStyle(color: Colors.black),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookmarkDetailPage(
                                    text: bookmarks[index],
                                    isDarkTheme: isDarkTheme,
                                  ),
                                ),
                              );
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                deleteBookmark(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Font Size and Style'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBuilder(
                            animation: fontSizeNotifier,
                            builder: (context, child) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                child: Column(
                                  children: [
                                    Slider(
                                      value: fontSizeNotifier.value,
                                      min: 12.0,
                                      max: 30.0,
                                      divisions: 18,
                                      label: fontSizeNotifier.value
                                          .round()
                                          .toString(),
                                      onChanged: (value) {
                                        fontSizeNotifier.value = value;
                                        savePreferences(); // Save font size after change
                                      },
                                    ),
                                    Text(
                                      'Font Size: ${fontSizeNotifier.value.toStringAsFixed(1)}',
                                      style: TextStyle(
                                        fontSize: fontSizeNotifier.value,
                                      ),
                                    ),
                                    DropdownButton<String>(
                                      value: fontFamily,
                                      items: <String>[
                                        'Roboto',
                                        'Arial',
                                        'Courier New'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          fontFamily = newValue!;
                                          savePreferences(); // Save font family after change
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AboutPage(isDarkTheme: isDarkTheme)),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Search.......',
                filled: true,
                fillColor: backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: isDarkTheme ? Colors.white70 : Colors.black87,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                hintStyle: TextStyle(
                  color: isDarkTheme ? Colors.white70 : Colors.black54,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: backgroundColor,
              child: ListView.builder(
                itemCount: filteredChapters.length,
                itemBuilder: (context, index) {
                  print(
                      'Chapter Title: ${filteredChapters[index].chapter}'); // Debugging line
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    color: isDarkTheme ? Colors.grey[850] : Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15.0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChapterDetailPage(
                              chapter: filteredChapters[index],
                              isDarkTheme: isDarkTheme,
                              isEnglish: isEnglish,
                              onBookmark: bookmarkText,
                              fontSize: fontSizeNotifier.value,
                              fontFamily: fontFamily,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          filteredChapters[index].chapter,
                          style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            fontSize: fontSizeNotifier.value,
                            fontFamily: fontFamily,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
