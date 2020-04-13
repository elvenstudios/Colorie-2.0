import 'package:colorie/models/log.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

///
/// Used to display data about a given food entry.
/// Generally used in the [Log], as a list.
///

part 'log_entry.g.dart';

@HiveType(typeId: 1)
class LogEntry {
  LogEntry({@required this.name});

  @HiveField(0)
  String name;
}
