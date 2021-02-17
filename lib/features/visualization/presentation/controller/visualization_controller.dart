import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/visualization/visualization.dart';
import 'package:morningmagic/db/resource.dart';

class VisualizationController extends GetxController {
  Box _dbBox;

  VisualizationController(Box dbBox) {
    _dbBox = dbBox;
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
}
