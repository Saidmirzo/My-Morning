// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affirmation_cat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AffirmationCategoryModelAdapter
    extends TypeAdapter<AffirmationCategoryModel> {
  @override
  final int typeId = 154;

  @override
  AffirmationCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AffirmationCategoryModel(
      fields[0] as String,
      isCustom: fields[1] as bool,
      affirmations: (fields[2] as List)?.cast<AffirmationTextModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AffirmationCategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._name)
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
      other is AffirmationCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
