import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'meditation_progress.g.dart';

@HiveType(typeId: 11)
class MeditationProgress extends Exercise {
  MeditationProgress(this.sec, {this.isSkip = false});

  @HiveField(0)
  int sec;

  @HiveField(1)
  bool isSkip;
}
