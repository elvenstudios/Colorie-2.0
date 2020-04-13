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
  Log({@required this.entries});

  @HiveField(0)
  List<LogEntry> entries;
}
