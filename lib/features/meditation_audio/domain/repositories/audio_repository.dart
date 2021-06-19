import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';

import '../entities/meditation_audio.dart';

abstract class AudioRepository {
  Future<List<MeditationAudio>> getCachedAudioFiles(List<MeditationAudio> map);

  Future<List<dynamic>> getFavoriteAudioFiles();

  Future<MeditationAudio> getAudioFile(MeditationAudio track);
}
