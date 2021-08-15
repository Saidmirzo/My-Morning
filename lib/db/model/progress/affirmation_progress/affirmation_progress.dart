import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'affirmation_progress.g.dart';

@HiveType(typeId: 10)
class AffirmationProgress extends Exercise {
  AffirmationProgress(this.sec, this.text, {this.isSkip = false});

  @HiveField(0)
  int sec;

  @HiveField(1)
  String text;

  @HiveField(2)
  bool isSkip;
}
