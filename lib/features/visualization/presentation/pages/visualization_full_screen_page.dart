import 'package:dots_indicator/dots_indicator.dart';
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

  final List<Widget> _pages = <Widget>[];

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages.addAll(_buildPages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: _pages,
            ),
            if (_pages.length > 1) _buildPageIndicator(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPages() {
    List<Widget> _pages = [];
    _visualizationController.selectedImages.forEach((element) {
      _pages.add(_buildVisualizationImageFullScreen(element.path));
    });
    return _pages;
  }

  Widget _buildPageIndicator() {
    return Positioned(
      bottom: 0.0,
      right: 0.0,
      left: 0.0,
      child: Container(
        color: Colors.grey[800].withOpacity(0.1),
        child: Obx(() => DotsIndicator(
              dotsCount: _pages.length,
              position: _visualizationController.currentImageIndex.toDouble(),
              decorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size.square(16.0),
                activeColor: Colors.white,
                color: Colors.white.withOpacity(0.6),
                spacing: const EdgeInsets.all(12.0),
              ),
            )),
      ),
    );
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
