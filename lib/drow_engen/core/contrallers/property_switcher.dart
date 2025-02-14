 import 'package:flutter/cupertino.dart';

 import '../constants.dart';
import '../interfaces/base_shap.dart';
import '../shapes/image/image_property.dart';
import '../shapes/rectangel/rectangle_property.dart';
import '../shapes/text/text_property.dart';
import '../shapes/text/text_shap.dart';
import 'drow_tools_contraller.dart';

class PropertySwitcher {

  BaseShape shape  ;
 // constructor
  PropertySwitcher( this.  shape) ;
  // get property box

  Widget getPropertyBox(BaseShape  shape){
    DrawToolsController drawToolsController = DrawToolsController();
      return  drawToolsController.getToolPropertyBox(shape);
  // return Container();
  }


}