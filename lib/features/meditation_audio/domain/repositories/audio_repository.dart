import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';

abstract class AudioRepository {
  Future<List<MeditationAudio>> getCachedAudioFiles(Map<String, String> map);

  Future<List<dynamic>> getFavoriteAudioFiles();

  Future<MeditationAudio> getAudioFile(String key, Map source);
}
