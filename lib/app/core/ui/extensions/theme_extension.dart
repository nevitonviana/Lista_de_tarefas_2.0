import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleStyleSmaller => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black45,
      );
  TextStyle get titleStyleMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black45,
  );
}
