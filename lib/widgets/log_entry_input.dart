import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LogEntryInput extends StatelessWidget {
  const LogEntryInput(this.labelText, this.controller, this.type);

  final String labelText;
  final TextEditingController controller;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
              fontSize: 16,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Theme.of(context).backgroundColor,
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.only(left: 8),
            child: TextField(
              keyboardType: type,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
