import 'dart:ui';

import 'package:flutter/material.dart';

import '../interfaces/base_shap.dart';
import '../interfaces/rec_shaps.dart';
import '../shapes/rectangel/rectangel_shap.dart';

class Painter extends CustomPainter {
  List<BaseShape> Shaps;
  RectangleShape board  ;
  Painter({required this.Shaps ,
    required this.board});

  @override
  void paint(Canvas canvas, Size size) {
    board.primaryColor = Colors.white;
    // add reduce border
    board.stickWidth = 0.0;
     board.drawShape(canvas);
    Paint paint = Paint();
    for (var shape in Shaps) {
      shape.drawShape(canvas);


    }



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
