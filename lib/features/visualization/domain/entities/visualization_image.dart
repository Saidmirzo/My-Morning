import 'package:equatable/equatable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class VisualizationImage extends Equatable {
  final String assetPath; //for images from asset

  final Asset asset; // for images picked from gallery

  VisualizationImage({this.assetPath, this.asset}) : assert(assetPath != null);

  bool get fromGallery => asset != null;

  @override
  List<Object> get props => [assetPath, asset];
}