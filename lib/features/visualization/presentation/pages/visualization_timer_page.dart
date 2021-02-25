import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_full_screen_page.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/circular_progress_bar.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';

class VisualizationTimerPage extends StatefulWidget {
  @override
  _VisualizationTimerPageState createState() => _VisualizationTimerPageState();
}

class _VisualizationTimerPageState extends State<VisualizationTimerPage> {
  VisualizationController _controller = Get.find<VisualizationController>();
  List<VisualizationImage> _images;

  @override
  void initState() {
    super.initState();
    _images = _controller.selectedImages;
    _controller.setCurrentImageIndex(0);
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
                image: AssetImage(
                    _images[_controller.currentImageIndex].assetPath),
                colorFilter: new ColorFilter.mode(
                    Colors.grey.withOpacity(0.5), BlendMode.exclusion),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.image,
                        size: 36,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VisualizationFullScreenPage(),
                          )),
                    ),
                  ),
                ),
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
                        () => {
                              // TODO main menu
                            },
                        'assets/images/menu.svg'),
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
                      // TODO skip page
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
}
