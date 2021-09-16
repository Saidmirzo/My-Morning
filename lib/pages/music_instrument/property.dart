import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/instruments_audio/controllers/instruments_audio_controller.dart';
import 'package:morningmagic/features/instruments_audio/data/instrument_audio_data.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';
import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';

Function() onInstrumentClick(
    Instrument instrument, MusicInstrumentControllers controllers) {
  InstrumentAudioController audioControlelr = Get.find();

  audioControlelr.playAudio(instrument);
}

Function() playPause() {
  InstrumentAudioController audioControlelr = Get.find();
  audioControlelr.playPause();
}

Function() onShowPlayList(Widget child) {
  Get.bottomSheet(child);
}
