import 'package:colorie/models/log.dart';
import 'package:colorie/models/log_entry.dart';
import 'package:colorie/providers/log_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///
/// The HomeScreen of our application.
/// Used to display the [Log]
///
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LogProvider>(
        builder: (BuildContext context, LogProvider logProvider, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Showing for: ${logProvider.dateTimeString()}'),
                FlatButton(
                  onPressed: () async {
                    // this is an example, adding an entry to the log, then updating the stored log.
                    logProvider.selectedLog.entries.add(LogEntry(name: 'test 2'));
                    // must call updateLog to see the updates on the UI.
                    logProvider.updateLog();
                  },
                  child: const Text('add to log'),
                ),
                FlatButton(
                  onPressed: () => logProvider.dayOffset--,
                  child: const Text('<--'),
                ),
                FlatButton(
                  onPressed: () => logProvider.dayOffset++,
                  child: const Text('-->'),
                ),
                ...logProvider.selectedLog.entries.map((LogEntry entry) => Text(entry.name)).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
