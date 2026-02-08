import 'package:flutter/material.dart';

class MyThemeData{
static const colorprimary=Color(0xFF0E3A99);
  static ThemeData lightTheme=ThemeData(
    appBarTheme:AppBarTheme(
        centerTitle: true,
    ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Color(0xFF0E3A99),
          unselectedItemColor: Color(0xFF9E9E9E),
        ),
    primaryColor: Color(0xFFF4F7FF),
    brightness: Brightness.light,
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF0E3A99),
        onPrimary: Color(0xFF202020),
        secondary: Colors.white,
        onSecondary: Color(0xFF686868),
        error: Colors.red,
        onError: Colors.black,
        surface: Color(0xFFF4F7FF),
        onSurface: Colors.white,
    ),

  );
  static ThemeData darkTheme=ThemeData(
    appBarTheme:AppBarTheme(
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    primaryColor: Color(0xFFFFFFFF),
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFFFFFFF),
        onPrimary: Color(0xFF202020),
        secondary: Colors.white,
        onSecondary: Color(0xFFD6D6D6),
        error: Colors.red,
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFF000F30),
        onSurface: Colors.white,
    ),

  );


}