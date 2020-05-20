import 'package:colorie/enums/food_types.dart';
import 'package:colorie/models/log.dart';
import 'package:colorie/models/log_entry.dart';
import 'package:colorie/providers/log_provider.dart';
import 'package:colorie/providers/member_provider.dart';
import 'package:colorie/theme/brand_colors.dart';
import 'package:colorie/widgets/add_entry.dart';
import 'package:colorie/widgets/calorie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DayDetailsScreen extends StatefulWidget {
  const DayDetailsScreen();

  @override
  _DayDetailsScreenState createState() => _DayDetailsScreenState();
}

class _DayDetailsScreenState extends State<DayDetailsScreen> {
  double safeAreaTopPadding;

  List<Widget> _buildLogItems(BuildContext context, List<LogEntry> entries, Log parentLog) {
    final LogProvider logProvider = Provider.of<LogProvider>(context, listen: false);

    return entries.asMap().entries.map<Widget>((MapEntry<int, LogEntry> entry) {
      return Dismissible(
        key: Key('${entry.value.type.toString()}-${entry.key}-${entry.value.type}'),
        onDismissed: (DismissDirection direction) async {
          await logProvider.deleteEntry(parentLog, entry.value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Text(
            '${entry.value.name}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildBreakfastItems(BuildContext context, Log log) {
    return _buildLogItems(
        context, log.entries.where((LogEntry entry) => entry.type == FoodType.Breakfast).toList(), log);
  }

  List<Widget> _buildLunchItems(BuildContext context, Log log) {
    return _buildLogItems(context, log.entries.where((LogEntry entry) => entry.type == FoodType.Lunch).toList(), log);
  }

  List<Widget> _buildDinnerItems(BuildContext context, Log log) {
    return _buildLogItems(context, log.entries.where((LogEntry entry) => entry.type == FoodType.Dinner).toList(), log);
  }

  List<Widget> _buildSnackItems(BuildContext context, Log log) {
    return _buildLogItems(context, log.entries.where((LogEntry entry) => entry.type == FoodType.Snack).toList(), log);
  }

  void _showBottomSheet(BuildContext context, Log log) {
    showModalBottomSheet<Widget>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AddEntry(safeAreaTopPadding, log);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // modals don't use safe areas well, so we get the safe area padding
    // from this parent widget instead
    safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return Consumer2<LogProvider, MemberProvider>(
      builder: (
        BuildContext context,
        LogProvider logProvider,
        MemberProvider memberProvider,
        _,
      ) {
        return FutureBuilder<Log>(
          future: logProvider.getSelectedDayLog(),
          builder: (
            BuildContext context,
            AsyncSnapshot<Log> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              final Log log = snapshot.data;
              return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: white,
                                ),
                                onTap: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Hero(
                            tag: 'calorie_card',
                            child: Material(
                              type: MaterialType.transparency,
                              child: CalorieCard(
                                log: log,
                                calorieGoal: memberProvider.calorieGoal,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (_buildBreakfastItems(context, log).isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Breakfast',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (_buildBreakfastItems(context, log).isNotEmpty) ..._buildBreakfastItems(context, log),
                        if (_buildLunchItems(context, log).isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Lunch',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (_buildLunchItems(context, log).isNotEmpty) ..._buildLunchItems(context, log),
                        if (_buildDinnerItems(context, log).isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Dinner',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (_buildDinnerItems(context, log).isNotEmpty) ..._buildDinnerItems(context, log),
                        if (_buildSnackItems(context, log).isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Snacks',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (_buildSnackItems(context, log).isNotEmpty) ..._buildSnackItems(context, log)
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: GestureDetector(
                  onTap: () => _showBottomSheet(context, log),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Center(
                      child: Text(
                        '+ ADD',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        );
      },
    );
  }
}
