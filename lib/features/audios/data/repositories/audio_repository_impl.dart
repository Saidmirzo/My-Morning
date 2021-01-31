import 'dart:io';

import 'package:morningmagic/features/audios/data/audio_cache_manager.dart';
import 'package:morningmagic/features/audios/data/audio_data.dart';
import 'package:morningmagic/features/audios/domain/entities/audio_file.dart';
import 'package:morningmagic/features/audios/domain/repositories/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  @override
  Future<AudioFile> getAudioFile(String key) async {
    String _url = AudioData.audioSources[key];
    File file = await AudioCacheManager.instance.getSingleFile(_url);

    return AudioFile(url: _url, file: file, title: key);
  }
}
