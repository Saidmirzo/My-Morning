import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:morningmagic/features/instruments_audio/data/instrument_audio_data.dart';
import 'package:morningmagic/pages/music_instrument/components/snackbar.dart';
import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';

class MusicInstrumentControllers extends GetxController {
  var instruments = Rx<Map<String, List<Instrument>>>({}).obs;

  //var playList = Rx<List<Instrument>>([]).obs;

  MusicInstrumentControllers() {
    _initInstrumentList();
  }

  void _initInstrumentList() {
    InstrumentAudioData audioData = InstrumentAudioData();

    instruments.value.value['music_instrument_title'.tr] = [];
    for (var i = 1; i <= 8; i++) {
      instruments.value.value['music_instrument_title'.tr].add(Instrument(
          instrument: audioData.musicInstruments[i - 1],
          name: 'instrument_$i'.tr,
          instrumentImage: '${SvgAssets.instrumentalPath}/instrument_$i.svg'));
    }

    instruments.value.value['music_instrument_places'.tr] = [];
    for (var i = 1; i <= 7; i++) {
      instruments.value.value['music_instrument_places'.tr].add(Instrument(
          instrument: audioData.placeInstruments[i - 1],
          name: 'place_$i'.tr,
          instrumentImage: '${SvgAssets.instrumentalPath}/place_$i.svg'));
    }

    instruments.value.value['music_instrument_other'.tr] = [];
    for (var i = 1; i <= 6; i++) {
      instruments.value.value['music_instrument_other'.tr].add(Instrument(
          instrument: audioData.otherInstruments[i - 1],
          name: 'other_$i'.tr,
          instrumentImage: '${SvgAssets.instrumentalPath}/other_$i.svg'));
    }

    instruments.value.value['music_instrument_sound_of_nature'.tr] = [];
    for (var i = 1; i <= 19; i++) {
      instruments.value.value['music_instrument_sound_of_nature'.tr].add(
          Instrument(
              instrument: audioData.natureInstruments[i - 1],
              name: 'nature_$i'.tr,
              instrumentImage: '${SvgAssets.instrumentalPath}/nature_$i.svg'));
    }

    instruments.value.value['music_instrument_living_creatures'.tr] = [];
    for (var i = 1; i <= 12; i++) {
      instruments.value.value['music_instrument_living_creatures'.tr].add(
          Instrument(
              instrument: audioData.creaturesInstruments[i - 1],
              name: 'creatures_$i'.tr,
              instrumentImage:
                  '${SvgAssets.instrumentalPath}/creatures_$i.svg'));
    }
  }

  /* void addPlay(Instrument instrument) {
    if (!isPlay(instrument)) {
      if (playList.value.value.length < 10) {
        playList.value.value.add(instrument);
        playList.value.refresh();
      } else
        showErrorDialog('10 из 10');
    }
  } */

  /*void removePlayList(Instrument instrument) {
    playList.value.value.remove(instrument);
    playList.value.refresh();
  }

  bool isPlay(Instrument instrumrnt) {
    return playList.value.value
                .where((element) => element.name == instrumrnt.name)
                .length >
            0
        ? true
        : false;
  }*/
}
