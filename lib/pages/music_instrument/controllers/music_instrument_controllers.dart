import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:morningmagic/pages/music_instrument/music_instrument_page.dart';

class MusicInstrumentControllers extends GetxController {
  List<Instrument> instrumentse = [];
  var instruments = Rx<Map<String, List<Instrument>>>({}).obs;

  var playList = Rx<List<Instrument>>([]).obs;

  MusicInstrumentControllers() {
    _initSoundList();
  }

  void _initSoundList() {
    instruments.value.value['music_instrument_title'.tr] = [];
    for (var i = 1; i <= 8; i++) {
      instruments.value.value['music_instrument_title'.tr]
          .add(Instrument(name: 'instrument_$i'.tr));
    }
    instruments.value.value['music_instrument_places'.tr] = [];
    for (var i = 1; i <= 7; i++) {
      instruments.value.value['music_instrument_places'.tr]
          .add(Instrument(name: 'place_$i'.tr));
    }
    instruments.value.value['music_instrument_other'.tr] = [];
    for (var i = 1; i <= 6; i++) {
      instruments.value.value['music_instrument_other'.tr]
          .add(Instrument(name: 'other_$i'.tr));
    }
    instruments.value.value['music_instrument_sound_of_nature'.tr] = [];
    for (var i = 1; i <= 19; i++) {
      instruments.value.value['music_instrument_sound_of_nature'.tr]
          .add(Instrument(name: 'nature_$i'.tr));
    }
    instruments.value.value['music_instrument_living_creatures'.tr] = [];
    for (var i = 1; i <= 13; i++) {
      instruments.value.value['music_instrument_living_creatures'.tr]
          .add(Instrument(name: 'creatures_$i'.tr));
    }
  }

  void addPlay(Instrument instrument) {
    if (!isPlay(instrument)) {
      playList.value.value.add(instrument);
      playList.value.refresh();
    }
  }

  void removePlayList(Instrument instrument) {
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
  }
}
