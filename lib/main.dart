import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/language_provider.dart';
import 'providers/bookmark_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ConstitutionApp());
}

class ConstitutionApp extends StatelessWidget {
  const ConstitutionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: MaterialApp(
        title: 'Qale Awadi',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            // Papyrus color scheme
            primary: const Color(0xFF8B7355), // Warm brown/tan
            onPrimary: Colors.white,
            primaryContainer: const Color(0xFFD4C4A8), // Light tan
            onPrimaryContainer: const Color(0xFF3E2E1F), // Dark brown
            secondary: const Color(0xFFA68B5B), // Medium tan
            onSecondary: Colors.white,
            surface: const Color(0xFFF5E6D3), // Light papyrus/cream
            onSurface: const Color(0xFF3E2E1F), // Dark brown text
            surfaceContainerHighest: const Color(0xFFE8D9C6), // Slightly darker papyrus
          ),
          scaffoldBackgroundColor: const Color(0xFFF5E6D3), // Papyrus background
          useMaterial3: true,
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                titleMedium: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                bodyLarge: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

