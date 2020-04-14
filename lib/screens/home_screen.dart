import 'package:colorie/models/log.dart';
import 'package:colorie/providers/log_provider.dart';
import 'package:colorie/screens/day_details_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LogProvider>(
          builder: (BuildContext context, LogProvider logProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        'Welcome',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Placeholder(
                          fallbackHeight: 40,
                          fallbackWidth: 40,
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
                        child: const CalorieCard(
                          calorieGoal: 1500,
                          caloriesConsumed: 700,
                          date: 'April 4th',
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                  child: Text(
                    'DAILY LOG',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
