import 'package:colorie/models/log_entry.dart';
import 'package:colorie/theme/brand_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

///
/// Used to represent the data for a log, and its given list of [LogEntry] items.
///
///

part 'log.g.dart';

@HiveType(typeId: 0)
class Log {
  Log({@required this.entries, @required this.date});

  @HiveField(0)
  List<LogEntry> entries;

  // date of the log
  @HiveField(1)
  DateTime date;

  // total calories consumed
  double get totalCaloriesConsumed {
    return entries.fold(0, (double previousValue, LogEntry logEntry) => previousValue + logEntry.calories);
  }

  double get totalGramsConsumed {
    return entries.fold(0, (double previousValue, LogEntry logEntry) => previousValue + logEntry.grams);
  }

  // Calculates calorie density based on calories and grams
  double calculateDensity() {
    final double result = totalCaloriesConsumed / totalGramsConsumed;
    return result > 0 ? result : 0;
  }

  // gets the color for the average of all entries in the log
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
