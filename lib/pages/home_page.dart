import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFF0B1015);
  static const Color panel = Color(0xFF121A22);
  static const Color card = Color(0xFF161F27);
  static const Color primary = Color(0xFF54D3A3);
  static const Color primarySoft = Color(0xFF90F2C5);
  static const Color text = Color(0xFFF5F7FA);
  static const Color muted = Color(0xFF9AA7B3);
  static const Color danger = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFF7C873);

  static ThemeData get darkTheme {
    final base = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      fontFamily: GoogleFonts.notoSansGeorgian().fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: primarySoft,
        surface: card,
        background: background,
        onBackground: text,
        onPrimary: Color(0xFF04150F),
        onSurface: text,
      ),
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(color: text),
        titleTextStyle: GoogleFonts.notoSansGeorgian(
          color: text,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardTheme(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: panel,
        surfaceTintColor: Colors.transparent,
        indicatorColor: primary.withOpacity(0.18),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          return GoogleFonts.notoSansGeorgian(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: states.contains(MaterialState.selected) ? text : muted,
          );
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.02),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primary),
        ),
      ),
      textTheme: GoogleFonts.notoSansGeorgianTextTheme(base.textTheme.apply(
        bodyColor: text,
        displayColor: text,
      )),
    );
  }
}
