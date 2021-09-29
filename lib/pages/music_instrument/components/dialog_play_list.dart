import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/instruments_audio/controllers/instruments_audio_controller.dart';
import 'package:morningmagic/pages/music_instrument/components/slider.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';
import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/svg_assets.dart';

Widget dilaogPlayList({bool fromTimer = false}) {
  //MusicInstrumentControllers _controllers = Get.find();
  InstrumentAudioController _audioController = Get.find();
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25), color: AppColors.nightModeBG),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _button(child: Icon(Icons.close, color: Colors.white), onPress: _close),
        Expanded(
            child: SingleChildScrollView(
                child: Obx(() => Column(
                      children: [
                        for (var i = 0;
                            i < _audioController.audioSourse.length;
                            i++)
                          _itemList(
                              _audioController.audioSourse.values.elementAt(i),
                              fromTimer)
                      ],
                    )))),
        SizedBox(height: 15),
      ],
    ),
  );
}

Widget _button({Widget child, Function() onPress}) {
  return CupertinoButton(
      padding: const EdgeInsets.all(0), child: child, onPressed: onPress);
}

Widget _itemList(Instrument instrument, bool fromTimer) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          width: 45,
          child: SvgPicture.asset(
            instrument.instrumentImage,
            color: const Color(0xFFD0D2E5),
            height: 35,
            width: 35,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TrackBar(
            tag: instrument.instrument.tag,
            volume: instrument.instrumentVolume,
            dialogMode: true,
            fromTimer: fromTimer,
          ),
        )),
        _button(
            child: SvgPicture.asset(
              SvgAssets.removePlayList,
              height: 15,
              width: 15,
            ),
            onPress: () => _removeItem(instrument))
      ],
    ),
  );
}

Function() _close() {
  Get.back();
}

Function() _removeItem(Instrument instrument) {
  MusicInstrumentControllers _controllers = Get.find();
  InstrumentAudioController _audioControlelr = Get.find();
  //_controllers.removePlayList(instrument);
  _audioControlelr.stop(instrument);
}
