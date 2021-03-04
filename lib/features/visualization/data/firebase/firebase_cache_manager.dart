import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'firebase_http_file_service.dart';

class FirebaseCacheManager extends CacheManager {
  static const key = 'firebaseCache';

  static FirebaseCacheManager _instance;

  factory FirebaseCacheManager() {
    _instance ??= FirebaseCacheManager._();
    return _instance;
  }

  FirebaseCacheManager._()
      : super(Config(key, fileService: FirebaseHttpFileService()));
}
