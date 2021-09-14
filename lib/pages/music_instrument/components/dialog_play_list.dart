import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';
import 'package:morningmagic/pages/music_instrument/music_instrument_page.dart';
import 'package:morningmagic/resources/colors.dart';

Widget dilaogPlayList() {
  MusicInstrumentControllers _controllers = Get.find();
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
              children: _controllers.playList.value.value
                  .map((data) => _itemList(data))
                  .toList())),
        )),
        SizedBox(height: 15),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _button(child: _buttonSave(), onPress: () {}),
          Icon(Icons.star, color: Colors.white)
        ])
      ],
    ),
  );
}

Widget _buttonSave() {
  return Container(
    height: 40,
    width: Get.width / 1.5,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: AppColors.PINK),
  );
}

Widget _button({Widget child, Function() onPress}) {
  return CupertinoButton(
      padding: const EdgeInsets.all(0), child: child, onPressed: onPress);
}

Widget _itemList(Instrument instrument) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          height: 50,
          width: 50,
          color: Colors.white,
        ),
        Expanded(child: Slider(value: 0.5, onChanged: (ch) {})),
        _button(
            child: Icon(Icons.remove_circle, color: Colors.white),
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
  _controllers.removePlayList(instrument);
}
