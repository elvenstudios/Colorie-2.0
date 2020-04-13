import 'package:colorie/models/log.dart';
import 'package:colorie/models/log_entry.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

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

  // name of hive box
  final String hiveBox = 'logs';

  // used to go forward and backwards in the log view
  int _dayOffset = 0;

  // set the new offset, notify listeners
  set dayOffset(int value) {
    _dayOffset = value;
    generateLogForDay();
    notifyListeners();
  }

  // get the day offset
  int get dayOffset => _dayOffset;

  // creates a log and stores it into Hive
  Future<void> _createLog(String key, Log value) async {
    final Box<Log> box = await Hive.openBox(hiveBox);
    box.put(key, value);
  }

  // the currently selected log
  Log _selectedLog;

  // sets the selected log
  set selectedLog(Log value) {
    _selectedLog = value;
    notifyListeners();
  }

  // returns the selected log,
  Log get selectedLog {
    return _selectedLog;
  }

  // attempts to find a log for the current selected date
  // if it fails, it generates one
  Future<void> generateLogForDay() async {
    final Box<Log> box = await Hive.openBox(hiveBox);
    Log log = box.get(dateTimeString());
    // if a log exists, return it
    if (log != null) {
      selectedLog = log;
    } else {
      // if no log, create one and return it
      await _createLog(dateTimeString(), Log(entries: <LogEntry>[]));
      log = box.get(dateTimeString());
      selectedLog = log;
    }
  }

  // update the log saved in storage
  Future<void> updateLog() async {
    final Box<Log> box = await Hive.openBox(hiveBox);

    await box.put(dateTimeString(), selectedLog);
    notifyListeners();
  }

  // get a string version of the current day, formatted in a way
  // that Hive (local storage) can use as a key.
  String dateTimeString() {
    // multiply by -1 to avoid confusion when "subtracting" a day.
    final DateTime date = DateTime.now().subtract(Duration(days: dayOffset * -1));
    final String dateString = '${date.month}-${date.day}-${date.year}';

    return dateString;
  }
}
