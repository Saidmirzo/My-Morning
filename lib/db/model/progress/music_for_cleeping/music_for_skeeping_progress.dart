import 'package:hive/hive.dart';

part 'music_for_skeeping_progress.g.dart';

@HiveType(typeId: 24)
class MusicForSleepingProgress {
  MusicForSleepingProgress(this.sec, {this.isSkip = false});

  @HiveField(0)
  int sec;

  @HiveField(1)
  bool isSkip;
}
