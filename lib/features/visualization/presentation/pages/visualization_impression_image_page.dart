// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/styled_text.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/presentation/controller/visualization_controller.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_target_page.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_timer_page.dart';
import 'package:morningmagic/features/visualization/presentation/widgets/round_bordered_button.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class VisualizationImpressionImagePage extends StatelessWidget {
  final _controller = Get.find<VisualizationController>();

  VisualizationImpressionImagePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSelectImpressionTitle(context),
          Obx(() {
            if (_controller.isImagesDownloading.value) {
              return _buildLoading();
            } else {
              return Expanded(
                child: Column(
                  children: [
                    _buildImageCounter(),
                    _buildImageGrid(),
                  ],
                ),
              );
            }
          }),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VisualizationTargetPage()),
                  )
                },
                'assets/images/arrow_back.svg',
              ),
              _buildActionButton(
                () async => {
                  await _loadAssets(context),
                },
                'assets/images/plus.svg',
              ),
              Obx(
                () => Opacity(
                  opacity:
                      (_controller.selectedImageIndexes.isEmpty) ? 0.3 : 1.0,
                  child: _buildActionButton(
                    () {
                      if (_controller.selectedImageIndexes.isEmpty) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VisualizationTimerPage(),
                        ),
                      );
                    },
                    'assets/images/arrow_forward.svg',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Obx _buildImageCounter() {
    return Obx(() {
      if (_controller.selectedImagesCount > 0) {
        return StyledText(
          _controller.selectedImagesCount.toString(),
          fontSize: 28,
        );
      } else {
        return Container(
          height: 28,
        );
      }
    });
  }

  Expanded _buildImageGrid() {
    return Expanded(
      child: GridView.builder(
        itemCount: _controller.images.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => _controller.toggleImageSelected(index),
          child: Obx(
            () => Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: (_controller.selectedImageIndexes.contains(index))
                    ? Border.all(color: AppColors.violet, width: 2.5)
                    : null,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: _buildImage(index)),
                  if (!_controller.images[index].isDefault &&
                      _controller.selectedImageIndexes.contains(index))
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => _showDialogRemoveImageSelection(index),
                        // onTap: () => _controller.toggleImageSelected(index),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(
                            'assets/images/remove_target.svg',
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Expanded(
        child: Center(
          child: SizedBox(
            width: 64,
            height: 64,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.violet),
            ),
          ),
        ),
      );

  Widget _buildImage(int index) {
    final _image = _controller.images[index];

    switch (_image.runtimeType) {
      case VisualizationAssetImage:
        print('_buildImage VisualizationAssetImage');
        return Image.asset(
          _image.path,
          fit: BoxFit.cover,
        );
        break;
      case VisualizationGalleryImage:
        print('_buildImage VisualizationGalleryImage');
        return AssetThumb(
          width: 150,
          height: 150,
          asset: (_image as VisualizationGalleryImage).pickedAsset,
        );
        break;
      case VisualizationFileSystemImage:
        print('_buildImage VisualizationFileSystemImage');
        return Image.file(
          (_image as VisualizationFileSystemImage).file,
          fit: BoxFit.cover,
          width: 150,
          height: 150,
          cacheWidth: 150,
          cacheHeight: 150,
          filterQuality: FilterQuality.low,
          scale: 1.0,
        );
        break;
      case VisualizationNetworkImage:
        print('_buildImage VisualizationNetworkImage');
        return Image.network(
          (_image as VisualizationNetworkImage).path,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.violet),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        );
        break;
      default:
        throw UnsupportedError('unknown image type');
    }
  }

  Widget _buildSelectImpressionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, bottom: 16.0),
      child: StyledText(
        'impression_selection'.tr,
        fontSize: 32,
        color: AppColors.violet,
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

  _showDialogRemoveImageSelection(int index) {
    Get.dialog(
      AlertDialog(
        title: Text('remove_image'.tr),
        // content: Text(""),
        actions: <Widget>[
          TextButton(
            child: Text('cancellation'.tr),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text('delete'.tr),
            onPressed: () {
              _controller.removePickedImage(index);
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
