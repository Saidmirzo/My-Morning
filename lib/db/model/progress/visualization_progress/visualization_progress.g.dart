// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visualization_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisualizationProgressAdapter extends TypeAdapter<VisualizationProgress> {
  @override
  final int typeId = 17;

  @override
  VisualizationProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VisualizationProgress(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VisualizationProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.seconds)
      ..writeByte(1)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisualizationProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
