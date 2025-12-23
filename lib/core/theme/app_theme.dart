import 'package:flutter/material.dart';

class AppTheme {
  // Strict Design Constants
  static const Color kBackground = Color(0xFFF2F4F7);
  static const Color kCardColor = Colors.white;
  static const double kRadius = 30.0;
  static const BoxShadow kSoftShadow = BoxShadow(
    color: Color(0x0D000000), // Black 5%
    blurRadius: 15,
    offset: Offset(0, 5),
  );

  static ThemeData fromConfig(Map<String, dynamic> config) {
    String primaryHex = config['primaryColor'] ?? '#1A1A1A';
    String secondaryHex = config['secondaryColor'] ?? '#FFFFFF';
    String fontFamily = config['fontFamily'] ?? 'Inter';
    bool isDark = config['isDark'] ?? false;

    final primaryColor = _hexToColor(primaryHex);
    final secondaryColor = _hexToColor(secondaryHex);

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      brightness: isDark ? Brightness.dark : Brightness.light,
      
      // Global Background - STRICT SOLID
      scaffoldBackgroundColor: isDark ? const Color(0xFF121212) : kBackground,

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: isDark ? const Color(0xFF1E1E1E) : kCardColor,
      ),
      
      // Card Theme - STRICT SOLID
      cardTheme: CardTheme(
        color: isDark ? const Color(0xFF1E1E1E) : kCardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadius)),
        margin: EdgeInsets.zero,
      ),

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1.0, color: Colors.black87),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5, color: Colors.black87), 
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
        bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, height: 1.5, color: Colors.black54),
      ).apply(
        bodyColor: isDark ? Colors.white : Colors.black87,
        displayColor: isDark ? Colors.white : Colors.black87,
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : Colors.black87, 
          fontSize: 20, 
          fontWeight: FontWeight.w800, 
          letterSpacing: -0.5
        ),
      ),
      
      // Input Decoration - STRICT SOLID
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? Colors.grey[900] : kCardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Slightly less than cards for inputs usually
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        hintStyle: TextStyle(color: isDark ? Colors.white60 : Colors.black38),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadius)),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5),
        )
      ),
    );
  }

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
