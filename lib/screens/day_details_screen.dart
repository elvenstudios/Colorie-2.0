import 'package:colorie/providers/log_provider.dart';
import 'package:colorie/theme/brand_colors.dart';
import 'package:colorie/widgets/calorie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DayDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LogProvider>(builder: (BuildContext context, LogProvider logProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        color: white,
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Container(
                child: Hero(
                  tag: 'calorie_card',
                  child: Material(
                    type: MaterialType.transparency,
                    child: CalorieCard(
                      calorieGoal: 1500,
                      caloriesConsumed: 700,
                      date: logProvider.selectedDay,
                      borderRadius:
                          const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Breakfast',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
