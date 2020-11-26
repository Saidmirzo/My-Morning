// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayHolderAdapter extends TypeAdapter<DayHolder> {
  @override
  final int typeId = 12;

  @override
  DayHolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayHolder(
      (fields[0] as List)?.cast<Day>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayHolder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listOfDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayHolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
