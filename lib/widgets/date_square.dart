import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DateSquare extends StatelessWidget {
  const DateSquare(this.date);
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    String day = date.toLocal().day.toString();
    if (day.length == 1) {
      day = '0$day';
    }

    return Center(
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              day,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${DateFormat('MMM').format(date)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
