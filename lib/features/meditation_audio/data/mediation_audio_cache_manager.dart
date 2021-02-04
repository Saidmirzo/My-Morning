import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MeditationAudioCacheManager {
  static const key = 'audioCacheManager';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: Duration(days: 10),
      maxNrOfCacheObjects: 20,
    ),
  );
}
