// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeditationProgressAdapter extends TypeAdapter<MeditationProgress> {
  @override
  final int typeId = 11;

  @override
  MeditationProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeditationProgress(
      fields[0] as int,
      isSkip: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MeditationProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sec)
      ..writeByte(1)
      ..write(obj.isSkip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeditationProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
