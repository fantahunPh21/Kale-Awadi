import 'package:flutter/foundation.dart';

class Bookmark {
  final String chapterNumber;
  final String articleNumber;

  Bookmark({
    required this.chapterNumber,
    required this.articleNumber,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bookmark &&
          runtimeType == other.runtimeType &&
          chapterNumber == other.chapterNumber &&
          articleNumber == other.articleNumber;

  @override
  int get hashCode => chapterNumber.hashCode ^ articleNumber.hashCode;
}

class BookmarkProvider extends ChangeNotifier {
  final Set<Bookmark> _bookmarks = {};

  Set<Bookmark> get bookmarks => Set.unmodifiable(_bookmarks);

  bool isBookmarked(String chapterNumber, String articleNumber) {
    return _bookmarks.contains(
      Bookmark(
        chapterNumber: chapterNumber,
        articleNumber: articleNumber,
      ),
    );
  }

  void toggleBookmark(String chapterNumber, String articleNumber) {
    final bookmark = Bookmark(
      chapterNumber: chapterNumber,
      articleNumber: articleNumber,
    );

    if (_bookmarks.contains(bookmark)) {
      _bookmarks.remove(bookmark);
    } else {
      _bookmarks.add(bookmark);
    }

    notifyListeners();
  }

  void removeBookmark(String chapterNumber, String articleNumber) {
    _bookmarks.remove(
      Bookmark(
        chapterNumber: chapterNumber,
        articleNumber: articleNumber,
      ),
    );
    notifyListeners();
  }

  void clearAll() {
    _bookmarks.clear();
    notifyListeners();
  }
}

