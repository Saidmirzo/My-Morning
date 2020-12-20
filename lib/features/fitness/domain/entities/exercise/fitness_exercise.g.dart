// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_exercise.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FitnessExerciseAdapter extends TypeAdapter<FitnessExercise> {
  @override
  final int typeId = 19;

  @override
  FitnessExercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FitnessExercise(
      fields[0] as String,
      fields[1] as String,
      isCreatedByUser: fields[2] as bool,
      audioRes: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FitnessExercise obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._description)
      ..writeByte(2)
      ..write(obj.isCreatedByUser)
      ..writeByte(3)
      ..write(obj.audioRes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FitnessExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
