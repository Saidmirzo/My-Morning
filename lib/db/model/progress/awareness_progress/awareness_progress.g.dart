// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awareness_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AwarenessProgressAdapter extends TypeAdapter<AwarenessProgress> {
  @override
  final int typeId = 16;

  @override
  AwarenessProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AwarenessProgress(
      fields[0] as int,
    ).._lastUpdateDate = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, AwarenessProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._awareness)
      ..writeByte(1)
      ..write(obj._lastUpdateDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AwarenessProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
