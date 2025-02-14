import 'dart:convert';



import '../constants.dart';
import '../interfaces/base_shap.dart';
import '../interfaces/rec_shaps.dart';
import '../shapes/avatarwork_image/image_shap.dart';
import '../shapes/image/image_shap.dart';
import '../shapes/network_image/image_shap.dart';
import '../shapes/rectangel/rectangel_shap.dart';
import '../shapes/text/text_shap.dart';
import 'drower_engen.dart';

class Register {
  DrowerEngen engen;
  List<BaseShape> shapes = [];
  Map<String, dynamic> mainReget = {};
  List<Map<String, dynamic>> shapeProperties = [];
  Register({required this.engen}) {
    shapes = engen.shapes;
    _oninit();
  }
  String nameKey = "name";
  String layoutKey = "layout";
  String shapePropertiesKey = "shapeProperties";
  String layoutWidthKey = "width";
  String layoutHeightKey = "height";

  void _oninit() {
    mainReget = {
      "$nameKey": "main",
      "$layoutKey": {
        "$layoutWidthKey": engen.layout.width,
        "$layoutHeightKey": engen.layout.height
      },
      "$shapePropertiesKey": shapeProperties
    };
    _loger();
  }

  void _loger() {
    // print with json format
    print(toString());
  }

  void renameReget(String name) {
    mainReget["$nameKey"] = name;
  }

  void onShapeChanged( List<BaseShape> shapes) {

    shapeProperties = [];
    for (var shape in shapes) {
      shapeProperties.add(shape.toJson());
    }
    mainReget["$shapePropertiesKey"] = shapeProperties;
    _loger();

  }

  // to json
  Map<String, dynamic> toJson() => mainReget;
  // to string
  @override
  String toString() {
    return  jsonEncode(mainReget);
  }

  DrowerEngen  onLoad(Map<String, dynamic> data) {
    // load data
    mainReget = data;
    // get layout
    Map<String, dynamic> layout = mainReget["$layoutKey"];
  var  w = layout[layoutWidthKey];
  var h = layout[layoutHeightKey];
if (w is int) {
      w = w.toDouble();
    }
if (h is int) {
      h = h.toDouble();
    }
    engen.layout.width =  w.toDouble();
    engen.layout.height =  h.toDouble();
    // get shapes
   var  shapes = mainReget["$shapePropertiesKey"]  ;
    List<BaseShape> newShapes = [];
    for (var shape in shapes) {
      switch (shape["type"]) {
        case ShapeType.rectangle:
          newShapes.add(RectangleShape .fromJson(shape));
          break;
        case  ShapeType.text:
          newShapes.add(TextShape.fromJson(shape));
          break;
        case  ShapeType.image:
          newShapes.add(ImageShape.fromJson(shape));
          break;
          case ShapeType.avatarImage:
          newShapes.add(AvatarImageShape.fromJson(shape));
          break;
          case ShapeType.networkImage:
          newShapes.add(NetWorkImageShape.fromJson(shape));
          break;

        default:
          break;
      }
    }
    engen.shapes = newShapes;
    _loger();
    return engen;
  }


}
