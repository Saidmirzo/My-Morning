// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_record_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryRecordProgressAdapter extends TypeAdapter<DiaryRecordProgress> {
  @override
  final int typeId = 45;

  @override
  DiaryRecordProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryRecordProgress(
      fields[0] as String,
      fields[1] as int,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DiaryRecordProgress obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.sec)
      ..writeByte(2)
      ..write(obj.isSkip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryRecordProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
