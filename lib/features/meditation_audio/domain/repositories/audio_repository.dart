import 'package:morningmagic/features/meditation_audio/domain/entities/audio_file.dart';

abstract class AudioRepository {
  Future<AudioFile> getAudioFile(String key);
}
