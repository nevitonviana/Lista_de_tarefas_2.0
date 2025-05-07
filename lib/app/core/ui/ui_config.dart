import 'package:flutter/material.dart';

import 'extensions/size_screen_extension.dart';

class UiConfig {
  UiConfig._();

  static String get title => "Lista De Tarefas";

  static ThemeData get theme =>
      ThemeData(
        primaryColor: const Color(0xffa8ce4b),
        primaryColorDark: const Color(0xff689f38),
        primaryColorLight: const Color(0xff252b4a),
        cardTheme: const CardTheme(
          color: Colors.white70,
          surfaceTintColor: Colors.white70,
        ),
        scaffoldBackgroundColor: const Color(0xbff0f0f0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff252b4a),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          foregroundColor: Colors.white,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            iconColor: Colors.white,
            iconSize: 25,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.tx,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      );
}
