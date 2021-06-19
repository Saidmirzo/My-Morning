import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'meditation_audio.g.dart';

@HiveType(typeId: 22)
class MeditationAudio extends Equatable {
  @HiveField(0)
  final String url;
  @HiveField(1)
  final String filePath;
  @HiveField(2)
  final Duration duration;
  @HiveField(3)
  final String name;

  MeditationAudio({
    @required this.name,
    @required this.url,
    this.filePath,
    this.duration,
  });

  @override
  List<Object> get props => [name, url, filePath, duration];
}
