import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_timer_page.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class VisualizationImpressionImagePage extends StatelessWidget {
  final _controller = Get.find<VisualizationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildSelectImpressionTitle(context),
        Obx(() {
          if (_controller.isImagesDownloading.value) {
            return _buildLoading();
          } else
            return Expanded(
              child: Column(
                children: [
                  _buildImageCounter(),
                  _buildImageGrid(),
                ],
              ),
            );
        }),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(
                () => {Navigator.pop(context)}, 'assets/images/arrow_back.svg'),
            _buildActionButton(() async => {await _loadAssets(context)},
                'assets/images/plus.svg'),
            Obx(() => Opacity(
                  opacity:
                      (_controller.selectedImageIndexes.isEmpty) ? 0.3 : 1.0,
                  child: _buildActionButton(() {
                    if (_controller.selectedImageIndexes.isEmpty) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => VisualizationTimerPage()));
                  }, 'assets/images/arrow_forward.svg'),
                )),
          ],
        ),
      ]),
    );
  }

  Obx _buildImageCounter() {
    return Obx(() {
      if (_controller.selectedImagesCount > 0)
        return Container(
          child: StyledText(
            _controller.selectedImagesCount.toString(),
            fontSize: 28,
          ),
        );
      else
        return Container(
          height: 28,
        );
    });
  }

  Expanded _buildImageGrid() {
    return Expanded(
      child: Obx(
        () => GridView.builder(
          itemCount: _controller.images.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => _controller.isImageSelected(index)
                ? _showDialogRemoveImageSelection(index)
                : _controller.toggleImageSelected(index),
            child: Obx(() => Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: (_controller.selectedImageIndexes.contains(index))
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
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: _buildImage(index)),
                      if (_controller.selectedImageIndexes.contains(index))
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => _showDialogRemoveImageSelection(index),
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
    );
  }

  Widget _buildLoading() => Expanded(
          child: Center(
              child: Container(
        width: 64,
        height: 64,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.VIOLET),
        ),
      )));

  Widget _buildImage(int index) {
    final _image = _controller.images[index];

    switch (_image.runtimeType) {
      case VisualizationAssetImage:
        return Image.asset(
          _image.path,
          fit: BoxFit.cover,
        );
        break;
      case VisualizationGalleryImage:
        return AssetThumb(
          width: 150,
          height: 150,
          asset: (_image as VisualizationGalleryImage).pickedAsset,
        );
        break;
      case VisualizationFileSystemImage:
        return Image.file(
          (_image as VisualizationFileSystemImage).file,
          fit: BoxFit.cover,
        );
        break;
      case VisualizationNetworkImage:
        return Image.network(
          (_image as VisualizationNetworkImage).path,
          fit: BoxFit.cover,
        );
        break;
      default:
        throw new UnsupportedError('unknown image type');
    }
  }

  Widget _buildSelectImpressionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, bottom: 16.0),
      child: StyledText(
        // todo translation
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

  Future<void> _loadAssets(BuildContext context) async {
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
      );
      _controller.addImageAssetsFromGallery(resultList);
    } on Exception catch (e) {
      print(e);
      Get.snackbar('Image load error:', ' $e');
    }
  }

  // TODO transl
  _showDialogRemoveImageSelection(int index) {
    Get.dialog(
      AlertDialog(
        title: Text("Отменить выбор?"),
        // content: Text(""),
        actions: <Widget>[
          FlatButton(
            child: Text("Отмена"),
            onPressed: () {
              Get.back();
            },
          ),
          FlatButton(
            child: Text("Продолжить"),
            onPressed: () {
              _controller.toggleImageSelected(index);
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
