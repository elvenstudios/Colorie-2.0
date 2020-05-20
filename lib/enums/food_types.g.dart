// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodTypeAdapter extends TypeAdapter<FoodType> {
  @override
  final typeId = 2;

  @override
  FoodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FoodType.Breakfast;
      case 1:
        return FoodType.Lunch;
      case 2:
        return FoodType.Dinner;
      case 3:
        return FoodType.Snack;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, FoodType obj) {
    switch (obj) {
      case FoodType.Breakfast:
        writer.writeByte(0);
        break;
      case FoodType.Lunch:
        writer.writeByte(1);
        break;
      case FoodType.Dinner:
        writer.writeByte(2);
        break;
      case FoodType.Snack:
        writer.writeByte(3);
        break;
    }
  }
}
