import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_image_repository_impl.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_target_repository_impl.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_target_page.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

class VisualizationMainPage extends StatefulWidget {
  final bool fromHomeMenu;
  const VisualizationMainPage({Key key, this.fromHomeMenu = false})
      : super(key: key);
  @override
  _VisualizationMainPageState createState() => _VisualizationMainPageState();
}

class _VisualizationMainPageState extends State<VisualizationMainPage> {
  VisualizationController _controller;
  FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    _controller = Get.put(VisualizationController(
        hiveBox: myDbBox,
        targetRepository: VisualizationTargetRepositoryImpl(),
        imageRepository: VisualizationImageRepositoryImpl()));
    _controller.fromHomeMenu = widget.fromHomeMenu;
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.delete<VisualizationController>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            focusNode.unfocus();
          },
          child: Container(
            width: Get.width,
            decoration: const BoxDecoration(gradient: AppColors.Bg_Gradient_2),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  bg(),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          child: const Padding(
                            padding: EdgeInsets.only(left: 31, top: 37),
                            child: Icon(
                              Icons.west,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainMenuPage()),
                            );
                            // _controller.finishVisualization(true,
                            //     backProgramm: true);
                            // if (widget.fromHomeMenu) {
                            //   AppRouting.navigateToHomeWithClearHistory();
                            // }
                          },
                        ),

                        // PrimaryCircleButton(
                        //   icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                        //   onPressed: () {
                        //     _controller.finishVisualization(true, backProgramm: true);
                        //     if (widget.fromHomeMenu) return AppRouting.navigateToHomeWithClearHistory();
                        //     OrderUtil().getPreviousRouteById(TimerPageId.Visualization).then((value) {
                        //       Get.off(value);
                        //     });
                        //   },
                        // ),
                      ),
                      SizedBox(height: Get.height * 0.05),
                      _buildVisualizationTitle(context),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            _buildVisualizationSubtitle(context),
                            SizedBox(height: Get.height * 0.01),
                            _buildVisualizationInput(context),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildNextButton()
                    ],
                  ),
                  if (isComplex)
                    Positioned(
                      top: 10,
                      right: 30,
                      child: GestureDetector(
                        onTap: () {
                          appAnalitics.logEvent('first_menu_setings');
                          Navigator.pushNamed(context, settingsPageRoute);
                        },
                        child: Container(
                          width: 47.05,
                          height: 47.05,
                          padding: const EdgeInsets.all(12.76),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'assets/images/home_menu/settings_icon_2.png',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
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

  Container _buildVisualizationInput(
    BuildContext context,
  ) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: AppColors.TRANSPARENT_WHITE,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: TextField(
            autofocus: false,
            focusNode: focusNode,
            controller: _controller.vizualizationText,
            minLines: 4,
            maxLines: 4,
            cursorColor: AppColors.VIOLET,
            // keyboardType: TextInputType.text,
            textInputAction: TextInputAction.newline,
            textAlign: TextAlign.left,
            style: const TextStyle(
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
          _openVisualizationTargetScreen();
        },
        icon: const Icon(Icons.arrow_forward, color: Colors.black));
  }

  void _openVisualizationTargetScreen() => Get.to(
        const VisualizationTargetPage(),
      );
}
