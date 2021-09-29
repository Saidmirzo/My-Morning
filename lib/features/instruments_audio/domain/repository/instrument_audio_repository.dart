import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';

abstract class InstrumentAudioRepository {
  Future<List<Instrument>> getCachedAudioFiles(List<Instrument> map);

  Future<List<Instrument>> getFavoriteAudioFiles();

  Future<Instrument> getAudioFile(Instrument track);
}
