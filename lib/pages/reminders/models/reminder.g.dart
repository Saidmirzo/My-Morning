// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderModelAdapter extends TypeAdapter<ReminderModel> {
  @override
  final int typeId = 155;

  @override
  ReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderModel(
      id: fields[0] as int,
      date: fields[1] as DateTime,
      text: fields[2] as String,
      isActive: fields[3] as bool,
      activeDays: (fields[4] as List)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.activeDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
