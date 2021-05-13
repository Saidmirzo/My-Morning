import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_image_repository_impl.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_target_repository_impl.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_target_page.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/timer_page_ids.dart';
import 'package:morningmagic/utils/reordering_util.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

class VisualizationMainPage extends StatefulWidget {
  @override
  _VisualizationMainPageState createState() => _VisualizationMainPageState();
}

class _VisualizationMainPageState extends State<VisualizationMainPage> {
  TextEditingController _textEditingController;

  VisualizationController _controller = Get.put(VisualizationController(
      hiveBox: myDbBox,
      targetRepository: VisualizationTargetRepositoryImpl(),
      imageRepository: VisualizationImageRepositoryImpl()));

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() => _saveVisualization());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.delete<VisualizationController>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: Get.width,
          decoration: BoxDecoration(gradient: AppColors.Bg_Gradient_2),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                bg(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: PrimaryCircleButton(
                          icon:
                              Icon(Icons.arrow_back, color: AppColors.primary),
                          onPressed: () {
                            OrderUtil()
                                .getPreviousRouteById(TimerPageId.Visualization)
                                .then((value) {
                              Get.off(value);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                      _buildVisualizationTitle(context),
                      SizedBox(height: Get.height * 0.01),
                      _buildVisualizationSubtitle(context),
                      SizedBox(height: Get.height * 0.01),
                      _buildVisualizationInput(context),
                      SizedBox(height: 24),
                      _buildNextButton()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bg() {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            child: Image.asset('assets/images/visualisation/clouds.png',
                width: Get.width, fit: BoxFit.cover)),
        Positioned(
          bottom: 0,
          child: Image.asset('assets/images/visualisation/mountain1.png',
              width: Get.width, fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 0,
          child: Image.asset('assets/images/visualisation/mountain2.png',
              width: Get.width, fit: BoxFit.cover),
        ),
        Positioned(
            bottom: 0,
            child: Image.asset('assets/images/visualisation/main.png',
                width: Get.width, fit: BoxFit.cover)),
      ],
    );
  }

  Widget _buildVisualizationTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: StyledText(
        'visualization'.tr,
        fontWeight: FontWeight.w600,
        fontSize: Get.height * 0.028,
        color: AppColors.WHITE,
      ),
    );
  }

  Widget _buildVisualizationSubtitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Get.height * 0.03),
      child: Text(
        'visualization_title'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: Get.height * 0.019, color: AppColors.WHITE, height: 1.3),
      ),
    );
  }

  Container _buildVisualizationInput(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: AppColors.TRANSPARENT_WHITE,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: TextField(
            controller: _textEditingController,
            minLines: 4,
            maxLines: 4,
            cursorColor: AppColors.VIOLET,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.normal,
                color: AppColors.VIOLET,
                decoration: TextDecoration.none),
            decoration: InputDecoration(
              hintMaxLines: 4,
              hintText: 'visualization_hint'.tr,
              hintStyle: TextStyle(
                color: AppColors.inputHintText,
                fontSize: Get.height * 0.018,
              ),
              border: InputBorder.none,
            ),
          ),
        ));
  }

  Widget _buildNextButton() {
    return PrimaryCircleButton(
        size: 50,
        onPressed: () {
          _saveVisualization();
          _openVisualizationTargetScreen();
        },
        icon: Icon(Icons.arrow_forward, color: Colors.black));
  }

  void _saveVisualization() {
    final _visualizationText = _textEditingController.text;
    if (_visualizationText != null && _visualizationText.isNotEmpty) {
      _controller.saveVisualization(_visualizationText);
    }
  }

  void _openVisualizationTargetScreen() => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VisualizationTargetPage(),
      ));
}
