import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:morningmagic/features/instruments_audio/data/instrument_audio_impl.dart';
import 'package:morningmagic/pages/music_instrument/components/snackbar.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';
import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/services/timer_service.dart';

class InstrumentAudioController extends GetxController {
  InstrumentAudioRepositoryImpl repo = InstrumentAudioRepositoryImpl();

  Map<String, AudioPlayer> audioPlayers = {};
  var audioSourceList = Rx<Map<String, Instrument>>({}).obs;

  Map<String, Instrument> get audioSourse => audioSourceList.value.value;

  RxBool pause = false.obs;

  //сохраняем таймер при возвращении на панель инструментов
  TimerService timerService;

  bool get isPause => pause.value;

  var isLoading = Rx<Instrument>(null).obs;

  void audioSourceUpdate() => audioSourceList.value.refresh();

  @override
  void dispose() {
    stopAll();
    super.dispose();
  }

  Future<void> playAudio(Instrument instrument) async {
    try {
      if (audioSourse.length == 10) {
        //showErrorDialog('10 из 10');
        return;
      }

      stopAll();

      if (audioSourse[instrument.instrument.tag] == null) {
        print('add new instrument tag = ${instrument.instrument.tag}');
        audioSourse[instrument.instrument.tag] = instrument;
        isLoading.value.value = instrument;
        Instrument cachInstrument = await cacheAudioFile(instrument);
        audioPlayers[instrument.instrument.tag] = AudioPlayer();
        await audioPlayers[instrument.instrument.tag]
            .setFilePath(cachInstrument.instrument.filePath);
        await audioPlayers[instrument.instrument.tag].setVolume(0.5);
        await audioPlayers[instrument.instrument.tag].setLoopMode(LoopMode.one);

        audioSourceUpdate();
        isLoading.value.value = null;

        _playAll();
      } else {
        await stop(instrument);
      }
    } catch (e) {
      print('failed to load the reproduction tool: $e');
    }
  }

  Future<void> stop(Instrument instrument) async {
    await audioPlayers[instrument.instrument.tag].stop();
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
    audioSourse.clear();
  }

  void setPause(bool value) {
    pause.value = value;
    pause.refresh();
  }

  void _playAll() {
    for (var i = 0; i < audioPlayers.length; i++) {
      audioPlayers.values.elementAt(i).play();
    }

    setPause(false);
  }

  void playPause() {
    if (!pause.value) {
      for (var i = 0; i < audioPlayers.length; i++) {
        audioPlayers.values.elementAt(i).pause();
      }

      setPause(true);
    } else {
      for (var i = 0; i < audioPlayers.length; i++) {
        audioPlayers.values.elementAt(i).play();
      }

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
      for (var element in value) {
        if (element.instrument.tag == tag) element.instrumentVolume = volume;
      }
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
        backgroundColor: AppColors.violet.withOpacity(0.5),
        titleText: snackText(''),
        messageText: snackText(text));
  }
}
