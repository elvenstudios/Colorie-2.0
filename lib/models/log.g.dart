// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogAdapter extends TypeAdapter<Log> {
  @override
  final typeId = 0;

  @override
  Log read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Log(
      entries: (fields[0] as List)?.cast<LogEntry>(),
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Log obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.entries)
      ..writeByte(1)
      ..write(obj.date);
  }
}
