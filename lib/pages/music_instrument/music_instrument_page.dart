import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/music_instrument/components/dialog_play_list.dart';
import 'package:morningmagic/pages/music_instrument/components/slider.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';
import 'package:morningmagic/pages/music_instrument/property.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/resources/svg_assets.dart';

class Instrument {
  String name;
  String sound;

  Instrument({this.name, this.sound});
}

class MusicInstrumentPage extends StatefulWidget {
  MusicInstrumentPage() {
    Get.put(MusicInstrumentControllers());
  }

  @override
  _MusicInstrumentPageState createState() => _MusicInstrumentPageState();
}

class _MusicInstrumentPageState extends State<MusicInstrumentPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: body(context),
      ),
    );
  }
}

Widget body(BuildContext context) {
  MusicInstrumentControllers _controller = Get.find();
  return Container(
    width: Get.width,
    height: Get.height,
    color: AppColors.instrumentalBg,
    child: SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _instrumentList(),
                )),
          ),
          // for (var i = 80.0; i <= 0; i++)
          /*Positioned(
            bottom: 0,
            child: ClipRRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 1.4, sigmaY: 1.4),
                child: new Container(
                  width: Get.width,
                  height: 80,
                  decoration: new BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                        Colors.purple.shade500,
                        Colors.purple.shade500.withOpacity(0.5),
                        Colors.purple.shade500.withOpacity(0.0),
                        //Colors.transparent
                      ])),
                ),
              ),
            ),
          ),*/
          Positioned(
            bottom: 0,
            child: ClipRRect(
              child: Container(
                width: Get.width,
                height: 100,
                decoration: new BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Color(0xFF290A3C),

                      Color(0xFF290A3C).withOpacity(0.8),
                      Color(0xFF290A3C).withOpacity(0.5),
                      Color(0xFF290A3C).withOpacity(0.2),
                      Color(0xFF290A3C).withOpacity(0),
                      //Colors.transparent
                    ])),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: Get.width / 4.5,
            left: Get.width / 4.5,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  color: AppColors.CREAM,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _playButton(SvgAssets.time),
                  _playButton(SvgAssets.play),
                  Stack(
                    children: [
                      _playButton(
                        SvgAssets.playList,
                        onPress: () => onShowPlayList(
                          dilaogPlayList(),
                        ),
                      ),
                      Obx(
                        () => Positioned.fill(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                              child: Text(
                                '${_controller.playList.value.value.length == 0 ? '' : _controller.playList.value.value.length}',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _playButton(SvgAssets.next),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Future<bool> _onWillPop() async {
  Get.delete<MusicInstrumentControllers>();
  return true;
}

Widget _title(String title) => Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
      child: Text(
        title,
        style: AppStyles.treaningSubtitle,
      ),
    );

List<Widget> _instrumentList() {
  MusicInstrumentControllers _controllers = Get.find();
  Size size = Size(Get.width / 3.5, Get.width / 3.5);

  List<Widget> toList() {
    List<Widget> list = [];
    for (var i = 0; i < _controllers.instruments.value.value.length; i++) {
      String key = _controllers.instruments.value.value.keys.elementAt(i);
      list.add(_title(key));
      var subList = _controllers.instruments.value.value.values.elementAt(i);
      list.add(Center(
        child: Wrap(
          direction: Axis.horizontal,
          children: subList
              .map((e) => Container(
                    width: size.width,
                    margin:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                    child: Column(
                      children: [
                        _titleInstrument(e.name),
                        _instumentContanier(size,
                            instrument: e,
                            controllers: _controllers,
                            isPlay: _controllers.isPlay(e)),
                        SizedBox(height: 5),
                        if (_controllers.isPlay(e)) _trackBar()
                      ],
                    ),
                  ))
              .toList(),
        ),
      ));
    }
    list.add(SizedBox(height: 150));
    return list;
  }

  return toList();
}

Widget _titleInstrument(String title) {
  return Container(
    height: 40,
    child: Text(
      title,
      style: TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _instumentContanier(Size size,
    {Instrument instrument,
    MusicInstrumentControllers controllers,
    bool isPlay = false}) {
  return InkWell(
    //padding: const EdgeInsets.all(0),
    onTap: () => onInstrumentClick(instrument, controllers),
    child: Container(
      height: size.width * 1.1,
      width: size.width,
      decoration: BoxDecoration(
          color: isPlay == false ? AppColors.primary : null,
          borderRadius: BorderRadius.circular(10),
          gradient: isPlay ? AppColors.gradient_instrument_active : null),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: instrument.sound != null
            ? SvgPicture.asset(
                instrument.sound,
                color: isPlay ? Colors.white : null,
              )
            : SizedBox(),
      ),
    ),
  );
}

Widget _trackBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: TrackBar(),
  );
}

Widget _playButton(String icon, {Function() onPress}) {
  return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: onPress,
      child: SvgPicture.asset(
        icon,
        height: 18,
        width: 18,
      ));
}
