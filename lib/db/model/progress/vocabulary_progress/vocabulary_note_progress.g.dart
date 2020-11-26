// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_note_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabularyNoteProgressAdapter
    extends TypeAdapter<VocabularyNoteProgress> {
  @override
  final int typeId = 35;

  @override
  VocabularyNoteProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabularyNoteProgress(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VocabularyNoteProgress obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabularyNoteProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
