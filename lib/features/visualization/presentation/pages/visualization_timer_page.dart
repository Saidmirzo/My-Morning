import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_full_screen_page.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/back_button.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/routes/scale_route.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/circular_progress_bar/circular_progress_bar.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.toggleStartPauseTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: _buildPageDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildTimerProgress(context),
                  Flexible(
                    child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      shrinkWrap: true,
                      children: [
                        _buildVisualizationText(),
                      ],
                    ),
                  ),
                  _buildButtonsRow(context),
                ],
              ),
            ),
          ),
          VisualizationBackButton(),
        ],
      ),
    );
  }

  BoxDecoration _buildPageDecoration() {
    return BoxDecoration(
      image: DecorationImage(
        image: _controller
            .getImpressionDecorationImage(_controller.currentImageIndex),
        colorFilter: new ColorFilter.mode(
            Colors.grey.withOpacity(0.5), BlendMode.exclusion),
        fit: BoxFit.cover,
      ),
    );
  }

  Row _buildButtonsRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
            () => Navigator.of(context).push(_createFullScreenRoute()),
            'assets/images/full_screen.svg'),
        Obx(() {
          VoidCallback _toggleStartPauseCallback =
              () => _controller.toggleStartPauseTimer();
          final _imageRes = _controller.isTimerActive.value
              ? 'assets/images/pause.svg'
              : 'assets/images/play.svg';
          return _buildActionButton(_toggleStartPauseCallback, _imageRes);
        }),
        _buildActionButton(() {
          _controller.finishVisualization();
          appAnalitics.logEvent('first_visualisation_next');
        }, 'assets/images/arrow_forward.svg'),
      ],
    );
  }

  Widget _buildVisualizationText() {
    return StyledText(
      _controller.vizualizationText.text,
      fontSize: 24,
      color: Colors.white,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTimerProgress(BuildContext context) {
    double _timerSize = MediaQuery.of(context).size.width * 0.45;
    return Padding(
      padding: const EdgeInsets.only(top: 54.0, bottom: 16),
      child: Container(
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
