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
  NetworkInfo networkInfo = NetworkInfoImpl(dataConnectionChecker: DataConnectionChecker());

  static const String IMAGE_CACHE_DIR_SEGMENT = 'imageAssets';

  Directory _tempAssetsDir;

  String get imageCacheDirPath => _tempAssetsDir.path;

  @override
  Future<List<VisualizationImage>> getVisualizationImages(String tag, int targetId) async {
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
  Future<void> cachePickedFromGalleryAssets(List<Asset> assetImages, int targetId) async {
    final _tempAppDir = await syspaths.getTemporaryDirectory();

    //create root directory if not exists
    await _getDirectory('${_tempAppDir.path}/$IMAGE_CACHE_DIR_SEGMENT');

    final _imagesCacheDirectory = await _getDirectory('${_tempAppDir.path}/$IMAGE_CACHE_DIR_SEGMENT/$targetId');

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
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsuccess%2Fsuccess1.jpg?alt=media&token=c663b0c4-71bd-4b4a-8297-5c21375f170a',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsuccess%2Fsuccess2.jpg?alt=media&token=889780b3-dd96-4d30-8c99-075809ae89b8',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsuccess%2Fsuccess3.jpg?alt=media&token=70f1dbdc-058b-4a36-b668-2f98568b1bee',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsuccess%2Fsuccess4.jpg?alt=media&token=09b9cee8-2f2e-4978-9cce-b21cae6dfefb',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsuccess%2Fsuccess5.jpg?alt=media&token=38875e6c-c87e-4991-b2fc-79f78b76ce75',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsuccess%2Fsuccess6.jpg?alt=media&token=8a46d33a-b777-44ae-8306-e8988752ba99',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsuccess%2Fsuccess7.jpg?alt=media&token=0fa49aab-d23b-4d5c-a2a4-df3f7a6db03f',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsuccess%2Fsuccess8.jpg?alt=media&token=825bd46e-2e9f-4ee6-b375-6f6d82ad01b4',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsuccess%2Fsuccess9.jpg?alt=media&token=8593acd9-ac1c-45df-b872-c4b74a289467',
      ],
      EnumToString.convertToString(VisualizationImageTag.family): [
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Ffamily%2Ffamily1.jpg?alt=media&token=0e1201ab-7ae5-46ed-814d-3b6b53c0873f',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Ffamily%2Ffamily2.jpg?alt=media&token=2427df23-d2d5-4862-b140-9dbe1aa9b0fc',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Ffamily%2Ffamily3.jpg?alt=media&token=5b38cc8d-9eba-42f0-9d98-c9219f5c703f',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Ffamily%2Ffamily4.jpg?alt=media&token=c735475f-06c1-4747-9842-994f033868a7',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Ffamily%2Ffamily5.jpg?alt=media&token=8e0b553b-3653-4ad2-91ce-5adf0393330d',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Ffamily%2Ffamily6.jpg?alt=media&token=07fd8226-fddb-4adc-86f1-9ac1f3f6ff87',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Ffamily%2Ffamily7.jpg?alt=media&token=68db7112-d2d4-4925-9817-acfd713ea2a5',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Ffamily%2Ffamily8.jpg?alt=media&token=976fee98-a08b-449c-b436-bc141b5324d6',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Ffamily%2Ffamily9.jpg?alt=media&token=9d7c84cf-3d00-4a79-8fa5-73ddc36e39d4',
      ],
      EnumToString.convertToString(VisualizationImageTag.nature): [
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fnature%2Fnature1.jpg?alt=media&token=7f6cdd76-7f72-40ad-955f-b66b2fea4a6c',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fnature%2Fnature2.jpg?alt=media&token=fa813813-fe46-4700-bc2c-8a5cacbf917d',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fnature%2Fnature3.jpg?alt=media&token=179cfbf5-f23c-4eed-9227-de40be764c00',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fnature%2Fnature4.jpg?alt=media&token=29c2db4d-0663-41d7-9f62-c266cfce51c8',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fnature%2Fnature5.jpg?alt=media&token=ba0cba5b-a4e7-48cb-b953-bf7028d2eb40',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fnature%2Fnature6.jpg?alt=media&token=f8d1e93d-9a96-4842-aab2-a8acd965dd43',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fnature%2Fnature7.jpg?alt=media&token=2fc9f7c6-b59a-42ab-af15-864dac4c8cf9',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fnature%2Fnature8.jpg?alt=media&token=e2534775-6790-4a89-9230-a24bbe8a2573',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fnature%2Fnature9.jpg?alt=media&token=7134793a-db9b-4bb3-8bf9-ae1993083a44'
      ],
      EnumToString.convertToString(VisualizationImageTag.rest): [
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Frest%2Frest1.jpg?alt=media&token=d8e23f2a-34dc-4c42-8b74-0aa9cf5efbdb',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Frest%2Frest2.jpg?alt=media&token=7aa6de9d-27ab-4481-bd7a-f4cab9d364e9',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Frest%2Frest3.jpg?alt=media&token=c9c9b7f9-29d8-48ff-af81-90579464fa40',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Frest%2Frest4.jpg?alt=media&token=61844196-abdf-402f-8a59-f1736040d2b3',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Frest%2Frest5.jpg?alt=media&token=20f4d915-c836-477d-92bc-d408d92613b6',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Frest%2Frest6.jpg?alt=media&token=5df8c14f-c16d-4165-a480-c49e5f4c5d83',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Frest%2Frest7.jpg?alt=media&token=74252ecf-e2f1-47ba-a1b3-7c83fee184c0',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Frest%2Frest8.jpg?alt=media&token=6b1d82e3-e32a-47c8-baec-da932ae3bd45',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Frest%2Frest9.jpg?alt=media&token=9ee45bdb-02aa-422c-8c7f-33a2e0f5c513',
      ],
      EnumToString.convertToString(VisualizationImageTag.sport): [
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsport%2Fsport1.jpg?alt=media&token=1d735181-0f74-4040-a8ac-f0d93bb35d03',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsport%2Fsport2.jpg?alt=media&token=8c2ca1b7-e89b-4df6-83ae-888b0bc2fdaf',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsport%2Fsport3.jpg?alt=media&token=e76c5bc1-90d2-4b96-a376-17b7cb260952',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsport%2Fsport4.jpg?alt=media&token=a0eadccf-213f-4c37-b697-d1f7897dcd71',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsport%2Fsport5.jpg?alt=media&token=5d46bebd-9b59-4e50-95f4-6353390059d8',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsport%2Fsport6.jpg?alt=media&token=a0a3faf5-9e1b-40ec-8e1b-612df9bd1c32',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsport%2Fsport7.jpg?alt=media&token=8eba1837-58ce-42e9-9f7d-0b92375162db',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsport%2Fsport8.jpg?alt=media&token=5d425501-6089-4ee3-96a9-cc1fea391c1c',
        'https://firebasestorage.googleapis.com/v0/b/my-morning-b0697.appspot.com/o/visualization_images%2Fsport%2Fsport9.jpg?alt=media&token=f4f124fe-0fbb-486f-b043-da4899a0ef61',
      ],
    };

    await Future.forEach(_map[imageTag], (String url) async {
      var _file = await DefaultCacheManager().getSingleFile(url);
      if (_file == null) {
        _result.add(VisualizationNetworkImage(path: url, isDefault: true));
      } else {
        _result.add(VisualizationFileSystemImage(path: _file.path, file: _file, isDefault: true));
      }
    });

    return Future.value(_result);
  }

  Future<List<VisualizationImage>> _getCachedPickedImages(int targetId) async {
    List<VisualizationImage> _result = [];
    final _tempAppDir = await syspaths.getTemporaryDirectory();
    final _imagesCacheDirectory = Directory('${_tempAppDir.path}/$IMAGE_CACHE_DIR_SEGMENT/$targetId');

    if (!(await _imagesCacheDirectory.exists())) return _result;

    List<VisualizationImage> _imagesFromTempDirectory = _imagesCacheDirectory.listSync().map((file) => VisualizationFileSystemImage(path: file.path, file: File(file.path), isDefault: false)).toList();

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

  bool _isCustomTarget(String tag) => tag == EnumToString.convertToString(VisualizationImageTag.custom);
}
