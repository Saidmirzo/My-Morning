// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_record_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabularyRecordProgressAdapter
    extends TypeAdapter<VocabularyRecordProgress> {
  @override
  final int typeId = 45;

  @override
  VocabularyRecordProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabularyRecordProgress(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VocabularyRecordProgress obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabularyRecordProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
