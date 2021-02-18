import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';

class AddNewTargetDialog extends StatefulWidget {
  final int targetId;

  const AddNewTargetDialog({Key key, this.targetId}) : super(key: key);

  @override
  _AddNewTargetDialogState createState() => _AddNewTargetDialogState();
}

class _AddNewTargetDialogState extends State<AddNewTargetDialog> {
  final _textEditingController = TextEditingController();
  final _visualizationController = Get.find<VisualizationController>();

  @override
  void initState() {
    super.initState();
    if (widget.targetId != null) {
      VisualizationTarget _target = _visualizationController.targets.firstWhere(
        (element) => element.id == widget.targetId,
        orElse: () => null,
      );
      if (_target != null) _textEditingController.text = _target.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _textEditingController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                // TODO translation
                labelText: 'название',
              ),
              showCursor: true,
            ),
          ),
          RoundBorderedButton(
              onTap: () => _saveOrUpdateVisualizationTarget(context),
              child: SvgPicture.asset('assets/images/plus.svg')),
          Text(
            // TODO translation
            'в поле опишите кратко  (в одно предложение) что будете визуализировать',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  void _saveOrUpdateVisualizationTarget(BuildContext context) {
    if (_textEditingController.text != null &&
        _textEditingController.text.isNotEmpty) {
      if (widget.targetId != null)
        _visualizationController.updateTarget(
            widget.targetId, _textEditingController.text);
      else
        _visualizationController.saveTarget(_textEditingController.text);
    }
    Navigator.pop(context);
  }
}
