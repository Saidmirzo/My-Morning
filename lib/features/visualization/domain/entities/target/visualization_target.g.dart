// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visualization_target.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisualizationTargetAdapter extends TypeAdapter<VisualizationTarget> {
  @override
  final int typeId = 21;

  @override
  VisualizationTarget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VisualizationTarget(
      id: fields[0] as int,
      isCustom: fields[1] as bool,
      title: fields[2] as String,
      coverAssetPath: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VisualizationTarget obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isCustom)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.coverAssetPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisualizationTargetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
