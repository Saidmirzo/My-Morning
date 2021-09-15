import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:morningmagic/pages/music_instrument/components/snackbar.dart';
import 'package:morningmagic/pages/music_instrument/music_instrument_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';

class MusicInstrumentControllers extends GetxController {
  List<Instrument> instrumentse = [];
  var instruments = Rx<Map<String, List<Instrument>>>({}).obs;

  var playList = Rx<List<Instrument>>([]).obs;

  MusicInstrumentControllers() {
    _initInstrumentList();
  }

  void _initInstrumentList() {
    instruments.value.value['music_instrument_title'.tr] = [];
    for (var i = 1; i <= 8; i++) {
      instruments.value.value['music_instrument_title'.tr].add(Instrument(
          name: 'instrument_$i'.tr,
          sound: '${SvgAssets.instrumentalPath}/instrument_$i.svg'));
    }
    instruments.value.value['music_instrument_places'.tr] = [];
    for (var i = 1; i <= 7; i++) {
      instruments.value.value['music_instrument_places'.tr].add(Instrument(
          name: 'place_$i'.tr,
          sound: '${SvgAssets.instrumentalPath}/place_$i.svg'));
    }
    instruments.value.value['music_instrument_other'.tr] = [];
    for (var i = 1; i <= 6; i++) {
      instruments.value.value['music_instrument_other'.tr].add(Instrument(
          name: 'other_$i'.tr,
          sound: '${SvgAssets.instrumentalPath}/other_$i.svg'));
    }
    instruments.value.value['music_instrument_sound_of_nature'.tr] = [];
    for (var i = 1; i <= 19; i++) {
      instruments.value.value['music_instrument_sound_of_nature'.tr].add(
          Instrument(
              name: 'nature_$i'.tr,
              sound: '${SvgAssets.instrumentalPath}/nature_$i.svg'));
    }
    instruments.value.value['music_instrument_living_creatures'.tr] = [];
    for (var i = 1; i <= 12; i++) {
      instruments.value.value['music_instrument_living_creatures'.tr].add(
          Instrument(
              name: 'creatures_$i'.tr,
              sound: '${SvgAssets.instrumentalPath}/creatures_$i.svg'));
    }
  }

  void addPlay(Instrument instrument) {
    if (!isPlay(instrument)) {
      if (playList.value.value.length < 10) {
        playList.value.value.add(instrument);
        playList.value.refresh();
      } else
        showErrorDialog('10 из 10');
    }
  }

  void showErrorDialog(String text) {
    Get.snackbar('', text,
        backgroundColor: AppColors.VIOLET.withOpacity(0.5),
        titleText: snackText(''),
        messageText: snackText(text));
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
