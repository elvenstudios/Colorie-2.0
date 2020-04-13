import 'package:colorie/models/log.dart';
import 'package:colorie/models/log_entry.dart';
import 'package:colorie/providers/log_provider.dart';
import 'package:colorie/screens/home_screen.dart';
import 'package:colorie/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // set up local storage
  await Hive.initFlutter();
  Hive.registerAdapter(LogAdapter());
  Hive.registerAdapter(LogEntryAdapter());

  // generate the log for the given day
  // so we have something to show when the app builds
  await LogProvider().generateLogForDay();

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
        ChangeNotifierProvider<LogProvider>(
          create: (_) => LogProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Colorie',
        theme: theme,
        home: HomeScreen(),
      ),
    );
  }
}
