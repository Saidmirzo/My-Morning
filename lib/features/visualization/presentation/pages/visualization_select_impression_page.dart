import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/resources/colors.dart';

class VisualizationSelectImpressionPage extends StatefulWidget {
  final int targetId;

  const VisualizationSelectImpressionPage({Key key, @required this.targetId})
      : super(key: key);

  @override
  _VisualizationSelectImpressionPageState createState() =>
      _VisualizationSelectImpressionPageState();
}

class _VisualizationSelectImpressionPageState
    extends State<VisualizationSelectImpressionPage> {
  final _controller = Get.find<VisualizationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildSelectImpressionTitle(context),
        //
        Expanded(
          child: GridView.builder(
            itemCount: _controller.testImageUrls.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) => Container(
              child: Image.network(
                _controller.testImageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(
                () => {Navigator.pop(context)}, 'assets/images/arrow_back.svg'),
            _buildActionButton(() => {}, 'assets/images/plus.svg'),
            _buildActionButton(() => {}, 'assets/images/arrow_forward.svg'),
          ],
        ),
      ]),
    );
  }

  Widget _buildSelectImpressionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, bottom: 16.0),
      child: StyledText(
        // todo
        'Выбор образа',
        fontSize: 32,
        color: AppColors.VIOLET,
      ),
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
