import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_timer_page.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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
          child: Obx(
            () => GridView.builder(
              itemCount: _controller.images.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _controller.toggleImageSelected(index),
                child: Obx(() => Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: (_controller.selectedImageIndexes
                                  .contains(index))
                              ? Border.all(color: AppColors.VIOLET, width: 2.5)
                              : null,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                      child: Stack(
                        // clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: _buildImage(index)),
                          if (_controller.selectedImageIndexes.contains(index))
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () =>
                                    _controller.toggleImageSelected(index),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SvgPicture.asset(
                                    'assets/images/remove_target.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    )),
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
            _buildActionButton(
                () async => {await loadAssets()}, 'assets/images/plus.svg'),
            _buildActionButton(
                () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => VisualizationTimerPage()))
                    },
                'assets/images/arrow_forward.svg'),
          ],
        ),
      ]),
    );
  }

  Widget _buildImage(int index) {
    final _image = _controller.images[index];

    if (_image.fromGallery)
      return AssetThumb(
        width: 300,
        height: 300,
        asset: _image.asset,
      );
    else
      return Image.asset(
        _image.assetPath,
        fit: BoxFit.cover,
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

  Future<void> loadAssets() async {
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
      );
      if (!mounted) return;
      _controller.addImageAssetsFromGallery(resultList);
    } on Exception catch (e) {
      print(e);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Image load error: ${e}')));
    }
  }
}
