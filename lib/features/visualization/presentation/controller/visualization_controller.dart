import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/visualization/visualization.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/features/visualization/domain/entities/target/visualization_target.dart';
import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:morningmagic/features/visualization/domain/repositories/visualization_target_repository.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class VisualizationController extends GetxController {
  final VisualizationTargetRepository repository;
  Box _dbBox;

  final targets = <VisualizationTarget>[].obs;

  final images = <VisualizationImage>[].obs;

  final List<int> selectedImageIndexes = <int>[].obs;

  VisualizationController(Box dbBox, this.repository) {
    _dbBox = dbBox;
  }

  @override
  void onInit() async {
    super.onInit();

    final _result = await repository.getVisualizationTargets();
    targets.addAll(_result);

    final _defaultImages = targets
        .map((element) => element.coverAssetPath)
        .where((element) => element != null)
        .map((e) => VisualizationImage(assetPath: e))
        .toList();
    images.addAll(_defaultImages);
  }

  void saveVisualization(String text) {
    _dbBox.put(MyResource.VISUALIZATION_KEY, Visualization(text));
  }

  String getVisualization() {
    String _visualizationText = "";

    Visualization _visualization = _dbBox.get(MyResource.VISUALIZATION_KEY);

    if (_visualization != null) {
      _visualizationText = _visualization.visualization;
    }

    return _visualizationText;
  }

  Future<List<VisualizationTarget>> getTargets() {
    return repository.getVisualizationTargets();
  }

  saveTarget(String text) {
    final _id = targets.last.id + 1;
    print('saveTarget id = $_id');
    targets.add(VisualizationTarget(id: _id, isCustom: true, title: text));
    repository.saveVisualizationTargets(targets);
  }

  removeTarget(int id) {
    print('removeTarget id = $id');
    targets.removeWhere((element) => element.id == id);
    repository.saveVisualizationTargets(targets);
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
      repository.saveVisualizationTargets(targets);
    }
  }

  void addImageAssetsFromGallery(List<Asset> assetImages) {
    final _visualizationImages =
        assetImages.map((e) => VisualizationImage(asset: e)).toList();
    // TODO maybe need save to loca store
    // final _byteData = assetImages[0].getByteData();

    images.addAll(_visualizationImages);
  }

  toggleImageSelected(int index) {
    if (selectedImageIndexes.contains(index))
      selectedImageIndexes.remove(index);
    else
      selectedImageIndexes.add(index);
  }
}
