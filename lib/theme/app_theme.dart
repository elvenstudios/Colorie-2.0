import 'package:colorie/theme/brand_colors.dart';
import 'package:flutter/material.dart';

// default light theme
final ThemeData theme = ThemeData(
  primaryColor: purple,
  accentColor: yellow,
  backgroundColor: white,
  buttonColor: yellow,
  dividerColor: grey_1,
  errorColor: red,
  colorScheme: ColorScheme(
    background: Colors.green,
    primary: purple,
    onBackground: purple,
    primaryVariant: yellow,
    secondary: Colors.green,
    onPrimary: white,
    onSurface: black,
    secondaryVariant: Colors.yellow,
    surface: Colors.purple,
    error: red,
    onError: white,
    onSecondary: white,
    brightness: Brightness.light,
  ),
);

// dark theme
// (ndavis): https://trello.com/c/fubwAgbh/15-enable-dark-theme-option
