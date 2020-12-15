// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_programs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FitnessProgramsModelAdapter extends TypeAdapter<FitnessProgramsModel> {
  @override
  final int typeId = 18;

  @override
  FitnessProgramsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FitnessProgramsModel(
      programs: (fields[0] as List)?.cast<FitnessProgram>(),
    );
  }

  @override
  void write(BinaryWriter writer, FitnessProgramsModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.programs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FitnessProgramsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
