
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationTheme {

  static const Color primaryColor = Color(0xff2d4356);
  static const Color secondaryColor = Colors.deepPurpleAccent;
  static const Color lightBackgroundColor = Color(0xffe5e5e5);
  static const Color darkBackgroundColor = Color(0xff1e1e1e);
  static const Color onBackgroundColor = Color(0xffffffff);
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: onBackgroundColor,
      secondary: secondaryColor,
      onSecondary: onBackgroundColor,
      error: Colors.red,
      onError: onBackgroundColor,
      surface: lightBackgroundColor,
      onSurface: onBackgroundColor,
    ),
    textTheme: GoogleFonts.ubuntuTextTheme(),
    scaffoldBackgroundColor: lightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.ubuntu(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: primaryColor,
      elevation: 0,
      shape: CircularNotchedRectangle(),
      height: 82,
      padding: EdgeInsets.all(10),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      elevation: 0,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: onBackgroundColor,
      secondary: secondaryColor,
      onSecondary: onBackgroundColor,
      error: Colors.red,
      onError: onBackgroundColor,
      surface: lightBackgroundColor,
      onSurface: onBackgroundColor,
    ),

    scaffoldBackgroundColor: darkBackgroundColor,
    textTheme: GoogleFonts.ubuntuTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.ubuntu(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: primaryColor,
      elevation: 0,
      shape: CircularNotchedRectangle(),
      height: 82,
      padding: EdgeInsets.all(10),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      elevation: 0,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
  );
}