import 'package:colorie/models/log.dart';
import 'package:colorie/providers/member_provider.dart';
import 'package:colorie/theme/brand_colors.dart';
import 'package:colorie/widgets/date_square.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LogDay extends StatelessWidget {
  const LogDay(this.log);
  final Log log;

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProvider>(builder: (BuildContext context, MemberProvider memberProvider, _) {
      return Row(
        children: <Widget>[
          DateSquare(log.date),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${log.totalCaloriesConsumed.ceil()} cal'),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: SizedBox(
                        height: 8,
                        child: LinearProgressIndicator(
                          value: log.totalCaloriesConsumed / memberProvider.calorieGoal,
                          backgroundColor: log.color.withOpacity(.25),
                          valueColor: AlwaysStoppedAnimation<Color>(log.color),
                        ),
                      ),
                    ),
                  ),
                  Text('${log.entries.length} entries'),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
