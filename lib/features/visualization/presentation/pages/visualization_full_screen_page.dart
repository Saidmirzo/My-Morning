import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';

class VisualizationFullScreenPage extends StatefulWidget {
  @override
  _VisualizationFullScreenPageState createState() =>
      _VisualizationFullScreenPageState();
}

class _VisualizationFullScreenPageState
    extends State<VisualizationFullScreenPage> {
  final _visualizationController = Get.find<VisualizationController>();

  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: PageView(
          controller: _pageController,
          children: _buildPages(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _visualizationController.currentImageIndex);
    _pageController.addListener(() {
      int next = _pageController.page.round();
      if (_visualizationController.currentImageIndex != next) {
        _visualizationController.setCurrentImageIndex(next);
      }
    });
  }

  List<Widget> _buildPages() {
    List<Widget> _pages = [];
    _visualizationController.selectedImages.forEach((element) {
      _pages.add(_buildVisualizationImageFullScreen(element.assetPath));
    });
    return _pages;
  }

  Widget _buildVisualizationImageFullScreen(String assetPath) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Obx(() => Text(
                _visualizationController.formattedTimeLeft,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 48),
              )),
        ),
      ),
    );
  }
}
