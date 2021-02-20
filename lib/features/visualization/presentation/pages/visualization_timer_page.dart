import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/custom_progress_bar/circleProgressBar.dart';

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
            SizedBox(
              height: 24,
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
      child: CircleProgressBar(
        text: "time here", //StringUtil().createTimeString(timerService.time),
        foregroundColor: AppColors.WHITE,
        value: 10, //timerService.createValue(),
        textSize: _textSize,
      ),
    );
  }
}
