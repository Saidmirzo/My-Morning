import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'meditation_audio.g.dart';

@HiveType(typeId: 22)
class MeditationAudio extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final String filePath;

  MeditationAudio({
    @required this.id,
    @required this.url,
    @required this.filePath,
  });

  @override
  List<Object> get props => [url, id, filePath];
}
