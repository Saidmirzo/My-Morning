import 'dart:async';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:morningmagic/features/visualization/domain/entities/image_tag.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_image_repository.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class VisualizationImageRepositoryImpl implements VisualizationImageRepository {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Directory _tempAssetsDir;

  String get imageCacheDirPath => _tempAssetsDir.path;

  @override
  Future<List<VisualizationImage>> getVisualizationImages(String tag) async {
    List<VisualizationImage> _resultImages = [];

    final _defaultImages = await _getDefaultImages(tag);
    final _cachedImages = await _getCachedPickedImages();

    _resultImages.addAll(_defaultImages);
    _resultImages.addAll(_cachedImages);

    return _resultImages;
  }

  Future<List<VisualizationImage>> _getCachedPickedImages() async {
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

  Future<List<VisualizationImage>> _getDefaultImages(String imageTag) async {
    
    if (imageTag == EnumToString.convertToString(VisualizationImageTag.custom)) return Future.value([]);
    
    final _cachedDefaultImages = await _getCachedDefaultImages(imageTag);
    
    if (_cachedDefaultImages.isEmpty) {
      return await _getDownloadedFromNetworkImages(imageTag);
    } else {
      return _cachedDefaultImages;
    }
  }


  Future<List<VisualizationImage>> _getCachedDefaultImages(String imageTag) {
    // TODO get from directory by imageTag in path

    List<VisualizationImage> _result = [];

    return Future.value(_result);
  }

  Future<List<VisualizationImage>> _getDownloadedFromNetworkImages(String imageTag) async {

    List<VisualizationImage> _result = [];

    // TODO 1) download from network  2) cache
    
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/visualization_images/$imageTag');

    firebase_storage.ListResult result = await ref.listAll();

    // TODO cache downloaded images
    await Future.forEach(result.items, (firebase_storage.Reference ref) async {
      final _url = await ref.getDownloadURL();
      print(_url);
      _result.add(VisualizationNetworkImage(path: _url));
    });
    return Future.value(_result);
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
