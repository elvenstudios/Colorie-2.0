import 'package:colorie/models/log.dart';
import 'package:colorie/providers/log_provider.dart';
import 'package:colorie/providers/member_provider.dart';
import 'package:colorie/screens/day_details_screen.dart';
import 'package:colorie/screens/profile_screen.dart';
import 'package:colorie/theme/brand_colors.dart';
import 'package:colorie/widgets/calorie_card.dart';
import 'package:colorie/widgets/log_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///
/// The HomeScreen of our application.
/// Used to display the [Log]
///
class HomeScreen extends StatelessWidget {
  // gets the last 7 days logs, as well as selectedDay log;
  Future<Map<String, dynamic>> getLogData(BuildContext context) async {
    final LogProvider logProvider = Provider.of<LogProvider>(context);

    final List<Log> lastSeven = await logProvider.getSevenDayLogHistory();
    final Log selectedDay = await logProvider.getSelectedDayLog();

    return <String, dynamic>{
      'last_seven': lastSeven,
      'selected_day': selectedDay,
    };
  }

  List<Widget> _buildLastSixDays(List<Log> logs) {
    return logs.map<Widget>((Log log) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16,
        ),
        child: LogDay(log),
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
              child: FutureBuilder<Map<String, dynamic>>(
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  List<Log> lastSevenLogs = <Log>[];
                  Log selectedDayLog;

                  if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                    if (snapshot.data != null) {
                      lastSevenLogs = snapshot.data['last_seven'];
                      selectedDayLog = snapshot.data['selected_day'];
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Colorie',
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
                                      child: Icon(
                                        Icons.account_circle,
                                        size: 48,
                                        color: grey_2,
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
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) => const DayDetailsScreen(),
                                  ),
                                ),
                                child: CalorieCard(
                                  enableDatePicker: true,
                                  log: selectedDayLog,
                                  calorieGoal: memberProvider.calorieGoal,
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (lastSevenLogs.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 24, left: 24.0, bottom: 8),
                            child: Text(
                              'Last 7 Days',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (lastSevenLogs.isNotEmpty) ..._buildLastSixDays(lastSevenLogs.sublist(1))
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                future: getLogData(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
