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
      name: fields[3] as String,
      url: fields[0] as String,
      filePath: fields[1] as String,
      duration: fields[2] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, MeditationAudio obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.filePath)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.name);
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
