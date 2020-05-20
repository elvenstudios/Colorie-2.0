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
class LogEntry {
  LogEntry({@required this.name, @required this.calories, @required this.grams});

  @HiveField(0)
  String name;

  @HiveField(1)
  double calories;

  @HiveField(2)
  double grams;

  // Calculates calorie density based on calories and grams
  double calculateDensity() {
    final double result = calories / grams;
    return result > 0 ? result : 0;
  }

  // Calculates a color code based on a given calorie density
  Color get color {
    final double density = calculateDensity();
    if (density <= 0.6) {
      return green;
    }

    if (density <= 1.5) {
      return yellow;
    }

    if (density <= 3.8) {
      return orange;
    }

    return red;
  }
}
