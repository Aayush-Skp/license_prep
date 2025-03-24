import 'package:flutter/material.dart';

class CustomTheme {
  //static Color primaryColor = Color(0xFF1E201E);
  static Color primaryColor = Colors.grey.shade900;
  static const Color secondaryColor = const Color(0xFF3C3D37);
  static const Color primaryText = Colors.white;
  static const Color appBarColor = Colors.transparent;
  static const String mainLogo = 'assets/logo.png';

  CustomTheme._privateConstructor();
  static final CustomTheme _instance = CustomTheme._privateConstructor();
  factory CustomTheme() {
    return _instance;
  }
  void initializeTheme(Color selectedColor) {
    primaryColor = selectedColor;
  }

  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(color: secondaryColor),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 25.0, color: Colors.white),
      titleMedium: TextStyle(fontSize: 20.0, color: Colors.white),
      titleSmall: TextStyle(fontSize: 15.0, color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: primaryColor,
    // Add more customizations like InputDecorationTheme, IconTheme, etc.
  );
  static const double symmetricHozPadding = 13.0;
}
