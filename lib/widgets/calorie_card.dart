import 'package:colorie/models/log.dart';
import 'package:colorie/models/log_entry.dart';
import 'package:colorie/providers/log_provider.dart';
import 'package:colorie/theme/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalorieCard extends StatelessWidget {
  const CalorieCard({
    @required this.borderRadius,
    @required this.calorieGoal,
    @required this.log,
  });

  final BorderRadius borderRadius;
  final double calorieGoal;
  final Log log;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Consumer<LogProvider>(builder: (BuildContext context, LogProvider logProvider, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final DateTime selectedDate = await showDatePicker(
                        context: context,
                        initialDate: log.date,
                        firstDate: DateTime(2019),
                        lastDate: DateTime(2222),
                      );
                      logProvider.selectedDay = selectedDate;
                    },
                    child: Text(
                      '${DateFormat('MMMMEEEEd').format(log.date)}',
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
                      '${log.totalCaloriesConsumed.ceil()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                        color: white,
                      ),
                    ),
                    const Text(
                      ' cal',
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
                    value: log.totalCaloriesConsumed / calorieGoal,
                    backgroundColor: log.color.withOpacity(.25),
                    valueColor: AlwaysStoppedAnimation<Color>(log.color),
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
                              '${(calorieGoal - log.totalCaloriesConsumed).ceil()}',
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
                              '${calorieGoal.ceil()}',
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
        );
      }),
    );
  }
}
