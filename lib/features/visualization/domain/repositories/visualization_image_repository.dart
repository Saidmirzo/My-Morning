import 'package:morningmagic/features/visualization/domain/entities/visualization_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

abstract class VisualizationImageRepository {
  Future <List<VisualizationImage>> getVisualizationImages(String tag);
  Future <List<VisualizationImage>> getPickedFromGalleryImages(List<Asset> assetImages);
}