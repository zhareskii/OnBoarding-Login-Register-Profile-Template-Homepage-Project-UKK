import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UKK Project',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF8B4513, {
          50: Color(0xFFF5F0ED),
          100: Color(0xFFE6D8D1),
          200: Color(0xFFD5BDB2),
          300: Color(0xFFC4A293),
          400: Color(0xFFB78D7B),
          500: Color(0xFF8B4513),
          600: Color(0xFF7D3F11),
          700: Color(0xFF6C370E),
          800: Color(0xFF5B2F0C),
          900: Color(0xFF432307),
        }),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(0xFF8B4513, {
            50: Color(0xFFF5F0ED),
            100: Color(0xFFE6D8D1),
            200: Color(0xFFD5BDB2),
            300: Color(0xFFC4A293),
            400: Color(0xFFB78D7B),
            500: Color(0xFF8B4513),
            600: Color(0xFF7D3F11),
            700: Color(0xFF6C370E),
            800: Color(0xFF5B2F0C),
            900: Color(0xFF432307),
          }),
        ).copyWith(
          secondary: Color(0xFFD2B48C),
          background: Color(0xFFFAF7F4),
          surface: Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: Color(0xFFFAF7F4),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF8B4513),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFD2B48C)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFD2B48C)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF8B4513), width: 2),
          ),
        ),
      ),
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}