// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_program.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProgramAdapter extends TypeAdapter<UserProgram> {
  @override
  final int typeId = 220;

  @override
  UserProgram read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProgram(
      (fields[0] as List)?.cast<ExerciseTitle>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProgram obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.exercises);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProgramAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
