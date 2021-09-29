import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class InstrumentsAudioCacheManager {
  static const key = 'instrumentAudioCacheManager';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: Duration(days: 10),
      maxNrOfCacheObjects: 20,
    ),
  );
}
