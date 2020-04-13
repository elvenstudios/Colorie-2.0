// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogAdapter extends TypeAdapter<Log> {
  @override
  final int typeId = 0;

  @override
  Log read(BinaryReader reader) {
    final int numOfFields = reader.readByte();
    final Map<int, dynamic> fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Log(
      // ignore: avoid_as
      entries: (fields[0] as List<dynamic>)?.cast<LogEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, Log obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.entries);
  }
}
