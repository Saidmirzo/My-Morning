import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:morningmagic/core/network/network_info.dart';
import 'package:morningmagic/features/visualization/data/firebase/firebase_cache_manager.dart';
import 'package:morningmagic/features/visualization/domain/entities/image_tag.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_image_repository.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class VisualizationImageRepositoryImpl implements VisualizationImageRepository {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  NetworkInfo networkInfo =
      NetworkInfoImpl(dataConnectionChecker: DataConnectionChecker());

  static const String IMAGE_CACHE_DIR_SEGMENT = 'imageAssets';
  static const String FIRE_STORE_DATABASE_REF = 'visualization_images';

  Directory _tempAssetsDir;

  String get imageCacheDirPath => _tempAssetsDir.path;

  @override
  Future<List<VisualizationImage>> getVisualizationImages(
      String tag, int targetId) async {
    List<VisualizationImage> _resultImages = [];

    bool _isConnected = await networkInfo.isConnected;

    if (!_isCustomTarget(tag) && _isConnected) {
      final _defaultImages = await _getDefaultImages(tag);
      _resultImages.addAll(_defaultImages);
    }

    final _cachedPickedImages = await _getCachedPickedImages(targetId);

    _resultImages.addAll(_cachedPickedImages);

    return _resultImages;
  }

  @override
  Future<void> cachePickedFromGalleryAssets(
      List<Asset> assetImages, int targetId) async {
    final _tempAppDir = await syspaths.getTemporaryDirectory();

    //create root directory if not exists
    await _getDirectory('${_tempAppDir.path}/$IMAGE_CACHE_DIR_SEGMENT');

    final _imagesCacheDirectory = await _getDirectory(
        '${_tempAppDir.path}/$IMAGE_CACHE_DIR_SEGMENT/$targetId');

    for (Asset asset in assetImages) {
      final assetByteData = await asset.getByteData();
      final file = File('${_imagesCacheDirectory.path}/${asset.name}');
      await file.writeAsBytes(assetByteData.buffer.asUint8List());
    }
  }

  @override
  Future<void> removeCachedPickedImage(VisualizationImage image) async {
    if (!image.isDefault) {
      try {
        if (image is VisualizationFileSystemImage) {
          await image.file.delete();
        }
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  Future<List<VisualizationImage>> _getDefaultImages(String imageTag) async {
    List<VisualizationImage> _result = [];

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/$FIRE_STORE_DATABASE_REF/$imageTag');

    firebase_storage.ListResult result = await ref.listAll();

    await Future.forEach(result.items, (firebase_storage.Reference ref) async {
      var _fileInfo = await FirebaseCacheManager().getFileFromCache(ref.name);

      if (_fileInfo == null) {
        final _url = await ref.getDownloadURL();
        _result.add(VisualizationNetworkImage(path: _url, isDefault: true));
        FirebaseCacheManager().downloadFile(
            '/$FIRE_STORE_DATABASE_REF/$imageTag/${ref.name}',
            key: ref.name);
      } else {
        _result.add(VisualizationFileSystemImage(
            path: _fileInfo.file.path, file: _fileInfo.file, isDefault: true));
      }
    });

    return Future.value(_result);
  }

  Future<List<VisualizationImage>> _getCachedPickedImages(int targetId) async {
    List<VisualizationImage> _result = [];
    final _tempAppDir = await syspaths.getTemporaryDirectory();
    final _imagesCacheDirectory =
        Directory('${_tempAppDir.path}/$IMAGE_CACHE_DIR_SEGMENT/$targetId');

    if (!(await _imagesCacheDirectory.exists())) return _result;

    List<VisualizationImage> _imagesFromTempDirectory = _imagesCacheDirectory
        .listSync()
        .map((file) => VisualizationFileSystemImage(
            path: file.path, file: File(file.path), isDefault: false))
        .toList();

    _result.addAll(_imagesFromTempDirectory);

    return _result;
  }

  Future<Directory> _getDirectory(String path) async {
    final _directory = Directory(path);

    if (await _directory.exists())
      return _directory;
    else
      return await _createDirectory(path);
  }

  Future<Directory> _createDirectory(String path) async {
    return Directory(path).create();
  }

  bool _isCustomTarget(String tag) =>
      tag == EnumToString.convertToString(VisualizationImageTag.custom);
}
