import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // =========================================================
  // COLORS
  // =========================================================

  static const Color primaryColor = Color(0xFF386C3B);

  static const Color lightPrimaryColor = Color(0xFF5D8A60);

  static const Color backgroundColor = Color(0xFFF7F8F5);

  static const Color cardColor = Colors.white;

  static const Color surfaceColor = Color(0xFFF1F3EF);

  static const Color borderColor = Color(0xFFE2E8E3);

  static const Color primaryTextColor = Color(0xFF1E293B);

  static const Color secondaryTextColor = Color(0xFF64748B);

  static const Color incomeColor = Color(0xFF2E7D32);

  static const Color expenseColor = Color(0xFFD96C6C);

  // =========================================================
  // TEXT THEME
  // =========================================================

  static TextTheme textTheme = TextTheme(
    // Main Large Heading
    headlineLarge: GoogleFonts.manrope(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: primaryTextColor,
    ),

    // Screen Heading
    headlineMedium: GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: primaryTextColor,
    ),

    // Section Heading
    titleLarge: GoogleFonts.manrope(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: primaryTextColor,
    ),

    // Card Title
    titleMedium: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: primaryTextColor,
    ),

    // Main Body Text
    bodyLarge: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: primaryTextColor,
    ),

    // Secondary Text
    bodyMedium: GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: secondaryTextColor,
    ),

    // Small Labels
    labelLarge: GoogleFonts.manrope(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: secondaryTextColor,
    ),
  );

  // =========================================================
  // APP BAR THEME
  // =========================================================

  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: backgroundColor,

    elevation: 0,

    scrolledUnderElevation: 0,

    centerTitle: true,

    iconTheme: const IconThemeData(color: primaryTextColor),

    titleTextStyle: GoogleFonts.manrope(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: primaryTextColor,
    ),
  );

  // =========================================================
  // CARD THEME
  // =========================================================

  static CardThemeData cardTheme = CardThemeData(
    color: cardColor,

    elevation: 1,

    // ignore: deprecated_member_use
    shadowColor: Color.fromARGB(208, 0, 0, 0).withOpacity(0.1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

    margin: EdgeInsets.zero,
  );

  // =========================================================
  // ELEVATED BUTTON THEME
  // =========================================================

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,

      foregroundColor: Colors.white,

      elevation: 0,

      minimumSize: const Size(double.infinity, 56),

      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      textStyle: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  // =========================================================
  // INPUT DECORATION THEME
  // =========================================================

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,

    fillColor: cardColor,

    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

    hintStyle: GoogleFonts.manrope(fontSize: 14, color: secondaryTextColor),

    labelStyle: GoogleFonts.manrope(fontSize: 14, color: secondaryTextColor),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: borderColor),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: primaryColor, width: 1.5),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: expenseColor),
    ),
  );

  // =========================================================
  // BOTTOM NAVIGATION BAR THEME
  // =========================================================

  static BottomNavigationBarThemeData bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
        backgroundColor: cardColor,

        selectedItemColor: primaryColor,

        unselectedItemColor: secondaryTextColor,

        type: BottomNavigationBarType.fixed,

        elevation: 8,

        selectedLabelStyle: GoogleFonts.manrope(fontWeight: FontWeight.w600),

        unselectedLabelStyle: GoogleFonts.manrope(fontWeight: FontWeight.w500),
      );

  // =========================================================
  // FLOATING ACTION BUTTON THEME
  // =========================================================

  static const FloatingActionButtonThemeData floatingActionButtonTheme =
      FloatingActionButtonThemeData(
        backgroundColor: primaryColor,

        foregroundColor: Colors.white,

        elevation: 2,
      );

  // =========================================================
  // DIVIDER THEME
  // =========================================================

  static const DividerThemeData dividerTheme = DividerThemeData(
    color: borderColor,

    thickness: 1,

    space: 1,
  );

  // =========================================================
  // SNACKBAR THEME
  // =========================================================

  static SnackBarThemeData snackBarTheme = SnackBarThemeData(
    backgroundColor: primaryColor,

    behavior: SnackBarBehavior.floating,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

    contentTextStyle: GoogleFonts.manrope(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );

  // =========================================================
  // MAIN THEME DATA
  // =========================================================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    fontFamily: GoogleFonts.manrope().fontFamily,

    scaffoldBackgroundColor: backgroundColor,

    primaryColor: primaryColor,

    colorScheme: const ColorScheme.light(
      primary: primaryColor,

      secondary: lightPrimaryColor,

      surface: surfaceColor,

      error: expenseColor,

      onPrimary: Colors.white,

      onSecondary: primaryTextColor,

      onSurface: primaryTextColor,

      onError: Colors.white,
    ),

    textTheme: textTheme,

    appBarTheme: appBarTheme,

    cardTheme: cardTheme,

    elevatedButtonTheme: elevatedButtonTheme,

    inputDecorationTheme: inputDecorationTheme,

    bottomNavigationBarTheme: bottomNavigationBarTheme,

    floatingActionButtonTheme: floatingActionButtonTheme,

    dividerTheme: dividerTheme,

    snackBarTheme: snackBarTheme,
  );
}
