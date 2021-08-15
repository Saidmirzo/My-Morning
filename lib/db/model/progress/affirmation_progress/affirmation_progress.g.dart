// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affirmation_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AffirmationProgressAdapter extends TypeAdapter<AffirmationProgress> {
  @override
  final int typeId = 10;

  @override
  AffirmationProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AffirmationProgress(
      fields[0] as int,
      fields[1] as String,
      isSkip: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AffirmationProgress obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sec)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.isSkip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AffirmationProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
