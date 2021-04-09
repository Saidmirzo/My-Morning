// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_audio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeditationAudioAdapter extends TypeAdapter<MeditationAudio> {
  @override
  final int typeId = 22;

  @override
  MeditationAudio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeditationAudio(
      id: fields[0] as String,
      url: fields[1] as String,
      filePath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MeditationAudio obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.filePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeditationAudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
