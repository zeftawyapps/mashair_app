
import 'base_shap.dart';

abstract class LayersShapes extends BaseShape {

  bool isSelected = false;

  LayersShapes({required int id, required String name, required String type})
      : super(id: id, name: name, type: type);
}