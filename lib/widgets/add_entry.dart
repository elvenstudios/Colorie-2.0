import 'package:colorie/enums/food_types.dart';
import 'package:colorie/models/log.dart';
import 'package:colorie/models/log_entry.dart';
import 'package:colorie/providers/log_provider.dart';
import 'package:colorie/widgets/log_entry_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddEntry extends StatefulWidget {
  const AddEntry(this.topPadding, this.log);
  final double topPadding;
  final Log log;

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController gramsController = TextEditingController();

  FoodType value = FoodType.Breakfast;
  bool formComplete = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    caloriesController.dispose();
    gramsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    nameController.addListener(() {
      setState(() {
        formComplete =
            nameController.text.isNotEmpty && caloriesController.text.isNotEmpty && gramsController.text.isNotEmpty;
      });
    });

    caloriesController.addListener(() {
      setState(() {
        formComplete =
            nameController.text.isNotEmpty && caloriesController.text.isNotEmpty && gramsController.text.isNotEmpty;
      });
    });

    gramsController.addListener(() {
      setState(() {
        formComplete =
            nameController.text.isNotEmpty && caloriesController.text.isNotEmpty && gramsController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      builder: (BuildContext context, ScrollController controller) {
        return Consumer<LogProvider>(builder: (BuildContext context, LogProvider logProvider, _) {
          return Container(
            padding: EdgeInsets.only(top: widget.topPadding, left: 16, right: 16),
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LogEntryInput('Name', nameController, TextInputType.text),
                LogEntryInput('Calories', caloriesController, TextInputType.number),
                LogEntryInput('Grams', gramsController, TextInputType.number),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: DropdownButton<FoodType>(
                    iconSize: 0,
                    underline: Container(),
                    value: value,
                    onChanged: (FoodType type) {
                      setState(() {
                        value = type;
                      });
                    },
                    elevation: 0,
                    items: const <DropdownMenuItem<FoodType>>[
                      DropdownMenuItem<FoodType>(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('Breakfast'),
                        ),
                        value: FoodType.Breakfast,
                      ),
                      DropdownMenuItem<FoodType>(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('Lunch'),
                        ),
                        value: FoodType.Lunch,
                      ),
                      DropdownMenuItem<FoodType>(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('Dinner'),
                        ),
                        value: FoodType.Dinner,
                      ),
                      DropdownMenuItem<FoodType>(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('Snack'),
                        ),
                        value: FoodType.Snack,
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                ),
                MaterialButton(
                  height: 48,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  onPressed: formComplete
                      ? () async {
                          widget.log.entries.add(LogEntry(
                            name: nameController.text,
                            calories: int.parse(caloriesController.text).toDouble(),
                            grams: int.parse(gramsController.text).toDouble(),
                            type: value,
                          ));
                          await logProvider.updateLog(widget.log);
                          Navigator.of(context).pop();
                        }
                      : null,
                  color: Theme.of(context).accentColor,
                  child: const Text('DONE'),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
