import 'dart:math';

import 'package:colorie/enums/food_types.dart';
import 'package:colorie/models/log.dart';
import 'package:colorie/models/log_entry.dart';
import 'package:colorie/providers/log_provider.dart';
import 'package:colorie/providers/member_provider.dart';
import 'package:colorie/theme/brand_colors.dart';
import 'package:colorie/widgets/calorie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DayDetailsScreen extends StatefulWidget {
  const DayDetailsScreen();

  @override
  _DayDetailsScreenState createState() => _DayDetailsScreenState();
}

class _DayDetailsScreenState extends State<DayDetailsScreen> {
  List<Widget> _buildLogItems(List<LogEntry> entries) {
    return entries.map<Widget>((LogEntry entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Text(
          '${entry.name}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildBreakfastItems(Log log) {
    return _buildLogItems(log.entries.where((LogEntry entry) => entry.type == FoodType.Breakfast).toList());
  }

  List<Widget> _buildLunchItems(Log log) {
    return _buildLogItems(log.entries.where((LogEntry entry) => entry.type == FoodType.Lunch).toList());
  }

  List<Widget> _buildDinnerItems(Log log) {
    return _buildLogItems(log.entries.where((LogEntry entry) => entry.type == FoodType.Dinner).toList());
  }

  List<Widget> _buildSnackItems(Log log) {
    return _buildLogItems(log.entries.where((LogEntry entry) => entry.type == FoodType.Snack).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LogProvider, MemberProvider>(builder: (
      BuildContext context,
      LogProvider logProvider,
      MemberProvider memberProvider,
      _,
    ) {
      print('---------------------------rebuilt');
      return FutureBuilder<Log>(
          future: logProvider.getSelectedDayLog(),
          builder: (
            BuildContext context,
            AsyncSnapshot<Log> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              final Log log = snapshot.data;
              return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
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
                              log: log,
                              calorieGoal: memberProvider.calorieGoal,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_buildBreakfastItems(log).isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Breakfast',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      if (_buildBreakfastItems(log).isNotEmpty) ..._buildBreakfastItems(log),
                      if (_buildLunchItems(log).isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Lunch',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      if (_buildLunchItems(log).isNotEmpty) ..._buildLunchItems(log),
                      if (_buildDinnerItems(log).isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Dinner',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      if (_buildDinnerItems(log).isNotEmpty) ..._buildDinnerItems(log),
                      if (_buildSnackItems(log).isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Snacks',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      if (_buildSnackItems(log).isNotEmpty) ..._buildSnackItems(log)
                    ],
                  )),
                ),
                bottomNavigationBar: GestureDetector(
                  onTap: () async {
                    final Log today = await logProvider.getSelectedDayLog();

                    today.entries.add(LogEntry(name: 'Apple', calories: 100, grams: 2, type: FoodType.Lunch));
                    logProvider.updateLog(today);
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Center(
                        child: Text(
                      '+ ADD',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ),
                ),
              );
            }
            return Container();
          });
    });
  }
}
