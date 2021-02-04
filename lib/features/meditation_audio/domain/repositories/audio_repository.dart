import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';

abstract class AudioRepository {
  Future<List<MeditationAudio>> getCachedAudioFiles();

  Future<MeditationAudio> getAudioFile(String key);
}
