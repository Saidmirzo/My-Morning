import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:enum_to_string/enum_to_string.dart';
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
import 'package:morningmagic/features/visualization/domain/entities/image_tag.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_image_repository.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_target_repository.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_success_page.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class VisualizationController extends GetxController {
  static const int TIMER_TICK_DURATION = 1000;

  final VisualizationTargetRepository targetRepository;
  final VisualizationImageRepository imageRepository;
  TextEditingController vizualizationText = TextEditingController();

  Box _hiveBox;

  VisualizationController(
      {@required Box hiveBox,
      @required this.targetRepository,
      @required this.imageRepository}) {
    _hiveBox = hiveBox;
  }

  bool fromHomeMenu = false;

  final targets = <VisualizationTarget>[].obs;

  final images = <VisualizationImage>[].obs;

  final List<int> selectedImageIndexes = <int>[].obs;

  var _currentImageIndex = 0.obs;

  var _timeLeft = 0.obs;

  var isTimerActive = false.obs;

  var isImagesDownloading = false.obs;

  Timer _timer;

  int _initialTimeLeft;

  int selectedTargetId = 0;

  List<VisualizationImage> get selectedImages =>
      selectedImageIndexes.map((index) => images[index]).toList();

  String get formattedTimeLeft =>
      StringUtil.getFormattedTimeLeft(_timeLeft.value);

  double get timeLeftValue => 1 - _timeLeft / _initialTimeLeft;

  int get currentImageIndex => (_currentImageIndex >= selectedImages.length)
      ? 0
      : _currentImageIndex.value;

  int get passedTimeSeconds => (_initialTimeLeft - _timeLeft.value) ~/ 1000;

  int get selectedImagesCount => selectedImageIndexes.length;

  @override
  void onInit() async {
    super.onInit();
    _getTimeLeftFromPrefs();
    await _initializeTargets();
    loadAllTargets();
  }

  @override
  void onClose() {
    super.onClose();
    print('Stop timer');
    _setTimerStateStopped();
    _timer?.cancel();
    _saveVisualizationProgress();
  }

  // Таймер скрывает все элементы в режиме FullScreen через 3 секунды
  Timer timerElements;
  int _durationElem = 3;
  RxBool hideElements = false.obs;
  startTimerElements() {
    timerElements?.cancel();
    _durationElem = 3;
    hideElements.value = false;
    timerElements =
        Timer.periodic(Duration(milliseconds: TIMER_TICK_DURATION), (timer) {
      print('hide elements tick, left : $_durationElem');
      if (_durationElem > 0) {
        _durationElem = _durationElem - 1;
      } else {
        timerElements.cancel();
        hideElements.value = true;
      }
    });
  }

  Future<List<VisualizationTarget>> getTargets() {
    return targetRepository.getVisualizationTargets();
  }

  saveTarget(String text) {
    final _id = targets.last.id + 1;
    targets.add(VisualizationTarget(
        id: _id,
        tag: EnumToString.convertToString(VisualizationImageTag.custom),
        title: text));
    targetRepository.saveVisualizationTargets(targets);
  }

  removeTarget(int id) {
    targets.removeWhere((element) => element.id == id);
    targetRepository.saveVisualizationTargets(targets);
  }

  updateTarget(int id, String title) {
    final _oldTarget =
        targets.firstWhere((element) => element.id == id, orElse: () => null);
    final _oldTargetIndex = targets.indexOf(_oldTarget);
    if (_oldTarget != null) {
      final _newTarget = VisualizationTarget(
          id: _oldTarget.id,
          tag: _oldTarget.tag,
          title: title,
          coverAssetPath: _oldTarget.coverAssetPath);
      targets.replaceRange(_oldTargetIndex, _oldTargetIndex + 1, [_newTarget]);
      targetRepository.saveVisualizationTargets(targets);
    }
  }

  Future loadImages(VisualizationTarget target) async {
    _setDownloading(true);

    _currentImageIndex.value = 0;
    selectedImageIndexes.clear();
    images.clear();
    final _loadedImages =
        await imageRepository.getVisualizationImages(target.tag, target.id);
    images.addAll(_loadedImages);

    _setDownloading(false);
  }

  void loadAllTargets() async {
    print('loadAllImages: start');
    print('targets length: ${targets.length}');
    targets.forEach((element) {
      print('loadAllImages: load ${element.toString()}');
      loadImages(element);
    });
  }

  Future<List<VisualizationImage>> loadAttachedTargetImages(
      int targetId) async {
    return imageRepository.getVisualizationImages(
        EnumToString.convertToString(VisualizationImageTag.custom), targetId);
  }

  addImageAssetsFromGallery(List<Asset> assetImages) async {
    int oldLastImageIndex = images.length - 1;

    final _galleryImages =
        await _convertAssetsToVisualizationImage(assetImages);

    if (_galleryImages.isNotEmpty) {
      images.addAll(_galleryImages);
      int newLastImageIndex = images.length - 1;
      final _selectedIndexes = List.generate(
          newLastImageIndex - oldLastImageIndex,
          (i) => oldLastImageIndex + 1 + i);
      selectedImageIndexes.addAll(_selectedIndexes);
    }

    imageRepository.cachePickedFromGalleryAssets(assetImages, selectedTargetId);
  }

  toggleImageSelected(int index) {
    if (selectedImageIndexes.contains(index))
      selectedImageIndexes.remove(index);
    else
      selectedImageIndexes.add(index);
  }

  bool isImageSelected(int index) => selectedImageIndexes.contains(index);

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
    Get.offAll(VisualizationSuccessPage(fromHomeMenu: fromHomeMenu),
        predicate: ModalRoute.withName(homePageRoute));
  }

  void removePickedImage(int index) async {
    final image = images[index];
    await imageRepository.removeCachedPickedImage(image);
    images.remove(image);
    selectedImageIndexes.remove(index);
  }

  setCurrentImageIndex(int value) => _currentImageIndex.value = value;

  Future _initializeTargets() async {
    final _result = await targetRepository.getVisualizationTargets();
    targets.addAll(_result);
  }

  _getTimeLeftFromPrefs() {
    ExerciseTime _exerciseTime = _hiveBox.get(MyResource.VISUALIZATION_TIME_KEY,
        defaultValue: ExerciseTime(0));
    _initialTimeLeft =
        _exerciseTime.time * 60 * 1000; //time from prefs in minutes
    _timeLeft.value = _initialTimeLeft;
  }

  _updateTimerIsActive(bool newValue) {
    if (newValue != isTimerActive.value) isTimerActive.value = newValue;
  }

  _setTimerStateActive() => _updateTimerIsActive(true);

  _setTimerStateStopped() => _updateTimerIsActive(false);

  void _setDownloading(bool isDownloading) =>
      isImagesDownloading.value = isDownloading;

  // TODO refactor this WTF
  _saveVisualizationProgress() {
    if (passedTimeSeconds > 0) {
      _saveProgressList();
      VisualizationProgress visualizationProgress =
          VisualizationProgress(passedTimeSeconds, vizualizationText.text);
      Day day = ProgressUtil()
          .createDay(null, null, null, null, null, null, visualizationProgress);
      ProgressUtil().updateDayList(day);
    }
  }

  // TODO refactor this WTF
  void _saveProgressList() {
    print('_saveProgressList vizualizations');
    String type = 'visualization_small'.tr;
    String _visualizationText = vizualizationText.text;
    List<dynamic> tempList;
    List<dynamic> list =
        _hiveBox.get(MyResource.MY_VISUALISATION_PROGRESS) ?? [];
    tempList = list;
    final _now = DateTime.now();

    if (list.isNotEmpty) {
      print('_saveProgressList vizualizations list.isNotEmpty');
      if (list.last[2] == '${_now.day}.${_now.month}.${_now.year}') {
        print('_saveProgressList vizualizations 1');
        list.add([
          tempList.isNotEmpty ? '${(int.parse(tempList.last[0]) + 1)}' : '0',
          tempList[tempList.indexOf(tempList.last)][1] +
              (passedTimeSeconds < 5
                  ? '\n$type - ' + 'skip_note'.tr
                  : '\n$type - $passedTimeSeconds ' +
                      'seconds'.tr +
                      '($_visualizationText)'),
          '${_now.day}.${_now.month}.${_now.year}'
        ]);
        list.removeAt(list.indexOf(list.last) - 1);
      } else {
        print('_saveProgressList vizualizations 2');
        list.add([
          list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
          passedTimeSeconds < 5
              ? '\n$type - ' + 'skip_note'.tr
              : '\n$type - $passedTimeSeconds ' +
                  'seconds'.tr +
                  '($_visualizationText)',
          '${_now.day}.${_now.month}.${_now.year}'
        ]);
      }
    } else {
      print('_saveProgressList vizualizations 3');
      list.add([
        list.isNotEmpty ? '${(int.parse(list.last[0]) + 1)}' : '0',
        passedTimeSeconds < 5
            ? '\n$type - ' + 'skip_note'.tr
            : '\n$type - $passedTimeSeconds ' +
                'seconds'.tr +
                '($_visualizationText)',
        '${_now.day}.${_now.month}.${_now.year}'
      ]);
    }
    _hiveBox.put(MyResource.MY_VISUALISATION_PROGRESS, list);
  }

  ImageProvider getImpressionDecorationImage(int imageIndex) {
    final _image = selectedImages[imageIndex];
    return _getDecorationImage(_image);
  }

  ImageProvider getTargetCoverDecorationImage(VisualizationImage image) {
    return _getDecorationImage(image);
  }

  ImageProvider _getDecorationImage(VisualizationImage image) {
    switch (image.runtimeType) {
      case VisualizationAssetImage:
        return AssetImage(
          image.path,
        );
        break;
      case VisualizationGalleryImage:
        return MemoryImage(
            (image as VisualizationGalleryImage).byteData.buffer.asUint8List());
        break;
      case VisualizationFileSystemImage:
        return FileImage(
          (image as VisualizationFileSystemImage).file,
        );
        break;
      case VisualizationNetworkImage:
        return NetworkImage((image as VisualizationNetworkImage).path);
      default:
        throw new UnsupportedError('unknown image type');
    }
  }

  Future<List<VisualizationImage>> _convertAssetsToVisualizationImage(
      List<Asset> assetImages) async {
    final List<VisualizationImage> _visualizationImagesFromGallery = [];

    for (Asset asset in assetImages) {
      final _byteData = await asset.getByteData();
      final _galleryImage = VisualizationGalleryImage(
          path: asset.identifier,
          pickedAsset: asset,
          byteData: _byteData,
          isDefault: false);
      _visualizationImagesFromGallery.add(_galleryImage);
    }

    return _visualizationImagesFromGallery;
  }
}
