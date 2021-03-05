import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:morningmagic/features/visualization/domain/entities/image_tag.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/resources/colors.dart';

class VisualizationTargetItem extends StatefulWidget {
  final VisualizationTarget target;
  final VoidCallback onCardTapped;
  final VoidCallback onRemoveCardTapped;
  final VoidCallback onEditCardTapped;

  const VisualizationTargetItem({
    Key key,
    @required this.target,
    @required this.onCardTapped,
    @required this.onRemoveCardTapped,
    @required this.onEditCardTapped,
  }) : super(key: key);

  @override
  _VisualizationTargetItemState createState() =>
      _VisualizationTargetItemState();
}

class _VisualizationTargetItemState extends State<VisualizationTargetItem> {
  final _controller = Get.find<VisualizationController>();
  bool isLoading = false;
  VisualizationImage attachedImage;

  @override
  void initState() {
    super.initState();

    if (widget.target.tag ==
        EnumToString.convertToString(VisualizationImageTag.custom)) {
      setState(() {
        isLoading = true;
      });

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        final _images =
            await _controller.loadAttachedTargetImages(widget.target.id);
        if (_images.isNotEmpty) attachedImage = _images.first;

        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return _buildLoading();
    else
      return _buildContent();
  }

  Widget _buildLoading() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 2),
        child: Container(
            height: 94,
            child: Center(
                child: Container(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.VIOLET),
              ),
            ))),
      );

  Widget _buildContent() => InkWell(
        onTap: widget.onCardTapped,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 2),
          child: Container(
            height: 94,
            decoration: _buildBoxDecoration(widget.target),
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  widget.target.title,
                  style: TextStyle(color: AppColors.WHITE, fontSize: 32),
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.target.isCustom)
                      InkWell(
                        onTap: () => widget.onRemoveCardTapped,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                              'assets/images/remove_target.svg'),
                        ),
                      ),
                    IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: widget.onEditCardTapped)
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  BoxDecoration _buildBoxDecoration(
    VisualizationTarget _target,
  ) {
    final _borderRadius = BorderRadius.circular(10);
    if (_target.isCustom) {
      if (attachedImage != null) {
        return BoxDecoration(
            borderRadius: _borderRadius,
            image: DecorationImage(
              image: _controller.getTargetCoverDecorationImage(attachedImage),
              fit: BoxFit.cover,
            ));
      } else
        return BoxDecoration(borderRadius: _borderRadius, color: Colors.grey);
    } else
      return BoxDecoration(
          borderRadius: _borderRadius,
          image: DecorationImage(
            image: AssetImage(_target.coverAssetPath),
            fit: BoxFit.cover,
          ));
  }
}
