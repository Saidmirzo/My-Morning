// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_name.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseNameAdapter extends TypeAdapter<ExerciseName> {
  @override
  final int typeId = 100;

  @override
  ExerciseName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseName(
      fields[0] as String,
      fields[1] as String,
      fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseName obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
