import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_image_repository_impl.dart';
import 'package:morningmagic/features/visualization/data/repositories/visualization_target_repository_impl.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_target_page.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/resources/colors.dart';

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
    _textEditingController =
        TextEditingController(text: _controller.getVisualizationText());
    _textEditingController.addListener(() => _saveVisualization());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.delete<VisualizationController>(),
      child: Scaffold(
        body: Center(
          child: AppGradientContainer(
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _buildVisualizationTitle(context),
                        _buildVisualizationSubtitle(context),
                        _buildVisualizationInput(context),
                        SizedBox(
                          height: 24,
                        ),
                        _buildNextButton()
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Container _buildVisualizationTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 3,
        bottom: MediaQuery.of(context).size.height / 26,
      ),
      child: StyledText(
        'visualization'.tr(),
        fontSize: 32,
        color: AppColors.WHITE,
      ),
    );
  }

  Container _buildVisualizationSubtitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height / 28,
      ),
      child: Container(
        child: Text(
          'visualization_title'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 19,
              fontFamily: "JMH",
              fontStyle: FontStyle.italic,
              color: AppColors.VIOLET,
              height: 1.3),
        ),
      ),
    );
  }

  Container _buildVisualizationInput(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.height / 15,
          right: MediaQuery.of(context).size.height / 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: AppColors.TRANSPARENT_WHITE,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 18, bottom: 17, left: 20, right: 20),
          child: TextField(
            controller: _textEditingController,
            minLines: 3,
            maxLines: 3,
            cursorColor: AppColors.VIOLET,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 24,
                fontFamily: "rex",
                fontStyle: FontStyle.normal,
                color: AppColors.VIOLET,
                decoration: TextDecoration.none),
            decoration: InputDecoration(
              hintMaxLines: 4,
              hintText: 'visualization_hint'.tr(),
              hintStyle: TextStyle(
                color: AppColors.LIGHT_GRAY,
                fontSize: 16,
                fontFamily: "rex",
              ),
              border: InputBorder.none,
            ),
          ),
        ));
  }

  Widget _buildNextButton() {
    return RoundBorderedButton(
        onTap: () {
          _saveVisualization();
          _openVisualizationTargetScreen();
        },
        child: SvgPicture.asset('assets/images/arrow_forward.svg'));
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
