import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/mediation_audio_cache_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  @override
  Future<List<MeditationAudio>> getCachedAudioFiles() async {
    List<MeditationAudio> audioFiles = [];
    final _trackSource = MeditationAudioData.audioSources;

    for (String trackKey in _trackSource.keys) {
      FileInfo _cachedFile =
          await MeditationAudioCacheManager.instance.getFileFromCache(trackKey);
      if (_cachedFile != null)
        audioFiles.add(MeditationAudio(
          id: trackKey,
          url: _trackSource[trackKey],
          file: _cachedFile.file,
        ));
    }

    return Future.value(audioFiles);
  }

  @override
  Future<MeditationAudio> getAudioFile(String key) async {
    String _url = MeditationAudioData.audioSources[key];
    File file = await MeditationAudioCacheManager.instance
        .getSingleFile(_url, key: key);

    return MeditationAudio(
      id: key,
      url: _url,
      file: file,
    );
  }
}
