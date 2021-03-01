import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_full_screen_page.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_success_page.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/circular_progress_bar.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/routes/scale_route.dart';
import 'package:morningmagic/routing/route_values.dart';

class VisualizationTimerPage extends StatefulWidget {
  @override
  _VisualizationTimerPageState createState() => _VisualizationTimerPageState();
}

class _VisualizationTimerPageState extends State<VisualizationTimerPage> {
  VisualizationController _controller = Get.find<VisualizationController>();

  @override
  void initState() {
    super.initState();
    _controller.setCurrentImageIndex(0);
    // TODO check timer
    _controller.hasTimerCompleted.listen((value) {
      print('On timer finished VISUALIZAION TIMER PAGE $value');
      _finishVisualization(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _controller.getProvidedImage,
                colorFilter: new ColorFilter.mode(
                    Colors.grey.withOpacity(0.5), BlendMode.exclusion),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                  child: _buildTimerProgress(context),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _controller.getVisualizationText(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(
                        () => Navigator.of(context)
                            .push(_createFullScreenRoute()),
                        'assets/images/full_screen.svg'),
                    Obx(() {
                      VoidCallback _toggleStartPauseCallback =
                          () => _controller.toggleStartPauseTimer();
                      final _imageRes = _controller.isTimerActive.value
                          ? 'assets/images/pause.svg'
                          : 'assets/images/play.svg';
                      return _buildActionButton(
                          _toggleStartPauseCallback, _imageRes);
                    }),
                    _buildActionButton(() {
                      _finishVisualization(context);
                    }, 'assets/images/arrow_forward.svg'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _finishVisualization(BuildContext context) {
    _controller.onFinishVisualization();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => VisualizationSuccessPage(),
        ),
        ModalRoute.withName(homePageRoute));
  }

  Container _buildTimerProgress(BuildContext context) {
    double _timerSize = MediaQuery.of(context).size.width * 0.45;
    return Container(
      width: _timerSize,
      child: Obx(
        () => CircularProgressBar(
          text: _controller.formattedTimeLeft,
          foregroundColor: Colors.white.withOpacity(0.8),
          backgroundColor: Colors.white.withOpacity(0.4),
          value: _controller.timeLeftValue,
          fontSize: 40,
        ),
      ),
    );
  }

  Widget _buildActionButton(VoidCallback callback, String imageAssetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RoundBorderedButton(
        onTap: callback,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SvgPicture.asset(
            imageAssetPath,
            color: Colors.white,
          ),
        ),
        borderColor: Colors.white,
      ),
    );
  }

  Route _createFullScreenRoute() {
    return ScaleRoute(page: VisualizationFullScreenPage());
  }
}
