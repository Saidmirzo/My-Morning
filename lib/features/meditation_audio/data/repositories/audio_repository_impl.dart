import 'dart:io';

import 'package:morningmagic/features/meditation_audio/data/audio_cache_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/audio_file.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  @override
  Future<AudioFile> getAudioFile(String key) async {
    String _url = MeditationAudioData.audioSources[key];
    File file = await AudioCacheManager.instance.getSingleFile(_url);

    return AudioFile(
      id: key,
      url: _url,
      file: file,
    );
  }
}
