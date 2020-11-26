// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseHolderAdapter extends TypeAdapter<ExerciseHolder> {
  @override
  final int typeId = 50;

  @override
  ExerciseHolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseHolder(
      (fields[0] as List)?.cast<ExerciseTitle>(),
      (fields[1] as List)?.cast<ExerciseTitle>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseHolder obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.freshExercises)
      ..writeByte(1)
      ..write(obj.skipExercises);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseHolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
