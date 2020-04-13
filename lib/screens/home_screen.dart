import 'package:colorie/models/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///
/// The HomeScreen of our application.
/// Used to display the [Log]
///
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () => print('hi'),
          child: Text('button'),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
