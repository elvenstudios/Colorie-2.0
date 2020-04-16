// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogEntryAdapter extends TypeAdapter<LogEntry> {
  @override
  final typeId = 1;

  @override
  LogEntry read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogEntry(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LogEntry obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }
}
