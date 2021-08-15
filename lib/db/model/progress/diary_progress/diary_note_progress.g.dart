// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_note_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryNoteProgressAdapter extends TypeAdapter<DiaryNoteProgress> {
  @override
  final int typeId = 35;

  @override
  DiaryNoteProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryNoteProgress(
      fields[0] as String,
      fields[1] as int,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DiaryNoteProgress obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.note)
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
      other is DiaryNoteProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
