import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/meditation_audio/data/mediation_audio_cache_manager.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/features/meditation_audio/domain/repositories/audio_repository.dart';

import '../../domain/entities/meditation_audio.dart';

class AudioRepositoryImpl implements AudioRepository {
  @override
  Future<List<MeditationAudio>> getCachedAudioFiles(
      List<MeditationAudio> map) async {
    List<MeditationAudio> audioFiles = [];

    for (var item in map) {
      FileInfo _cachedFile =
          await MeditationAudioCacheManager.instance.getFileFromCache(item.url);
      if (_cachedFile != null)
        audioFiles.add(MeditationAudio(
          name: item.name,
          url: item.url,
          filePath: _cachedFile.file.path,
        ));
    }

    return Future.value(audioFiles);
  }

  @override
  Future<MeditationAudio> getAudioFile(MeditationAudio track) async {
    File file =
        await MeditationAudioCacheManager.instance.getSingleFile(track.url);

    return MeditationAudio(
      name: track.name,
      url: track.url,
      filePath: file.path,
    );
  }

  @override
  Future<List<dynamic>> getFavoriteAudioFiles(bool night) async {
    List<dynamic> audioFiles = await MyDB().getBox().get(night
        ? MyResource.MEDITATION_AUDIO_NIGHT_FAVORITE
        : MyResource.MEDITATION_AUDIO_FAVORITE);
    return Future.value(audioFiles ?? []);
  }
}
