import 'package:morningmagic/features/audios/domain/entities/audio_file.dart';

abstract class AudioRepository {
  Future<AudioFile> getAudioFile(String key);
}
