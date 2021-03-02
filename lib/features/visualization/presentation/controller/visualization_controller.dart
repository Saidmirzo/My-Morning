import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/day/day.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/model/visualization/visualization.dart';
import 'package:morningmagic/db/progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_target_repository.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_success_page.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class VisualizationController extends GetxController {
  static const int TIMER_TICK_DURATION = 1000;

  final VisualizationTargetRepository targetRepository;

  Box _dbBox;

  VisualizationController(Box dbBox, this.targetRepository) {
    _dbBox = dbBox;
  }

  final targets = <VisualizationTarget>[].obs;

  final images = <VisualizationImage>[].obs;

  final List<int> selectedImageIndexes = <int>[].obs;

  var _currentImageIndex = 0.obs;

  var _timeLeft = 0.obs;

  var isTimerActive = false.obs;

  Directory _tempAssetsDir;

  Timer _timer;

  int _initialTimeLeft;

  int selectedTargetId = 0;

  List<VisualizationImage> get selectedImages =>
      selectedImageIndexes.map((index) => images[index]).toList();

  String get imageCacheDirPath => _tempAssetsDir.path;

  String get formattedTimeLeft =>
      StringUtil.getFormattedTimeLeft(_timeLeft.value);

  double get timeLeftValue => 1 - _timeLeft / _initialTimeLeft;

  int get currentImageIndex => (_currentImageIndex >= selectedImages.length)
      ? 0
      : _currentImageIndex.value;

  int get passedTimeSeconds => (_initialTimeLeft - _timeLeft.value) ~/ 1000;

  @override
  void onInit() async {
    super.onInit();
    _getTimeLeftFromPrefs();
    await _initializeTargets();
  }

  @override
  void onClose() {
    super.onClose();
    _saveVisualizationProgress();
  }

  saveVisualization(String text) {
    _dbBox.put(MyResource.VISUALIZATION_KEY, Visualization(text));
  }

  String getVisualizationText() {
    String _visualizationText = '';

    Visualization _visualization = _dbBox.get(MyResource.VISUALIZATION_KEY);

    if (_visualization != null) {
      _visualizationText = _visualization.visualization;
    }

    return _visualizationText;
  }

  Future<List<VisualizationTarget>> getTargets() {
    return targetRepository.getVisualizationTargets();
  }

  saveTarget(String text) {
    final _id = targets.last.id + 1;
    print('saveTarget id = $_id');
    targets.add(VisualizationTarget(id: _id, isCustom: true, title: text));
    targetRepository.saveVisualizationTargets(targets);
  }

  removeTarget(int id) {
    print('removeTarget id = $id');
    targets.removeWhere((element) => element.id == id);
    targetRepository.saveVisualizationTargets(targets);
  }

  updateTarget(int id, String title) {
    print('update target title : $title, id = $id');
    final _oldTarget =
        targets.firstWhere((element) => element.id == id, orElse: () => null);
    final _oldTargetIndex = targets.indexOf(_oldTarget);
    if (_oldTarget != null) {
      final _newTarget = VisualizationTarget(
          id: _oldTarget.id,
          isCustom: _oldTarget.isCustom,
          title: title,
          coverAssetPath: _oldTarget.coverAssetPath);
      targets.replaceRange(_oldTargetIndex, _oldTargetIndex + 1, [_newTarget]);
      targetRepository.saveVisualizationTargets(targets);
    }
  }

  // TODO move to separate repository
  Future initializeImages(int targetId) async {
    _currentImageIndex.value = 0;
    images.clear();
    selectedImageIndexes.clear();

    final _defaultImages = getDefaultImages(targetId);

    images.addAll(_defaultImages);

    final _tempAppDir = await syspaths.getTemporaryDirectory();
    String _tempAssetsDirPath = _tempAppDir.path + '/imageAssets';
    bool _isTempAssetDirExists = await Directory(_tempAssetsDirPath).exists();

    if (_isTempAssetDirExists) {
      _tempAssetsDir = Directory(_tempAssetsDirPath);
      List<VisualizationImage> _imagesFromTempDirectory = _tempAssetsDir
          .listSync()
          .map((file) => VisualizationFileSystemImage(
              path: file.path, file: File(file.path)))
          .toList();
      images.addAll(_imagesFromTempDirectory);
    } else {
      _tempAssetsDir = await _createImageTempDirectory(_tempAssetsDirPath);
    }
  }

  addImageAssetsFromGallery(List<Asset> assetImages) async {
    int oldLastImageIndex = images.length - 1;

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

    images.addAll(_visualizationImagesFromGallery);

    if (_visualizationImagesFromGallery.isNotEmpty) {
      int newLastImageIndex = images.length - 1;
      print(
          'Select picked images oldIndex = $oldLastImageIndex, newIndex = $newLastImageIndex');
      final _selectedIndexes = List.generate(
          newLastImageIndex - oldLastImageIndex,
          (i) => oldLastImageIndex + 1 + i);
      selectedImageIndexes.addAll(_selectedIndexes);
    }
  }

  toggleImageSelected(int index) {
    if (selectedImageIndexes.contains(index))
      selectedImageIndexes.remove(index);
    else
      selectedImageIndexes.add(index);
  }

  toggleStartPauseTimer() {
    if (_timer == null || !_timer.isActive) {
      _timer =
          Timer.periodic(Duration(milliseconds: TIMER_TICK_DURATION), (timer) {
        if (_timeLeft > 0) {
          _timeLeft.value = _timeLeft.value - TIMER_TICK_DURATION;
          _setTimerStateActive();
        } else {
          _timer.cancel();
          _setTimerStateStopped();
          _timeLeft.value = _initialTimeLeft;

          finishVisualization();
        }
      });
      _setTimerStateActive();
    } else {
      _timer.cancel();
      _setTimerStateStopped();
    }
  }

  finishVisualization() {
    _saveVisualizationProgress();
    _timer?.cancel();
    Get.offAll(VisualizationSuccessPage(),
        predicate: ModalRoute.withName(homePageRoute));
  }

  setCurrentImageIndex(int value) => _currentImageIndex.value = value;

  Future _initializeTargets() async {
    final _result = await targetRepository.getVisualizationTargets();
    targets.addAll(_result);
  }

  Future<Directory> _createImageTempDirectory(String path) async {
    print('create temp image directory $_tempAssetsDir');
    return Directory(path).create();
  }

  _getTimeLeftFromPrefs() {
    ExerciseTime _exerciseTime = _dbBox.get(MyResource.VISUALIZATION_TIME_KEY,
        defaultValue: ExerciseTime(0));
    // TODO revert
    _initialTimeLeft = 10000;
    // _initialTimeLeft =
    //     _exerciseTime.time * 60 * 1000; //time from prefs in minutes
    _timeLeft.value = _initialTimeLeft;
  }

  _updateTimerIsActive(bool newValue) {
    if (newValue != isTimerActive.value) isTimerActive.value = newValue;
  }

  _setTimerStateActive() => _updateTimerIsActive(true);

  _setTimerStateStopped() => _updateTimerIsActive(false);

  _saveAssetInTemporaryDirectory(Asset asset) async {
    print('save image in temp dir = $imageCacheDirPath/${asset.name}');
    final assetByteData = await asset.getByteData();
    File file = File('$imageCacheDirPath/${asset.name}');
    await file.writeAsBytes(assetByteData.buffer.asUint8List());
  }

  // TODO refactor this WTF
  _saveVisualizationProgress() {
    if (passedTimeSeconds > 0) {
      _saveProgressList();
      VisualizationProgress visualizationProgress =
          VisualizationProgress(passedTimeSeconds, getVisualizationText());
      Day day = ProgressUtil()
          .createDay(null, null, null, null, null, null, visualizationProgress);
      ProgressUtil().updateDayList(day);
    }
  }

  // TODO refactor this WTF
  void _saveProgressList() {
    String type = 'visualization_small'.tr();
    String _visualizationText = getVisualizationText();
    List<dynamic> tempList;
    List<dynamic> list = _dbBox.get(MyResource.MY_VISUALISATION_PROGRESS) ?? [];
    tempList = list;
    final _now = DateTime.now();

    if (list.isNotEmpty) {
      if (list.last[2] == '${_now.day}.${_now.month}.${_now.year}') {
        print(passedTimeSeconds);
        list.add([
          tempList.isNotEmpty ? '${(int.parse(tempList.last[0]) + 1)}' : '0',
          tempList[tempList.indexOf(tempList.last)][1] +
              (passedTimeSeconds < 5
                  ? '\n$type - ' + 'skip_note'.tr()
                  : '\n$type - $passedTimeSeconds ' +
                      'seconds'.tr() +
                      '($_visualizationText)'),
          '${_now.day}.${_now.month}.${_now.year}'
        ]);
        list.removeAt(list.indexOf(list.last) - 1);
      } else {
        list.add([
          list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
          passedTimeSeconds < 5
              ? '\n$type - ' + 'skip_note'.tr()
              : '\n$type - $passedTimeSeconds ' +
                  'seconds'.tr() +
                  '($_visualizationText)',
          '${_now.day}.${_now.month}.${_now.year}'
        ]);
      }
    } else {
      list.add([
        list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
        passedTimeSeconds < 5
            ? '\n$type - ' + 'skip_note'.tr()
            : '\n$type - $passedTimeSeconds ' +
                'seconds'.tr() +
                '($_visualizationText)',
        '${_now.day}.${_now.month}.${_now.year}'
      ]);
    }
    _dbBox.put(MyResource.MY_VISUALISATION_PROGRESS, list);
  }

  ImageProvider getDecorationImage(int imageIndex) {
    final _image = selectedImages[imageIndex];

    print('get provided image $currentImageIndex');

    switch (_image.runtimeType) {
      case VisualizationAssetImage:
        return AssetImage(
          _image.path,
        );
        break;
      case VisualizationGalleryImage:
        return MemoryImage((_image as VisualizationGalleryImage)
            .byteData
            .buffer
            .asUint8List());
        break;
      case VisualizationFileSystemImage:
        return FileImage(
          (_image as VisualizationFileSystemImage).file,
        );
        break;
      default:
        throw new UnsupportedError('unknown image type');
    }
  }

  _removeImageTempDirectory() {
    final _imageTempDirectory = Directory(imageCacheDirPath);
    print('remove image cache directory $imageCacheDirPath');
    _imageTempDirectory.delete(recursive: true);
  }

  // TODO move from
  List<VisualizationImage> getDefaultImages(int targetId) {
    List<VisualizationImage> _result = [];

    switch (targetId) {
      case 0: //success
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
      case 1: //family
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
      case 2: //nature
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
      case 3: //rest
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
      case 4: //sport
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
}
