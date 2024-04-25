import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorTheme {
  ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.orange),
      selectedLabelStyle: TextStyle(
        // color: Colors.orange,
        fontWeight: FontWeight.w500,
      ),
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.blueGrey,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      actionsIconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: GoogleFonts.aBeeZee(
        color: Colors.black,
        fontSize: 18,
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.aBeeZee(color: Colors.black),
      titleLarge: GoogleFonts.aBeeZee(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: GoogleFonts.aBeeZee(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
      labelSmall: GoogleFonts.aBeeZee(
        color: Colors.black,
        fontSize: 13,
      ),
      titleSmall: GoogleFonts.aBeeZee(
        color: Colors.black,
        fontSize: 14,
      ),
      titleMedium: GoogleFonts.aBeeZee(
        color: Colors.black,
        fontSize: 18,
      ),
    ),
    colorScheme: const ColorScheme(
      background: Colors.white,
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.black,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.redAccent,
      onBackground: Colors.grey,
      surface: Color.fromARGB(255, 221, 219, 219),
      onSurface: Colors.black,
      tertiary: Colors.white,
      // onSurfaceVariant: Color.fromARGB(255, 56, 56, 56),
      scrim: Color(0xffB7F2B6),
      onSecondaryContainer: Color.fromARGB(255, 255, 255, 255),
    ),
  );

  ThemeData darkTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 42, 43, 42),
      selectedIconTheme: IconThemeData(color: Colors.orange),
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white24,
    ),
    appBarTheme: AppBarTheme(
      color: const Color.fromARGB(255, 42, 43, 42),
      actionsIconTheme: const IconThemeData(color: Colors.orange),
      titleTextStyle: GoogleFonts.aBeeZee(
        color: Colors.orange,
        fontSize: 18,
      ),
    ),
    colorScheme: const ColorScheme(
      background: Color.fromARGB(255, 42, 43, 42),
      brightness: Brightness.dark,
      primary: Colors.orange,
      onPrimary: Colors.white,
      secondary: Colors.black,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.redAccent,
      onBackground: Colors.grey,
      surface: Color.fromARGB(255, 100, 98, 98),
      onSurface: Color.fromARGB(255, 94, 92, 92),
      tertiary: Colors.grey,
      onSurfaceVariant: Color.fromARGB(255, 56, 56, 56),
      scrim: Color.fromARGB(255, 66, 109, 66),
      onSecondaryContainer: Color.fromARGB(255, 100, 98, 98),
    ),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.aBeeZee(color: Colors.orange),
      titleLarge: GoogleFonts.aBeeZee(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelMedium: GoogleFonts.aBeeZee(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
      labelSmall: GoogleFonts.aBeeZee(
        color: Colors.black,
        fontSize: 13,
      ),
      titleSmall: GoogleFonts.aBeeZee(
        color: Colors.grey,
        fontSize: 14,
      ),
      titleMedium: GoogleFonts.aBeeZee(
        color: Colors.orange,
        fontSize: 18,
      ),
    ),
  );
}

extension CustomColorSchemeX on ColorScheme {}
