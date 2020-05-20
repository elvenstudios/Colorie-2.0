import 'package:colorie/models/calorie_density.dart';
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
class Log extends CalorieDensity {
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

  // total grams consumed
  double get totalGramsConsumed {
    return entries.fold(0, (double previousValue, LogEntry logEntry) => previousValue + logEntry.grams);
  }

  // Calculates calorie density based on calories and grams
  @override
  double calculateDensity() {
    final double result = totalCaloriesConsumed / totalGramsConsumed;
    return result > 0 ? result : 0;
  }
}
