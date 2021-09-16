import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';

import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';

class InstrumentAudioController extends GetxController {
  // Плеер для выбора трека, чтобы не затирать основной
  Map<String, AudioPlayer> audioPlayers = {};
  var audioSourceList = Rx<Map<String, Instrument>>({}).obs;

  Map<String, Instrument> get audioSourse => audioSourceList.value.value;

  RxBool pause = false.obs;

  bool get isPause => pause.value;

  void audioSourceUpdate() => audioSourceList.value.refresh();

  void playAudio(Instrument instrument) {
    if (audioSourse[instrument.instrument.tag] == null) {
      print('add new instrument tag = ${instrument.instrument.tag}');
      audioSourse[instrument.instrument.tag] = instrument;

      audioPlayers[instrument.instrument.tag] = new AudioPlayer()
        ..play(instrument.instrument.url)
        ..setVolume(0.5);

      audioSourceUpdate();
    }
  }

  void stop(Instrument instrument) {
    audioPlayers[instrument.instrument.tag].stop();
    audioPlayers.removeWhere((key, value) => key == instrument.instrument.tag);
    audioSourse.removeWhere((key, value) => key == instrument.instrument.tag);
    audioSourceList.value.refresh();
  }

  void stopAll() {
    for (var i = 0; i < audioPlayers.length; i++) {
      audioPlayers.values.elementAt(i).stop();
      audioPlayers.values.elementAt(i).dispose();
    }
    audioPlayers.clear();
  }

  void setPause(bool value) {
    pause.value = value;
    pause.refresh();
  }

  void playPause() {
    if (!pause.value) {
      for (var i = 0; i < audioPlayers.length; i++)
        audioPlayers.values.elementAt(i).pause();

      setPause(true);
    } else {
      for (var i = 0; i < audioPlayers.length; i++)
        audioPlayers.values.elementAt(i).resume();

      setPause(false);
    }
  }

  void setVolume(double volume, {@required String tag, bool inDialog = false}) {
    print('set volume for $tag = $volume');
    audioSourse[tag].instrumentVolume = volume;
    audioPlayers[tag].setVolume(volume);
    if (inDialog) updateVolumeInTotalList(volume, tag: tag);
  }

  Future updateVolumeInTotalList(double volume, {@required String tag}) async {
    MusicInstrumentControllers _musicInstrumentControllers = Get.find();
    _musicInstrumentControllers.instruments.value.value.forEach((key, value) {
      value.forEach((element) {
        if (element.instrument.tag == tag) element.instrumentVolume = volume;
      });
    });
    _musicInstrumentControllers.instruments.value.refresh();
  }

  bool isPlay({@required String tag}) {
    return audioSourse[tag] != null ? true : false;
  }
}
