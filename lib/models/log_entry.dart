import 'package:colorie/enums/food_types.dart';
import 'package:colorie/models/calorie_density.dart';
import 'package:colorie/models/log.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

///
/// Used to display data about a given food entry.
/// Generally used in the [Log], as a list.
///

part 'log_entry.g.dart';

@HiveType(typeId: 1)
class LogEntry extends CalorieDensity {
  LogEntry({@required this.name, @required this.calories, @required this.grams, @required this.type});

  @HiveField(0)
  String name;

  @HiveField(1)
  double calories;

  @HiveField(2)
  double grams;

  @HiveField(3)
  FoodType type;

  // Calculates calorie density based on calories and grams
  @override
  double calculateDensity() {
    final double result = calories / grams;
    return result > 0 ? result : 0;
  }
}
