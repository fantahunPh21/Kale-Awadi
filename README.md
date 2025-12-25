# ቃለ-አዋዲ (Kaleawadi) 📖✨

> **A Bilingual Flutter App for the Ethiopian Orthodox Tewahedo Church's Ecclesiastical Constitution**

[![Flutter](https://img.shields.io/badge/Flutter-3.5.1+-blue.svg)](https://flutter.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey.svg)](https://flutter.dev/docs/deployment)
[![Language](https://img.shields.io/badge/Language-Amharic%20%7C%20English-green.svg)](https://en.wikipedia.org/wiki/Amharic)

## 🎯 What is Kaleawadi?

**Kaleawadi** (ቃለ-አዋዲ) is a modern, interactive Flutter application that provides easy access to the Ethiopian Orthodox Tewahedo Church's Ecclesiastical Constitution. The app features both **Amharic** and **English** languages, making this important religious document accessible to a wider audience.

### 🌟 Key Features

- 📱 **Cross-Platform**: Works on Android, iOS, Web, and Desktop
- 🌍 **Bilingual Support**: Full Amharic and English content
- 🔍 **Smart Search**: Find specific chapters and articles quickly
- 🌙 **Dark/Light Theme**: Comfortable reading in any lighting condition
- 📖 **Bookmarking**: Save important passages for later reference
- ⚙️ **Customizable Reading**: Adjustable font sizes and styles
- 💾 **Local Storage**: Saves your preferences and bookmarks

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.5.1 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/kaleawadi.git
   cd kaleawadi
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### 📱 Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## 🏗️ Project Structure

```
kaleawadi/
├── lib/                    # Main Flutter source code
│   ├── main.dart          # App entry point
│   ├── chapter.dart       # Data models
│   ├── chapter_list_page.dart      # Main chapter listing
│   ├── chapter_detail_page.dart    # Chapter content display
│   ├── bookmark_detail_page.dart   # Bookmark management
│   └── about_page.dart    # About information
├── assets/
│   └── chapters.json      # Bilingual content data
├── android/               # Android-specific files
├── ios/                   # iOS-specific files
├── web/                   # Web platform files
└── pubspec.yaml          # Dependencies and configuration
```

## 📚 Content Structure

The app contains the complete Ecclesiastical Constitution organized into:

- **Chapters** (ምዕራፍ): Main sections of the constitution
- **Articles** (አንቀጽ): Specific legal provisions
- **Bilingual Content**: Each section available in both Amharic and English

### Sample Content

- **Chapter 1**: Introduction (መግቢያ)
- **Chapter 2**: Establishment and Structure
- **Chapter 3**: Formation and Implementation
- And many more...

## 🎨 Features in Detail

### 🔍 Search Functionality
- Real-time search across all chapters
- Filters content by title and content
- Instant results as you type

### 📖 Reading Experience
- **Font Size Control**: Adjust from 12px to 30px
- **Font Family Options**: Roboto, Arial, Courier New
- **Theme Switching**: Light and dark modes
- **Language Toggle**: Switch between Amharic and English

### 💾 Bookmark System
- Save important passages
- Quick access to saved content
- Persistent storage across app sessions

### ⚙️ Settings & Preferences
- Customizable reading experience
- Persistent user preferences
- Cross-session settings retention

## 🛠️ Technical Details

### Dependencies
- **Flutter**: UI framework
- **shared_preferences**: Local data persistence
- **Material Design**: Modern UI components

### Architecture
- **StatefulWidget**: For dynamic content
- **SharedPreferences**: Local storage
- **JSON Parsing**: Content data handling
- **Responsive Design**: Works on all screen sizes

## 🌐 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ Supported | APK builds available |
| iOS | ✅ Supported | Requires Xcode |
| Web | ✅ Supported | Responsive design |
| Windows | ✅ Supported | Desktop app |
| macOS | ✅ Supported | Native macOS app |
| Linux | ✅ Supported | Linux desktop |

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Development Guidelines
- Follow Flutter best practices
- Maintain bilingual content consistency
- Test on multiple platforms
- Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Ethiopian Orthodox Tewahedo Church** for the content
- **Flutter Team** for the amazing framework
- **Contributors** who help improve the app

## 📞 Support & Contact


- **Telgeram**: https://t.me/FTYOTORAWI

## 🔮 Roadmap

- [ ] **Audio Support**: Text-to-speech in both languages
- [ ] **Offline Mode**: Download content for offline reading
- [ ] **Sharing**: Share passages on social media
- [ ] **Annotations**: User notes and highlights
- [ ] **Sync**: Cloud backup of bookmarks and preferences
- [ ] **Accessibility**: Screen reader support

---

<div align="center">

**Made with ❤️ for the Ethiopian Orthodox Tewahedo Church Community**


</div>
