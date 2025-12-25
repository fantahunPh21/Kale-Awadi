import 'package:flutter/foundation.dart';
import '../data/models/app_language.dart';

class LanguageProvider extends ChangeNotifier {
  AppLanguage _lang = AppLanguage.en;

  AppLanguage get lang => _lang;

  void toggle() {
    _lang = _lang == AppLanguage.en ? AppLanguage.am : AppLanguage.en;
    notifyListeners();
  }

  void setLanguage(AppLanguage language) {
    if (_lang != language) {
      _lang = language;
      notifyListeners();
    }
  }
}

