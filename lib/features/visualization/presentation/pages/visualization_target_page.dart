import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/domain/visualization_data_generator.dart';
import 'package:morningmagic/features/visualization/domain/visualization_target.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/resources/colors.dart';

class VisualizationTargetPage extends StatefulWidget {
  @override
  _VisualizationTargetPageState createState() =>
      _VisualizationTargetPageState();
}

class _VisualizationTargetPageState extends State<VisualizationTargetPage> {
  List<VisualizationTarget> targets =
      VisualizationDataGenerator.generateTargets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _buildSelectTargetTitle(context),
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildTargets(),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RoundBorderedButton(
            onTap: () {
              // TODO
            },
            child: SvgPicture.asset('assets/images/plus.svg'),
          ),
        ),
      ]),
    );
  }

  Widget _buildSelectTargetTitle(BuildContext context) {
    return Center(
      child: StyledText(
        // todo
        'Выбор цели',
        fontSize: 32,
        color: AppColors.VIOLET,
      ),
    );
  }

  List<Widget> _buildTargets() {
    List<Widget> _targetWidgets = [];
    targets.forEach((element) {
      final item = Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 2),
          child: Container(
            decoration: _buildDecoration(element),
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  element.title,
                  style: TextStyle(color: AppColors.WHITE, fontSize: 32),
                ),
              ],
            ),
          ),
        ),
      );
      _targetWidgets.add(item);
    });

    return _targetWidgets;
  }

  BoxDecoration _buildDecoration(VisualizationTarget _target) {
    final _borderRadius = BorderRadius.circular(10);
    // TODO for custom and check for null
    if (_target.type == TargetType.custom) {
      return BoxDecoration(borderRadius: _borderRadius, color: Colors.grey);
    } else
      return BoxDecoration(
          borderRadius: _borderRadius,
          image: DecorationImage(
            image: AssetImage(_target.coverAssetPath),
            fit: BoxFit.fill,
          ));
  }
}
