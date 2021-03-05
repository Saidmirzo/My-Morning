import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_impression_image_page.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/dialogs/add_new_target_dialog.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/visualization_target_item.dart';
import 'package:morningmagic/resources/colors.dart';

class VisualizationTargetPage extends StatefulWidget {
  @override
  _VisualizationTargetPageState createState() =>
      _VisualizationTargetPageState();
}

class _VisualizationTargetPageState extends State<VisualizationTargetPage> {
  final _controller = Get.find<VisualizationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _buildSelectTargetTitle(context),
        Expanded(
          child: Stack(
            children: [
              Obx(
                () => ListView.builder(
                  itemCount: _controller.targets.length,
                  itemBuilder: (context, index) {
                    final _target = _controller.targets[index];
                    return VisualizationTargetItem(
                      target: _controller.targets[index],
                      onCardTapped: () => _openImpressionSelection(_target),
                      onRemoveCardTapped: () =>
                          _showDialogRemoveTarget(_target.id),
                      onEditCardTapped: () =>
                          _showEditTargetDialog(context, _target.id),
                    );
                  },
                  padding: EdgeInsets.only(top: 16, bottom: 108),
                ),
              ),
              _buildAddButton(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildAddButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 108,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RoundBorderedButton(
              onTap: () => _showAddNewTargetDialog(context),
              child: SvgPicture.asset('assets/images/plus.svg'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectTargetTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, bottom: 16.0),
      child: StyledText(
        // todo
        'Выбор цели',
        fontSize: 32,
        color: AppColors.VIOLET,
      ),
    );
  }

  void _openImpressionSelection(VisualizationTarget _target) {
    _controller.loadImages(_target.tag, _target.id);
    _controller.selectedTargetId = _target.id;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VisualizationImpressionImagePage(),
      ),
    );
  }

  _showAddNewTargetDialog(
    BuildContext context,
  ) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddNewTargetDialog(),
    );
  }

  _showEditTargetDialog(BuildContext context, int targetId) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddNewTargetDialog(
        targetId: targetId,
      ),
    );
  }

  // TODO tr
  _showDialogRemoveTarget(int targetId) {
    Get.dialog(
      AlertDialog(
        title: Text("Удалить созданную цель?"),
        // content: Text(""),
        actions: <Widget>[
          FlatButton(
            child: Text("Отмена"),
            onPressed: () {
              Get.back();
            },
          ),
          FlatButton(
            child: Text("Удалить"),
            onPressed: () {
              _controller.removeTarget(targetId);
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
