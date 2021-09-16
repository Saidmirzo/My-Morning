import 'package:flutter_cache_manager/file.dart';
import 'package:morningmagic/features/instruments_audio/data/instruments_cach_audio.dart';
import 'package:morningmagic/features/instruments_audio/domain/repository/instrument_audio_repository.dart';
import 'package:morningmagic/features/instruments_audio/model/instruments_audio_model.dart';

import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';

class InstrumentAudioRepositoryImpl implements InstrumentAudioRepository {
  @override
  Future<Instrument> getAudioFile(Instrument instrument) async {
    File file = await InstrumentsAudioCacheManager.instance
        .getSingleFile(instrument.instrument.url);

    return Instrument(
      name: instrument.name,
      instrumentImage: instrument.instrumentImage,
      instrument: InstrumentAudio(
          tag: instrument.instrument.tag,
          filePath: file.path,
          url: instrument.instrument.url),
    );
  }

  @override
  Future<List<Instrument>> getCachedAudioFiles(List<Instrument> map) {
    return Future.value([]);
  }

  @override
  Future<List<Instrument>> getFavoriteAudioFiles() {
    return Future.value([]);
  }
}
