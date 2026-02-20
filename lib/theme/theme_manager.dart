import 'package:flutter/material.dart';

abstract class ThemeManager {

  static ThemeData themeData = ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Color(0xff0E3A99),
        selectedLabelStyle: TextStyle(color: Color(0xff0E3A99),
            fontWeight: FontWeight.w400,
            fontSize: 12
        ),
      )
  );
}