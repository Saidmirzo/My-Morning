import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/instruments_audio/controllers/instruments_audio_controller.dart';
import 'package:morningmagic/pages/music_instrument/components/dialog_play_list.dart';
import 'package:morningmagic/pages/music_instrument/components/slider.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';
import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';
import 'package:morningmagic/pages/music_instrument/property.dart';
import 'package:morningmagic/pages/music_instrument/timer/components/player_instrument.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/styles.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/storage.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

class MusicInstrumentPage extends StatefulWidget {
  MusicInstrumentPage() {
    Get.put(MusicInstrumentControllers());
    Get.put(InstrumentAudioController());
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
  InstrumentAudioController _audioController = Get.find();
  final TimerService timerService = TimerService();

  return Container(
    width: Get.width,
    height: Get.height,
    color: AppColors.instrumentalBg,
    child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: PrimaryCircleButton(
              bgColor: Colors.transparent,
              icon: Icon(Icons.arrow_back, color: AppColors.WHITE),
              onPressed: () {
                _audioController.dispose();
                Get.delete<InstrumentAudioController>();
                AppRouting.navigateToHomeWithClearHistory();
              },
            ),
          ),
          Expanded(
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
                          gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [
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
                  right: 52,
                  left: 52,
                  child: instrumentPlayer(audioController: _audioController, timerService: _audioController.timerService == null ? timerService : _audioController.timerService),
                ),
              ],
            ),
          ),
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
        style: AppStyles.instrumentCategotyText,
      ),
    );

List<Widget> _instrumentList() {
  MusicInstrumentControllers _controllers = Get.find();
  InstrumentAudioController _audioControlelr = Get.find();
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
                    margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                    child: Column(
                      children: [
                        _titleInstrument(e.name),
                        _instumentContanier(size, instrument: e, controllers: _controllers, isPlay: _audioControlelr.isPlay(tag: e.instrument.tag)),
                        SizedBox(height: 5),
                        if (_audioControlelr.isPlay(tag: e.instrument.tag)) _trackBar(instrument: e)
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
      style: TextStyle(color: AppColors.instrument_text_color, fontSize: 14),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _instumentContanier(Size size, {Instrument instrument, MusicInstrumentControllers controllers, bool isPlay = false}) {
  InstrumentAudioController audioController = Get.find();
  bool isPay = (instrument.instrument.pay == true && billingService.isPro() == false) ? false : true;
  return InkWell(
    //padding: const EdgeInsets.all(0),
    onTap: isPay == false ? null : () => onInstrumentClick(instrument, controllers),
    child: Container(
      height: size.width * 1.1,
      width: size.width,
      decoration: BoxDecoration(color: isPlay == false ? AppColors.primary : null, borderRadius: BorderRadius.circular(10), gradient: isPlay ? AppColors.gradient_instrument_active : null),
      child: Stack(
        children: [
          if (audioController.isLoading.value.value == instrument)
            Positioned(
                top: 5,
                right: 5,
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.LOADING_INDICATOR,
                      strokeWidth: 2,
                    ))),
          if (!isPay)
            Positioned(
                top: 5,
                right: 5,
                child: SvgPicture.asset(
                  'assets/images/home_menu/crown.svg',
                  color: AppColors.WHITE.withOpacity(0.5),
                )),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: instrument.instrumentImage != null
                  ? SvgPicture.asset(
                      instrument.instrumentImage,
                      color: isPlay ? Colors.white : null,
                    )
                  : SizedBox(),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _trackBar({@required Instrument instrument}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: TrackBar(
      tag: instrument.instrument.tag,
      volume: instrument.instrumentVolume,
    ),
  );
}
