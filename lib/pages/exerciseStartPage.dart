import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/data/repositories/audio_repository_impl.dart';
import 'package:morningmagic/features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import 'package:morningmagic/features/meditation_audio/presentation/dialogs/audio_meditation_dialog.dart';
import 'package:morningmagic/pages/timerPage.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/widgets/animatedButton.dart';

class ExerciseStartPage extends StatefulWidget {
  final int pageId;
  final String title;
  final String desc;
  final Function btnNext;

  const ExerciseStartPage(
      {Key key,
      @required this.pageId,
      @required this.title,
      @required this.desc,
      @required this.btnNext})
      : super(key: key);

  @override
  State createState() => ExerciseStartPageState();
}

class ExerciseStartPageState extends State<ExerciseStartPage> {
  final _audioController =
      Get.put(MediationAudioController(repository: AudioRepositoryImpl()));

  @override
  void dispose() {
    super.dispose();
    Get.delete<MediationAudioController>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.TOP_GRADIENT,
              AppColors.MIDDLE_GRADIENT,
              AppColors.BOTTOM_GRADIENT
            ],
          )),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 35),
                    child: Text(
                      widget.title.tr(),
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: "rex",
                        fontStyle: FontStyle.normal,
                        color: AppColors.WHITE,
                      ),
                    ),
                  ),
                  Text(
                    widget.desc.tr(),
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: "JMH",
                      fontStyle: FontStyle.italic,
                      color: AppColors.VIOLET,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (widget.pageId == 1) _buildAudioPicker(context),
                ],
              ),
              Positioned(
                bottom: 60,
                child: ButtonTheme(
                  minWidth: 170.0,
                  height: 50.0,
                  child: AnimatedButton(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TimerPage(pageId: widget.pageId ?? 5)));
                  }, 'rex', 'next_button'.tr(), null, null, null),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAudioPicker(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/music_icon.png', width: 40, height: 40),
            SizedBox(height: 5),
            Obx(
              () => Text(
                MeditationAudioData.audioSources.keys
                    .toList()[_audioController.selectedItemIndex.value],
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "JMH",
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        Positioned.fill(
            //ripple effect
            child: Material(
          color: Colors.transparent,
          child: new InkWell(
            customBorder: CircleBorder(),
            splashColor: AppColors.VIOLET.withAlpha(120),
            onTap: () => showDialog(
                context: context,
                builder: (context) => AudioMeditationDialog()),
          ),
        )),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    AppRouting.navigateToHomeWithClearHistory(context);
    return false;
  }
}
