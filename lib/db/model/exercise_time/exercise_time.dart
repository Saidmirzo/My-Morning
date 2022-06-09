import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class ExerciseTime extends HiveObject {
  ExerciseTime(this.time, {this.title});

  @HiveField(0)
  int time;
  @HiveField(1)
  String title;

  @override
  String toString() {
    return 'ExerciseTime{time: $time, title: $title}';
  }
}
