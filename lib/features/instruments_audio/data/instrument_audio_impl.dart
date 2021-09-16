import 'package:morningmagic/features/instruments_audio/domain/repository/instrument_audio_repository.dart';
import 'package:morningmagic/features/instruments_audio/model/instruments_audio_model.dart';

class InstrumentAudioRepositoryImpl implements InstrumentAudioRepository {
  @override
  Future<InstrumentAudio> getAudioFile(InstrumentAudio track) {
    return Future.value(InstrumentAudio());
  }

  @override
  Future<List<InstrumentAudio>> getCachedAudioFiles(List<InstrumentAudio> map) {
    return Future.value([]);
  }

  @override
  Future<List<InstrumentAudio>> getFavoriteAudioFiles() {
    return Future.value([]);
  }
}
