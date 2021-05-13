// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affirmation_text_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AffirmationTextModelAdapter extends TypeAdapter<AffirmationTextModel> {
  @override
  final int typeId = 156;

  @override
  AffirmationTextModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AffirmationTextModel(
      fields[0] as String,
      isCustom: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AffirmationTextModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._text)
      ..writeByte(1)
      ..write(obj.isCustom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AffirmationTextModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
