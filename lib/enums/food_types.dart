import 'package:hive/hive.dart';

part 'food_types.g.dart';

@HiveType(typeId: 2)
enum FoodType {
  @HiveField(0)
  Breakfast,

  @HiveField(1)
  Lunch,

  @HiveField(2)
  Dinner,

  @HiveField(3)
  Snack,
}
