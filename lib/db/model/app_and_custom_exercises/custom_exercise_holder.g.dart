// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_exercise_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomExerciseHolderAdapter extends TypeAdapter<CustomExerciseHolder> {
  @override
  final int typeId = 102;

  @override
  CustomExerciseHolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomExerciseHolder(
      (fields[0] as List)?.cast<ExerciseName>(),
    );
  }

  @override
  void write(BinaryWriter writer, CustomExerciseHolder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomExerciseHolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
