import 'package:flutter/material.dart';

class Apptheme {
  static const appBackgroundColor = Color.fromRGBO(21, 21, 33, 255);
  static const buttonColorYellow = Color.fromRGBO(255, 153, 0, 0.926);

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: appBackgroundColor,
      textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      appBarTheme: const AppBarTheme(
        
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: buttonColorYellow,
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

