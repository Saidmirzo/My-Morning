import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:morningmagic/core/network/network_info.dart';
import 'package:morningmagic/features/visualization/domain/entities/image_tag.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_image_repository.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class VisualizationImageRepositoryImpl implements VisualizationImageRepository {
  NetworkInfo networkInfo =
      NetworkInfoImpl(dataConnectionChecker: DataConnectionChecker());

  static const String IMAGE_CACHE_DIR_SEGMENT = 'imageAssets';

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
    // Отказались от хранения ссылок в Firebase storage
    // т.к. у некоторых пользователей получение этих ссылок занмало много времени
    Map<String, List<String>> _map = {
      EnumToString.convertToString(VisualizationImageTag.success): [
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-breakingpic-3188-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-ekrulila-2292837-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-magda-ehlers-2606600-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-movoyagee-2413661.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-pixabay-271681-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-taryn-elliott-4099354-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-vlada-karpovich-7903180-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-wendy-wei-1916821%20(1)-min.jpg'
      ],
      EnumToString.convertToString(VisualizationImageTag.family): [
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-binyamin-mellish-1396122-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-brett-sayles-1708601-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-olle-988622-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-oleg-magni-1837603-min.jpg'
      ],
      EnumToString.convertToString(VisualizationImageTag.nature): [
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-flickr-146083.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-ian-beckley-2792157-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-louis-3690511.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-trace-hudson-2724664%20(1)-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-yaroslav-shuraev-1834399-min.jpg'
      ],
      EnumToString.convertToString(VisualizationImageTag.rest): [
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-pixabay-266436-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-rachel-claire-4825701-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-vincent-gerbouin-1179156.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-vincent-rivaud-2363807-min.jpg'
      ],
      EnumToString.convertToString(VisualizationImageTag.sport): [
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-ian-beckley-2792157-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-pixabay-358042-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-pixabay-390051.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-riccardo-bresciani-303040-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-tyler-hendy-54123-min.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-tyler-tornberg-1635086.jpg',
        'https://storage.yandexcloud.net/myaudio/Visualisation/pexels-nataliya-vaitkevich-6120392-min.jpg'
      ],
    };

    await Future.forEach(_map[imageTag], (String url) async {
      var _file = await DefaultCacheManager().getSingleFile(url);
      if (_file == null) {
        _result.add(VisualizationNetworkImage(path: url, isDefault: true));
      } else {
        _result.add(VisualizationFileSystemImage(
            path: _file.path, file: _file, isDefault: true));
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
