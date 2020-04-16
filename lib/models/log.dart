import 'package:colorie/models/log_entry.dart';
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
  int totalCaloriesConsumed() {
    return 20; // TODO: calculate
  }
}
