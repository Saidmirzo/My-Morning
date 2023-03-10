import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:get/get.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextField(
            controller: _textEditingController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: 'target_title'.tr,
            ),
            showCursor: true,
          ),
        ),
        (_textEditingController.text.isEmpty)
            ? _buildNotActiveAddButton(context)
            : _buildActiveAddButton(context),
        Text(
          'target_short_desc'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildActiveAddButton(BuildContext context) {
    return RoundBorderedButton(
        onTap: () => _saveOrUpdateVisualizationTarget(context),
        child: SvgPicture.asset('assets/images/plus.svg'));
  }

  Widget _buildNotActiveAddButton(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: RoundBorderedButton(
          onTap: () {}, child: SvgPicture.asset('assets/images/plus.svg')),
    );
  }

  void _saveOrUpdateVisualizationTarget(BuildContext context) {
    if (_textEditingController.text != null &&
        _textEditingController.text.isNotEmpty) {
      if (widget.targetId != null) {
        _visualizationController.updateTarget(
            widget.targetId, _textEditingController.text);
      } else {
        _visualizationController.saveTarget(_textEditingController.text);
      }
    }
    Navigator.pop(context);
  }
}
