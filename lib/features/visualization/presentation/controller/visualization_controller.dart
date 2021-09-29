import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise_time/exercise_time.dart';
import 'package:morningmagic/db/model/progress/visualization_progress/visualization_progress.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/visualization/domain/entities/image_tag.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_image_repository.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_target_repository.dart';
import 'package:morningmagic/features/visualization/presentation/pages/visualization_success_page.dart';
import 'package:morningmagic/resources/my_const.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/progress.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class VisualizationController extends GetxController {
  final VisualizationTargetRepository targetRepository;
  final VisualizationImageRepository imageRepository;
  TextEditingController vizualizationText = TextEditingController();

  VisualizationController(
      {@required Box hiveBox,
      @required this.targetRepository,
      @required this.imageRepository});

  bool fromHomeMenu = false;

  final targets = <VisualizationTarget>[].obs;

  final images = <VisualizationImage>[].obs;

  final List<int> selectedImageIndexes = <int>[].obs;

  var _currentImageIndex = 0.obs;

  var timeLeft = 0.obs;

  var isTimerActive = false.obs;

  var isImagesDownloading = false.obs;

  Timer timer;

  int _initialTimeLeft;

  int selectedTargetId = 0;

  List<VisualizationImage> get selectedImages =>
      selectedImageIndexes.map((index) => images[index]).toList();

  String get formattedTimeLeft => StringUtil.createTimeString(timeLeft.value);

  double get timeLeftValue => 1 - timeLeft / _initialTimeLeft;

  int get currentImageIndex => (_currentImageIndex >= selectedImages.length)
      ? 0
      : _currentImageIndex.value;

  RxInt passedSec = 0.obs;

  int get selectedImagesCount => selectedImageIndexes.length;

  @override
  void onInit() async {
    super.onInit();
    reinit();
  }

  @override
  void onClose() {
    super.onClose();
    print('Stop timer');
    try {
      timer?.cancel();
    } catch (e) {
      print('Error close Vizualization controller : $e');
    }
  }

  void reinit() async {
    _getTimeLeftFromPrefs();
    await _initializeTargets();
    loadAllTargets();
  }

  // Таймер скрывает все элементы в режиме FullScreen через 3 секунды
  Timer timerElements;
  int _durationElem = 3;
  RxBool hideElements = false.obs;
  startTimerElements() {
    timerElements?.cancel();
    _durationElem = 3;
    hideElements.value = false;
    timerElements = Timer.periodic(1.seconds, (timer) {
      print('hide elements tick, left : $_durationElem');
      if (_durationElem > 0) {
        _durationElem = _durationElem - 1;
      } else {
        timerElements.cancel();
        hideElements.value = true;
      }
    });
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
    if (timer == null || !timer.isActive) {
      timer = Timer.periodic(1.seconds, (timer) {
        if (timeLeft > 0) {
          timeLeft.value--;
          passedSec++;
          _updateTimerIsActive(true);
        } else {
          timer.cancel();
          finishVisualization(false);
          _updateTimerIsActive(false);
          timeLeft.value = _initialTimeLeft;
        }
      });
      _updateTimerIsActive(true);
    } else {
      timer.cancel();
      _updateTimerIsActive(false);
    }
  }

  finishVisualization(bool isSkip, {bool backProgramm = false}) {
    print('finish vizualization');
    if (passedSec > minPassedSec) {
      VisualizationProgress model = VisualizationProgress(passedSec.value,
          vizualizationText.text.isEmpty ? '-' : vizualizationText.text,
          isSkip: isSkip);
      ProgressController cPg = Get.find();
      cPg.saveJournal(MyResource.VISUALISATION_JOURNAL, model);
    }
    if (!backProgramm)
      Get.offAll(
          VisualizationSuccessPage(
            fromHomeMenu: fromHomeMenu,
          ),
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
    ExerciseTime _exerciseTime = myDbBox.get(MyResource.VISUALIZATION_TIME_KEY,
        defaultValue: ExerciseTime(0));
    print('Init time : ${_exerciseTime.time}');
    _initialTimeLeft = _exerciseTime.time * 60; // time from prefs in minutes
    print('Init time : $_initialTimeLeft');
    timeLeft.value = _initialTimeLeft;
  }

  _updateTimerIsActive(bool newValue) {
    if (newValue != isTimerActive?.value) isTimerActive?.value = newValue;
  }

  void _setDownloading(bool isDownloading) =>
      isImagesDownloading.value = isDownloading;

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
