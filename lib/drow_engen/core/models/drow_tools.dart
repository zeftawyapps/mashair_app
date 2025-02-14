 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../interfaces/base_shap.dart';
import '../interfaces/proparies_box.dart';

class DrawTools {
  BaseShape shape;
  BaseShape Function ()  onShapeClick;

  DrawTools(this.shape
      , {
    required this.onShapeClick ,
      required   this.propertyBoox  ,
        this.iconSvg   ,
      required   this.icon  }
      );
  Widget propertyBoox ;
  IconData icon  ;
  String? iconSvg  ;




}