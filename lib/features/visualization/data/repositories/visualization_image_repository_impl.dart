import 'dart:async';
import 'dart:io';

import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_image_repository.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class VisualizationImageRepositoryImpl implements VisualizationImageRepository {
  Directory _tempAssetsDir;

  String get imageCacheDirPath => _tempAssetsDir.path;

  @override
  Future<List<VisualizationImage>> getVisualizationImages(String tag) async {
    List<VisualizationImage> _resultImages = [];

    final _defaultImages = _getDefaultImages(tag);
    final _cachedImages = await _getCachedImages();

    _resultImages.addAll(_defaultImages);
    _resultImages.addAll(_cachedImages);

    return _resultImages;
  }

  Future<List<VisualizationImage>> _getCachedImages() async {
    final _tempAppDir = await syspaths.getTemporaryDirectory();
    String _tempAssetsDirPath = _tempAppDir.path + '/imageAssets';
    bool _isTempAssetDirExists = await Directory(_tempAssetsDirPath).exists();

    List<VisualizationImage> _result = [];

    if (_isTempAssetDirExists) {
      _tempAssetsDir = Directory(_tempAssetsDirPath);
      List<VisualizationImage> _imagesFromTempDirectory = _tempAssetsDir
          .listSync()
          .map((file) => VisualizationFileSystemImage(
              path: file.path, file: File(file.path)))
          .toList();

      _result.addAll(_imagesFromTempDirectory);
    } else {
      _tempAssetsDir = await _createImageTempDirectory(_tempAssetsDirPath);
    }
    return _result;
  }

  // TODO get from network
  List<VisualizationImage> _getDefaultImages(String imageTag) {
    List<VisualizationImage> _result = [];

    switch (imageTag) {
      case 'success': //success
        _result = [
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/success/success1.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/success/success2.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/success/success3.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/success/success4.jpg',
          ),
        ];
        break;
      case 'family': //family
        _result = [
          VisualizationAssetImage(
              path: 'assets/images/visualization_images/family/family1.jpg'),
          VisualizationAssetImage(
              path: 'assets/images/visualization_images/family/family2.jpg'),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/family/family3.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/family/family4.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/family/family5.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/family/family6.jpg',
          ),
        ];
        break;
      case 'nature': //nature
        _result = [
          VisualizationAssetImage(
              path: 'assets/images/visualization_images/nature/nature1.jpg'),
          VisualizationAssetImage(
              path: 'assets/images/visualization_images/nature/nature2.jpg'),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/nature/nature3.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/nature/nature4.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/nature/nature5.jpg',
          ),
        ];
        break;
      case 'rest': //rest
        _result = [
          VisualizationAssetImage(
              path: 'assets/images/visualization_images/rest/rest1.jpg'),
          VisualizationAssetImage(
              path: 'assets/images/visualization_images/rest/rest2.jpg'),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/rest/rest3.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/rest/rest4.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/rest/rest5.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/rest/rest6.jpg',
          ),
        ];
        break;
      case 'sport': //sport
        _result = [
          VisualizationAssetImage(
              path: 'assets/images/visualization_images/sport/sport1.jpg'),
          VisualizationAssetImage(
              path: 'assets/images/visualization_images/sport/sport2.jpg'),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/sport/sport3.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/sport/sport4.jpg',
          ),
          VisualizationAssetImage(
            path: 'assets/images/visualization_images/sport/sport5.jpg',
          ),
        ];
        break;
      default:
    }
    return _result;
  }

  @override
  Future<List<VisualizationImage>> getPickedFromGalleryImages(
      List<Asset> assetImages) async {
    final List<VisualizationImage> _visualizationImagesFromGallery = [];

    for (Asset asset in assetImages) {
      final _byteData = await asset.getByteData();
      final _galleryImage = VisualizationGalleryImage(
          path: '$imageCacheDirPath/${asset.name}',
          pickedAsset: asset,
          byteData: _byteData);
      _visualizationImagesFromGallery.add(_galleryImage);

      _saveAssetInTemporaryDirectory(asset);
    }

    return _visualizationImagesFromGallery;
  }

  _saveAssetInTemporaryDirectory(Asset asset) async {
    print('save image in temp dir = $imageCacheDirPath/${asset.name}');
    final assetByteData = await asset.getByteData();
    File file = File('$imageCacheDirPath/${asset.name}');
    await file.writeAsBytes(assetByteData.buffer.asUint8List());
  }

  Future<Directory> _createImageTempDirectory(String path) async {
    print('create temp image directory $_tempAssetsDir');
    return Directory(path).create();
  }

  // ignore: unused_element
  _removeImageTempDirectory() {
    final _imageTempDirectory = Directory(imageCacheDirPath);
    print('remove image cache directory $imageCacheDirPath');
    _imageTempDirectory.delete(recursive: true);
  }
}
