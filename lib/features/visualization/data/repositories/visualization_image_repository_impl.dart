import 'dart:async';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:morningmagic/features/visualization/domain/entities/image_tag.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_image_repository.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class VisualizationImageRepositoryImpl implements VisualizationImageRepository {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static const String IMAGE_CACHE_DIR_SEGMENT = '/imageAssets';

  Directory _tempAssetsDir;

  String get imageCacheDirPath => _tempAssetsDir.path;

  @override
  Future<List<VisualizationImage>> getVisualizationImages(String tag) async {
    List<VisualizationImage> _resultImages = [];

    await _getImageCacheDirectory(); //create directory if not exists

    final _defaultImages = await _getDefaultImages(tag);
    final _cachedPickedImages = await _getCachedPickedImages();

    _resultImages.addAll(_defaultImages);
    _resultImages.addAll(_cachedPickedImages);

    return _resultImages;
  }

  Future<List<VisualizationImage>> _getDefaultImages(String imageTag) async {
    if (imageTag == EnumToString.convertToString(VisualizationImageTag.custom))
      return Future.value([]);

    final _cachedDefaultImages = await _getCachedDefaultImages(imageTag);

    if (_cachedDefaultImages.isEmpty) {
      return await _getDownloadedFromNetworkImages(imageTag);
    } else {
      return _cachedDefaultImages;
    }
  }

  Future<List<VisualizationImage>> _getCachedDefaultImages(
      String imageTag) async {
    List<VisualizationImage> _result = [];

    final _tempAppDir = await syspaths.getTemporaryDirectory();
    String _defaultImageDirPath =
        '${_tempAppDir.path}$IMAGE_CACHE_DIR_SEGMENT/$imageTag';

    bool _isDirectoryExists = await Directory(_defaultImageDirPath).exists();

    if (_isDirectoryExists) {
      final _imageDirectory = Directory(_defaultImageDirPath);
      List<VisualizationImage> _cachedImages = _imageDirectory
          .listSync()
          .map((file) => VisualizationFileSystemImage(
              path: file.path, file: File(file.path)))
          .toList();

      _result.addAll(_cachedImages);
    }

    return Future.value(_result);
  }

  Future<List<VisualizationImage>> _getDownloadedFromNetworkImages(
      String imageTag) async {
    List<VisualizationImage> _result = [];
    List<String> _urls = [];

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/visualization_images/$imageTag');

    firebase_storage.ListResult result = await ref.listAll();

    await Future.forEach(result.items, (firebase_storage.Reference ref) async {
      final _url = await ref.getDownloadURL();
      print(_url);
      _urls.add(_url);
    });

    // TODO make and try catch
    final _tempAppDir = await syspaths.getTemporaryDirectory();
    String _defaultImageDirPath =
        '${_tempAppDir.path}$IMAGE_CACHE_DIR_SEGMENT/$imageTag';

    bool _isDirectoryExists = await Directory(_defaultImageDirPath).exists();

    if (!_isDirectoryExists) await _createDirectory(_defaultImageDirPath);

    await Future.forEach(_urls, (url) async {

      var imageId = await ImageDownloader.downloadImage(url,
          destination:
          AndroidDestinationType.custom(directory: _defaultImageDirPath)..inExternalFilesDir());
      if (imageId == null) {
        return;
      }

      var _path = await ImageDownloader.findPath(imageId);
      _result
          .add(VisualizationFileSystemImage(path: _path, file: File(_path)));

      // try {
      // } on PlatformException catch (error) {
      //   print(error);
      // }
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

      _cachePickedAssets(asset);
    }

    return _visualizationImagesFromGallery;
  }

  _cachePickedAssets(Asset asset) async {
    print('save image in temp dir = $imageCacheDirPath/${asset.name}');
    final assetByteData = await asset.getByteData();
    File file = File('$imageCacheDirPath/${asset.name}');
    await file.writeAsBytes(assetByteData.buffer.asUint8List());
  }

  Future<List<VisualizationImage>> _getCachedPickedImages() async {
    final _tempAppDir = await syspaths.getTemporaryDirectory();
    String _tempAssetsDirPath = _tempAppDir.path + '$IMAGE_CACHE_DIR_SEGMENT';
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
      _tempAssetsDir = await _createDirectory(_tempAssetsDirPath);
    }
    return _result;
  }

  Future <Directory> _getImageCacheDirectory() async {
    if (_tempAssetsDir == null) {
      final _tempAppDir = await syspaths.getTemporaryDirectory();
      String _tempAssetsDirPath = _tempAppDir.path + '$IMAGE_CACHE_DIR_SEGMENT';
      bool _isTempAssetDirExists = await Directory(_tempAssetsDirPath).exists();

      if (!_isTempAssetDirExists) {
        _tempAssetsDir =  await _createDirectory(_tempAssetsDirPath);
      } else _tempAssetsDir = Directory(_tempAssetsDirPath);
    }

    return _tempAssetsDir;
  }

  Future<Directory> _createDirectory(String path) async {
    print('create temp image directory $path');
    return Directory(path).create();
  }

  // ignore: unused_element
  _removeImageCacheDirectory() {
    final _imageTempDirectory = Directory(imageCacheDirPath);
    print('remove image cache directory $imageCacheDirPath');
    _imageTempDirectory.delete(recursive: true);
  }
}
