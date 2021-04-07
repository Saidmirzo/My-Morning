import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/meditation_audio/data/mediation_audio_cache_manager.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  @override
  Future<List<MeditationAudio>> getCachedAudioFiles(
      Map<String, String> map) async {
    List<MeditationAudio> audioFiles = [];

    for (String trackKey in map.keys) {
      FileInfo _cachedFile =
          await MeditationAudioCacheManager.instance.getFileFromCache(trackKey);
      if (_cachedFile != null)
        audioFiles.add(MeditationAudio(
          id: trackKey,
          url: map[trackKey],
          filePath: _cachedFile.file.path,
        ));
    }

    return Future.value(audioFiles);
  }

  @override
  Future<MeditationAudio> getAudioFile(String key, Map source) async {
    String _url = source[key];
    File file = await MeditationAudioCacheManager.instance
        .getSingleFile(_url, key: key);

    return MeditationAudio(
      id: key,
      url: _url,
      filePath: file.path,
    );
  }

  @override
  Future<List<dynamic>> getFavoriteAudioFiles() async {
    List<dynamic> audioFiles =
        await MyDB().getBox().get(MyResource.MEDITATION_AUDIO_FAVORITE);
    return Future.value(audioFiles ?? []);
  }
}
