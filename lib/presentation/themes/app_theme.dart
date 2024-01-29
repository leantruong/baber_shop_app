import 'package:flutter/material.dart';

class AppTheme {


    static ThemeData get getBrightTheme => ThemeData(
        brightness: Brightness.light,
        
    );
   
    static ThemeData get getDarkTheme => ThemeData(
        brightness: Brightness.dark, colorScheme: const ColorScheme(background: Colors.black)

    );
}