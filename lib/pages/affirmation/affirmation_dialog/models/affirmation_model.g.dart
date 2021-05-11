// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affirmation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AffirmationyModelAdapter extends TypeAdapter<AffirmationyModel> {
  @override
  final int typeId = 154;

  @override
  AffirmationyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AffirmationyModel(
      name: fields[0] as String,
      isCustom: fields[1] as bool,
      affirmations: (fields[2] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AffirmationyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isCustom)
      ..writeByte(2)
      ..write(obj.affirmations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AffirmationyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
