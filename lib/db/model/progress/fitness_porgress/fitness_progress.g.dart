// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FitnessProgressAdapter extends TypeAdapter<FitnessProgress> {
  @override
  final int typeId = 14;

  @override
  FitnessProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FitnessProgress(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FitnessProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.seconds)
      ..writeByte(1)
      ..write(obj.exercise);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FitnessProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
