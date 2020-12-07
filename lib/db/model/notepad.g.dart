// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notepad.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotepadAdapter extends TypeAdapter<Notepad> {
  @override
  final int typeId = 150;

  @override
  Notepad read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notepad(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Notepad obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotepadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
