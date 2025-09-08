import '../interfaces/base_shap.dart';
import '../interfaces/rec_shaps.dart';
import '../models/layout.dart';

class DrowerEngen {

  List<BaseShape> shapes = [];
  int selectedShapeIndex = -1;
  BaseShape? selectedShape  ;
  Layout layout = Layout(width: 300, height: 400);

  // constructor
  DrowerEngen() {
  }

//despose
  void despose() {
    shapes = [];
    selectedShapeIndex = -1;
    selectedShape = null;
    layout = Layout(width: 300, height: 400);
  }

  int getShapeIndex(BaseShape shape) {
    return shapes.indexOf(shape);
  }
  List<BaseShape> onShapeClick(BaseShape shape) {
    int newId = shapes.length + 1;
    shape.id = newId;
    // get same type of shapes
    var sameTypeShapes = shapes.where((element) => element.type == shape.type);
    // get the last shape
    if (sameTypeShapes.isEmpty) {
      shape.key = shape.type  ;
      shapes.add(shape);
    } else {
      var lastShape = sameTypeShapes.last;
      // get the index of the last shape
      var index = shapes.indexOf(lastShape);
      // rename the key of the last
      shape = redfineSameShapeType(shape, lastShape, index);
      shapes.add(shape);
    }


    for (var item in shapes) {
      print(item);
      item.isSelected = false;
    }
    int lastIndex = shapes.length - 1;
    shapes[lastIndex].isSelected = true;
    selectedShape = shapes[lastIndex];
    selectedShapeIndex = lastIndex;
    return shapes;
  }
  BaseShape redfineSameShapeType(
      BaseShape myShape, BaseShape lasShape, int index) {
    String key = myShape.key + (index + 1).toString();
    if (myShape is RecShap && lasShape is RecShap) {
      myShape = reChangeShapePossition(myShape, lasShape, index);
    }

    myShape.key = key;



    return myShape;
  }
  BaseShape reChangeShapePossition(
      RecShap myShape, RecShap lasShape, int index) {
    double x = lasShape.xPos + 10;
    double y = lasShape.yPos + 10;
    myShape.xPos = x;
    myShape.yPos = y;
    return myShape;
  }

  void onShapeChanged(List<BaseShape> shapes) {
    this.shapes = shapes;
  }
  // on shape selected
  void onShapeSelected(BaseShape shape) {
    for (var item in shapes) {
      item.isSelected = false;
    }
    int index = shapes.indexOf(shape);
    shapes[index].isSelected = true;
    selectedShape = shapes[index];
    selectedShapeIndex = index;
  }
}