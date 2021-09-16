import 'package:morningmagic/features/instruments_audio/model/instruments_audio_model.dart';

class Instrument {
  final String name;
  final String instrumentImage;
  final InstrumentAudio instrument;
  double instrumentVolume = 0.5;

  Instrument({this.name, this.instrumentImage, this.instrument});

  static bool compare(Instrument instument1, instument2) {
    return instument1.instrument.tag == instument2.instrument.tag
        ? true
        : false;
  }
}
