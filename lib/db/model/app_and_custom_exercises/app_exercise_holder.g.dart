// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_exercise_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppExerciseHolderAdapter extends TypeAdapter<AppExerciseHolder> {
  @override
  final int typeId = 101;

  @override
  AppExerciseHolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppExerciseHolder(
      (fields[0] as List)?.cast<ExerciseName>(),
    );
  }

  @override
  void write(BinaryWriter writer, AppExerciseHolder obj) {
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
      other is AppExerciseHolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
