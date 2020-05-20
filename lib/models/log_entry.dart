import 'package:colorie/models/calorie_density.dart';
import 'package:colorie/models/log.dart';
import 'package:colorie/theme/brand_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

///
/// Used to display data about a given food entry.
/// Generally used in the [Log], as a list.
///

part 'log_entry.g.dart';

@HiveType(typeId: 1)
class LogEntry extends CalorieDensity {
  LogEntry({@required this.name, @required this.calories, @required this.grams});

  @HiveField(0)
  String name;

  @HiveField(1)
  double calories;

  @HiveField(2)
  double grams;

  // Calculates calorie density based on calories and grams
  @override
  double calculateDensity() {
    final double result = calories / grams;
    return result > 0 ? result : 0;
  }
}
