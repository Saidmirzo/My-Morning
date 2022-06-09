import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';

class ExerciseTimeAdapter extends TypeAdapter<ExerciseTime> {
  @override
  final typeId = 3;

  @override
  ExerciseTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseTime(
      fields[0] as int,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseTime obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.title);
  }
}
