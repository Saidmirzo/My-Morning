import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/custom_progress_bar/circleProgressBar.dart';

class VisualizationTimerPage extends StatefulWidget {
  @override
  _VisualizationTimerPageState createState() => _VisualizationTimerPageState();
}

// TODO 1) timer
// 2) change image

class _VisualizationTimerPageState extends State<VisualizationTimerPage> {
  VisualizationController _controller = Get.find<VisualizationController>();
  List<VisualizationImage> _images;

  @override
  void initState() {
    super.initState();
    _images = _controller.selectedImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_images[0].assetPath),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildTimerProgress(context),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                    () => {
                          // TODO main menu
                        },
                    'assets/images/menu.svg'),
                Obx(() {
                  VoidCallback _toggleStartPauseCallback =
                      () => _controller.toggleStartPauseTimer();
                  final _imageRes = _controller.isTimerActive
                      ? 'assets/images/pause.svg'
                      : 'assets/images/play.svg';
                  return _buildActionButton(
                      _toggleStartPauseCallback, _imageRes);
                }),
                _buildActionButton(() {
                  // TODO skip page
                }, 'assets/images/arrow_forward.svg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildTimerProgress(BuildContext context) {
    double _timerSize, _textSize;

    _timerSize = MediaQuery.of(context).size.width * 0.4;

    return Container(
      width: _timerSize,
      child: Obx(() => CircleProgressBar(
            text: _controller.timeLeft,
            foregroundColor: AppColors.WHITE,
            value: 10,
            textSize: 36,
          )),
    );
  }

  Padding _buildActionButton(VoidCallback callback, String imageAssetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RoundBorderedButton(
        onTap: callback,
        child: SvgPicture.asset(imageAssetPath),
      ),
    );
  }
}
