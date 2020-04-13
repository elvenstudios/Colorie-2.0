import 'package:colorie/screens/home_screen.dart';
import 'package:colorie/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colorie',
      theme: theme,
      home: HomeScreen(),
    );
  }
}
