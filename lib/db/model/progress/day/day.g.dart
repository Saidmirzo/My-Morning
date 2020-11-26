// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayAdapter extends TypeAdapter<Day> {
  @override
  final int typeId = 13;

  @override
  Day read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Day(
      fields[0] as String,
      fields[1] as AffirmationProgress,
      fields[2] as MeditationProgress,
      fields[3] as FitnessProgress,
      fields[4] as ReadingProgress,
      fields[5] as VocabularyNoteProgress,
      fields[6] as VocabularyRecordProgress,
      fields[7] as VisualizationProgress,
    );
  }

  @override
  void write(BinaryWriter writer, Day obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.affirmationProgress)
      ..writeByte(2)
      ..write(obj.meditationProgress)
      ..writeByte(3)
      ..write(obj.fitnessProgress)
      ..writeByte(4)
      ..write(obj.readingProgress)
      ..writeByte(5)
      ..write(obj.vocabularyNoteProgress)
      ..writeByte(6)
      ..write(obj.vocabularyRecordProgress)
      ..writeByte(7)
      ..write(obj.visualizationProgress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
