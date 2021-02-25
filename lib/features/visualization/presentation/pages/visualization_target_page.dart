import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_select_impression_page.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/dialogs/add_new_target_dialog.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
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
            child: Obx(() => ListView.builder(
                  itemCount: _controller.targets.length,
                  itemBuilder: (context, index) => _buildTargetItem(index),
                ))),
        _buildAddButton(),
      ]),
    );
  }

  Padding _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RoundBorderedButton(
        onTap: () => _showAddNewTargetDialog(context),
        child: SvgPicture.asset('assets/images/plus.svg'),
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

  BoxDecoration _buildDecoration(VisualizationTarget _target) {
    final _borderRadius = BorderRadius.circular(10);
    if (_target.isCustom) {
      return BoxDecoration(borderRadius: _borderRadius, color: Colors.grey);
    } else
      return BoxDecoration(
          borderRadius: _borderRadius,
          image: DecorationImage(
            image: AssetImage(_target.coverAssetPath),
            fit: BoxFit.cover,
          ));
  }

  Widget _buildTargetItem(int index) {
    final _target = _controller.targets[index];

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VisualizationSelectImpressionPage(targetId: _target.id),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 2),
        child: Container(
          height: 94,
          decoration: _buildDecoration(_target),
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Text(
                _target.title,
                style: TextStyle(color: AppColors.WHITE, fontSize: 32),
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_target.isCustom)
                    InkWell(
                      onTap: () => _controller.removeTarget(_target.id),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            SvgPicture.asset('assets/images/remove_target.svg'),
                      ),
                    ),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          _showEditTargetDialog(context, _target.id))
                ],
              ),
            ],
          ),
        ),
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
}