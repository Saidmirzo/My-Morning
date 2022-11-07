import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/instruments_audio/controllers/instruments_audio_controller.dart';
import 'package:morningmagic/pages/music_instrument/components/slider.dart';
import 'package:morningmagic/pages/music_instrument/controllers/music_instrument_controllers.dart';
import 'package:morningmagic/pages/music_instrument/model/instrument_model.dart';
import 'package:morningmagic/pages/music_instrument/property.dart';
import 'package:morningmagic/pages/music_instrument/timer/components/player_instrument.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/resources/styles.dart';
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
              icon: const Icon(Icons.west, color: AppColors.white),
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
                        children: _instrumentList(context),
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
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            const Color(0xFF290A3C),

                            const Color(0xFF290A3C).withOpacity(0.8),
                            const Color(0xFF290A3C).withOpacity(0.5),
                            const Color(0xFF290A3C).withOpacity(0.2),
                            const Color(0xFF290A3C).withOpacity(0),
                            //Colors.transparent
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: 52,
                  left: 52,
                  child: instrumentPlayer(
                    audioController: _audioController,
                    timerService: _audioController.timerService ?? timerService,
                  ),
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
        style: AppStyles.instrumentCategoryText,
      ),
    );

List<Widget> _instrumentList(BuildContext context) {
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
                    margin:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                    child: Column(
                      children: [
                        _titleInstrument(e.name),
                        _instumentContanier(size, context,
                            instrument: e,
                            controllers: _controllers,
                            isPlay:
                                _audioControlelr.isPlay(tag: e.instrument.tag)),
                        const SizedBox(height: 5),
                        if (_audioControlelr.isPlay(tag: e.instrument.tag))
                          _trackBar(instrument: e)
                      ],
                    ),
                  ))
              .toList(),
        ),
      ));
    }
    list.add(const SizedBox(height: 150));
    return list;
  }

  return toList();
}

Widget _titleInstrument(String title) {
  return SizedBox(
    height: 40,
    child: Text(
      title,
      style:
          const TextStyle(color: AppColors.instrumentTextColor, fontSize: 14),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _instumentContanier(Size size, BuildContext context,
    {Instrument instrument,
    MusicInstrumentControllers controllers,
    bool isPlay = false}) {
  InstrumentAudioController audioController = Get.find();
  bool isPay =
      (instrument.instrument.pay == true && billingService.isPro() == false)
          ? false
          : true;
  return InkWell(
    //padding: const EdgeInsets.all(0),
    onTap: isPay == false
        ? () {
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            showProDialog(context);
          }
        : () {
            onInstrumentClick(instrument, controllers);
          },

    child: Container(
      height: size.width * 1.1,
      width: size.width,
      decoration: BoxDecoration(
          color: isPlay == false ? AppColors.primary : null,
          borderRadius: BorderRadius.circular(10),
          gradient: isPlay ? AppColors.gradientInstrumentActive : null),
      child: Stack(
        children: [
          if (audioController.isLoading.value.value == instrument)
            const Positioned(
                top: 5,
                right: 5,
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.loadingIndicator,
                      strokeWidth: 2,
                    ))),
          if (!isPay)
            Positioned(
                top: 5,
                right: 5,
                child: SvgPicture.asset(
                  'assets/images/home_menu/crown.svg',
                  color: AppColors.white.withOpacity(0.5),
                )),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: instrument.instrumentImage != null
                  ? SvgPicture.asset(
                      instrument.instrumentImage,
                      color: isPlay ? Colors.white : null,
                    )
                  : const SizedBox(),
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

showProDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.instrumentalBg,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'have_not_sub'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 80,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
