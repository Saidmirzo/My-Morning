import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';
import 'package:morningmagic/pages/music_instrument/music_instrument_page.dart';

Function() onInstrumentClick(
    Instrument instrument, MusicInstrumentControllers controllers) {
  controllers.addPlay(instrument);
}

Function() onShowPlayList(Widget child) {
  Get.bottomSheet(child);
}
