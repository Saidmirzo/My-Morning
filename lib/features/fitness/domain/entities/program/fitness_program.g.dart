// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_program.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FitnessProgramAdapter extends TypeAdapter<FitnessProgram> {
  @override
  final int typeId = 18;

  @override
  FitnessProgram read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FitnessProgram(
      name: fields[0] as String,
      isCreatedByUser: fields[1] as bool,
      exercises: (fields[2] as List)?.cast<FitnessExercise>(),
    );
  }

  @override
  void write(BinaryWriter writer, FitnessProgram obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isCreatedByUser)
      ..writeByte(2)
      ..write(obj.exercises);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FitnessProgramAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
