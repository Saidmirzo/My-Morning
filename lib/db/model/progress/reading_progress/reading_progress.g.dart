// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReadingProgressAdapter extends TypeAdapter<ReadingProgress> {
  @override
  final int typeId = 15;

  @override
  ReadingProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReadingProgress(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      isSkip: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ReadingProgress obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.book)
      ..writeByte(1)
      ..write(obj.pages)
      ..writeByte(2)
      ..write(obj.sec)
      ..writeByte(3)
      ..write(obj.isSkip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
