import 'package:colorie/theme/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back,
                      color: black,
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: const <Widget>[
                  Material(
                    child: Hero(
                      tag: 'profile',
                      child: Placeholder(
                        fallbackHeight: 40,
                        fallbackWidth: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Nathan Davis',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
