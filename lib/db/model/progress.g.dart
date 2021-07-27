// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressModelAdapter extends TypeAdapter<ProgressModel> {
  @override
  final int typeId = 151;

  @override
  ProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressModel(
      count_of_session: (fields[0] as Map)?.cast<DateTime, int>(),
      minutes_of_awarenes: (fields[1] as Map)?.cast<DateTime, int>(),
      count_of_complete_session: (fields[2] as Map)?.cast<DateTime, int>(),
      percent_of_awareness: (fields[3] as Map)?.cast<DateTime, double>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProgressModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.count_of_session)
      ..writeByte(1)
      ..write(obj.minutes_of_awarenes)
      ..writeByte(2)
      ..write(obj.count_of_complete_session)
      ..writeByte(3)
      ..write(obj.percent_of_awareness);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
