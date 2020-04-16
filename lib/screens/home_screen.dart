import 'package:colorie/models/log.dart';
import 'package:colorie/providers/log_provider.dart';
import 'package:colorie/providers/member_provider.dart';
import 'package:colorie/screens/day_details_screen.dart';
import 'package:colorie/screens/profile_screen.dart';
import 'package:colorie/widgets/calorie_card.dart';
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
  // get the logs for the last 7 days
  Future<List<Log>> getSevenDayLogHistory(BuildContext context) async {
    final List<DateTime> days = <DateTime>[];
    for (int i = 0; i < 7; i++) {
      days.add(DateTime.now().subtract(Duration(days: i)));
    }
    final List<Log> result = await Provider.of<LogProvider>(context, listen: false).getLogs(days);
    return result;
  }

  List<Widget> _buildLastSixDays(List<Log> logs) {
    return logs.map<Widget>((Log log) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Text(
          '${log.totalCaloriesConsumed()}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<LogProvider, MemberProvider>(
          builder: (BuildContext context, LogProvider logProvider, MemberProvider memberProvider, _) {
            return SingleChildScrollView(
              child: FutureBuilder<List<Log>>(
                builder: (BuildContext context, AsyncSnapshot<List<Log>> snapshot) {
                  List<Log> logs;
                  if (snapshot.connectionState == ConnectionState.done) {
                    logs = snapshot.data;
                    // TODO: WHY ARE YOU NULL??????
                    if (snapshot.data == null) {
                      return Container();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              const Text(
                                'Welcome',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Hero(
                                  tag: 'profile',
                                  child: Material(
                                    child: InkWell(
                                      onTap: () => Navigator.of(context).push<dynamic>(
                                        MaterialPageRoute<dynamic>(builder: (BuildContext context) => ProfileScreen()),
                                      ),
                                      child: const Placeholder(
                                        fallbackHeight: 40,
                                        fallbackWidth: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          child: Hero(
                            tag: 'calorie_card',
                            child: Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                onTap: () => Navigator.of(context).push<dynamic>(
                                  MaterialPageRoute<dynamic>(builder: (BuildContext context) => DayDetailsScreen()),
                                ),
                                child: CalorieCard(
                                  calorieGoal: memberProvider.calorieGoal,
                                  caloriesConsumed: logs[0].totalCaloriesConsumed(),
                                  date: DateTime.now(),
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ..._buildLastSixDays(logs.sublist(1))
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
                future: getSevenDayLogHistory(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
