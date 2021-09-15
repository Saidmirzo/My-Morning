import 'package:morningmagic/features/instruments_audio/model/instruments_audio_model.dart';

abstract class InstrumentAudioRepository {
  Future<List<InstrumentAudio>> getCachedAudioFiles(List<InstrumentAudio> map);

  Future<List<InstrumentAudio>> getFavoriteAudioFiles();

  Future<InstrumentAudio> getAudioFile(InstrumentAudio track);
}
