import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/progress/exercise/exercise.dart';

part 'visualization_progress.g.dart';

@HiveType(typeId: 17)
class VisualizationProgress extends Exercise {
  VisualizationProgress(this.sec, this.text, {this.isSkip = false});

  @HiveField(0)
  int sec;

  @HiveField(1)
  String text;

  @HiveField(2)
  bool isSkip;
}
