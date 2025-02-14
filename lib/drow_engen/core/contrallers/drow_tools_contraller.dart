  import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../interfaces/base_shap.dart';
import '../models/drow_tools.dart';

class DrawToolsController {
  // singleton
  static  final  DrawToolsController _instance = DrawToolsController._privateConstructor();
  factory DrawToolsController() {

    return _instance;

  }
  DrawToolsController._privateConstructor();




  Map<String  , DrawTools  > _tools = {} ;

  void addTool(   DrawTools tool) {
    _tools[tool.shape.type] = tool;
  }

  Widget getToolPropertyBox(  BaseShape shape) {
    return _tools[shape.type]!.propertyBoox;
    // return Container();
  }
  IconData getToolIcon(  BaseShape shape) {
    return _tools[shape.type]!.icon;
  }

  SvgPicture getToolSvgIcon (String icon ){
    return SvgPicture.asset(icon);
  }

  // make list of tools
  List<DrawTools> get tools => _tools.values.toList();

}