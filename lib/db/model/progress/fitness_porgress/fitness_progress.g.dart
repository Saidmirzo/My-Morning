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
      fields[2] as String,
      fields[4] as String,
      isSkip: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FitnessProgress obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sec)
      ..writeByte(1)
      ..write(obj.progName)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.isSkip)
      ..writeByte(4)
      ..write(obj.practicId);
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
