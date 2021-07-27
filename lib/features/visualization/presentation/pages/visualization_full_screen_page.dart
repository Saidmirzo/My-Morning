import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  static const int durationHideElements = 200;

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
    _visualizationController.startTimerElements();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages.addAll(_buildPages());
  }

  @override
  void dispose() {
    super.dispose();
    if (_visualizationController.timerElements?.isActive ?? false)
      _visualizationController.timerElements?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_visualizationController.hideElements.value) {
            _visualizationController.startTimerElements();
          } else {
            Navigator.pop(context);
          }
        },
        child: Obx(() {
          if (_visualizationController.hideElements.value) {
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
          } else {
            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          }
          print(
              '_visualizationController.hideElements : ${_visualizationController.hideElements.value}');
          return Stack(
            children: [
              PageView(
                controller: _pageController,
                children: _pages,
              ),
              if (_pages.length > 1)
                AnimatedPositioned(
                  duration: Duration(milliseconds: durationHideElements),
                  bottom:
                      _visualizationController.hideElements.value ? -30 : 30,
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    child: _buildPageIndicator(),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  List<Widget> _buildPages() {
    List<Widget> _pages = [];
    for (int i = 0; i < _visualizationController.selectedImages.length; i++) {
      _pages.add(_buildVisualizationImageFullScreen(i));
    }
    return _pages;
  }

  Widget _buildPageIndicator() {
    return Container(
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
    );
  }

  Widget _buildVisualizationImageFullScreen(int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _visualizationController.getImpressionDecorationImage(index),
          fit: BoxFit.cover,
        ),
      ),
      child: Obx(
        () => Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: durationHideElements),
              top: _visualizationController.hideElements.value ? -50 : 50,
              child: Container(
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  _visualizationController.formattedTimeLeft,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.85), fontSize: 48),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
