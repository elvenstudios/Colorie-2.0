import 'package:colorie/theme/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CalorieCard extends StatelessWidget {
  const CalorieCard({
    @required this.borderRadius,
    @required this.date,
    @required this.calorieGoal,
    @required this.caloriesConsumed,
  });

  final BorderRadius borderRadius;
  final DateTime date;
  final int calorieGoal;
  final int caloriesConsumed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2222),
                    );
                  },
                  child: Text(
                    '${DateFormat('MMMMEEEEd').format(date)}',
                    style: const TextStyle(
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '$caloriesConsumed',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      color: white,
                    ),
                  ),
                  const Text(
                    'cal',
                    strutStyle: StrutStyle(
                      fontSize: 32,
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      color: white,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              child: SizedBox(
                height: 8,
                child: LinearProgressIndicator(
                  value: caloriesConsumed / calorieGoal,
                  backgroundColor: green.withOpacity(.25),
                  valueColor: AlwaysStoppedAnimation<Color>(green),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Remaining',
                        style: TextStyle(color: white.withOpacity(.50)),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '${calorieGoal - caloriesConsumed}',
                            style: const TextStyle(color: white, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            ' cal',
                            style: TextStyle(color: white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Goal',
                        style: TextStyle(color: white.withOpacity(.5)),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '$calorieGoal',
                            style: const TextStyle(color: white, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            ' cal',
                            style: TextStyle(color: white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
