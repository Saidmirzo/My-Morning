import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/features/instruments_audio/data/instrument_audio_impl.dart';
import 'package:morningmagic/pages/music_instrument/components/snackbar.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';

import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';
import 'package:morningmagic/resources/colors.dart';

class InstrumentAudioController extends GetxController {
  InstrumentAudioRepositoryImpl repo = InstrumentAudioRepositoryImpl();

  Map<String, AudioPlayer> audioPlayers = {};
  var audioSourceList = Rx<Map<String, Instrument>>({}).obs;

  Map<String, Instrument> get audioSourse => audioSourceList.value.value;

  RxBool pause = false.obs;

  bool get isPause => pause.value;

  void audioSourceUpdate() => audioSourceList.value.refresh();

  @override
  void dispose() {
    stopAll();
    super.dispose();
  }

  void playAudio(Instrument instrument) async {
    try {
      if (audioSourse.length == 10) {
        showErrorDialog('10 из 10');
        return;
      }

      if (audioSourse[instrument.instrument.tag] == null) {
        print('add new instrument tag = ${instrument.instrument.tag}');
        audioSourse[instrument.instrument.tag] = instrument;
        Instrument cachInstrument = await cacheAudioFile(instrument);
        audioPlayers[instrument.instrument.tag] = new AudioPlayer()
          ..setFilePath(cachInstrument.instrument.filePath)
          ..setVolume(0.5)
          ..setLoopMode(LoopMode.one)
          ..play();

        audioSourceUpdate();
        //update state pause btn
        pause.refresh();
      } else
        stop(instrument);
    } catch (e) {
      print('failed to load the reproduction tool: $e');
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
        audioPlayers.values.elementAt(i).play();

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

  Future<Instrument> cacheAudioFile(Instrument instrument) async {
    try {
      Instrument audioFile = await repo.getAudioFile(instrument);
      audioSourse[instrument.instrument.tag] = audioFile;
      return audioFile;
    } catch (e) {
      print('cacheAudioFile: $e');
    }
    return null;
  }

  void showErrorDialog(String text) {
    Get.snackbar('', text,
        backgroundColor: AppColors.VIOLET.withOpacity(0.5),
        titleText: snackText(''),
        messageText: snackText(text));
  }
}
