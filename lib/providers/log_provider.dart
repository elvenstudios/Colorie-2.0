import 'package:colorie/models/log.dart';
import 'package:colorie/models/log_entry.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

///
/// Log Provider.
/// Used for interacting with the [Log]
///
class LogProvider with ChangeNotifier {
  // create a singleton of the provider
  factory LogProvider() {
    return _singleton;
  }
  // constructor for singleton
  LogProvider._();
  static final LogProvider _singleton = LogProvider._();

  // selected day
  DateTime _selectedDay;

  // returns the selected day
  DateTime get selectedDay => _selectedDay ?? DateTime.now();

  // sets the selected day
  set selectedDay(DateTime dateTime) {
    _selectedDay = dateTime;
    notifyListeners();
  }

  // name of hive box
  final String hiveBox = 'logs-3';

  // creates a log at a given day
  Future<void> createLog(DateTime dateTime) async {
    final LazyBox<Log> box = await Hive.openLazyBox(hiveBox);
    await box.put(DateFormat('yMMMMEEEEd').format(dateTime), Log(entries: <LogEntry>[], date: dateTime));
  }

  // given a date time, return the log for that date time
  Future<Log> getLog(DateTime dateTime) async {
    // if none exists, create it

    final LazyBox<Log> box = await Hive.openLazyBox(hiveBox);
    final Log log = await box.get(DateFormat('yMMMMEEEEd').format(dateTime));
    // if a log exists, return it
    if (log != null) {
      return log;
    } else {
      // if no log, create one and return it
      await createLog(dateTime);
      return await box.get(DateFormat('yMMMMEEEEd').format(dateTime));
    }
  }

  // given an array of date times, return the logs for those date times
  Future<List<Log>> getLogs(List<DateTime> dateTimes) async {
    final List<Log> logs = <Log>[];
    // get the log at each datetime, then return the list.
    for (int i = 0; i < dateTimes.length; i++) {
      final Log log = await getLog(dateTimes[i]);
      logs.add(log);
    }
    return logs;
  }

  Future<Log> getSelectedDayLog() async {
    final Log today = await getLog(selectedDay);
    return today;
  }

  // get the logs for the last 7 days
  Future<List<Log>> getSevenDayLogHistory() async {
    final List<DateTime> days = <DateTime>[];
    for (int i = 0; i < 7; i++) {
      days.add(selectedDay.subtract(Duration(days: i)));
    }
    final List<Log> result = await getLogs(days);
    return result;
  }

  // given a log and a date, replace the log at that date
  Future<void> updateLog(Log log) async {
    final LazyBox<Log> box = await Hive.openLazyBox(hiveBox);
    box.put(DateFormat('yMMMMEEEEd').format(log.date), log);
    notifyListeners();
  }

  // selected log will always be the log at the selected dateTime
  Future<Log> get selectedLog async {
    return await getLog(selectedDay);
  }
}
