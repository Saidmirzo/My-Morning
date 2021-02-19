import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:image/image.dart' as image;
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/custom_progress_bar/circleProgressBar.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class VisualizationTimerPage extends StatefulWidget {
  @override
  _VisualizationTimerPageState createState() => _VisualizationTimerPageState();
}

class _VisualizationTimerPageState extends State<VisualizationTimerPage> {
  VisualizationController _controller = Get.find<VisualizationController>();
  ui.Image _testImage;

  @override
  void initState() {
    super.initState();
    final _images = _controller.selectedImageIndexes
        .map((index) => _controller.images[index])
        .toList();
    // List<VisualizationImage> assetsOnlyImage =
    //     _images.where((e) => e.asset != null).toList();
    // Asset imageTest = _images
    //     .firstWhere(
    //       (element) => element.asset != null,
    //       orElse: () => null,
    //     )
    //     .asset;
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //    _testImage = await getUiImage(imageTest);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            // TODO convert ByteData to AssetImage
            // image: AssetImage("${_testImage}"),
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
        ), /* add child content here */
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

  Future<ui.Image> getUiImage(Asset imageAsset
      /*, int height, int width*/) async {
    final ByteData assetImageByteData = await imageAsset.getByteData();
    image.Image baseSizeImage =
        image.decodeImage(assetImageByteData.buffer.asUint8List());
    // image.Image resizeImage = image.copyResize(baseSizeImage, height: height, width: width);
    ui.Codec codec =
        await ui.instantiateImageCodec(image.encodePng(baseSizeImage));
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}
