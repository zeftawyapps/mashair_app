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
      if (shape.isSelected) {
        RecShap recShap = shape as RecShap;
        paint.color = recShap.isResizing ? Color(0xffd290fd): shape.isRotating?Colors.red : Color(0xffd290fd);
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 1;

        canvas.drawRect(
            Rect.fromPoints(
                Offset(recShap.xPos, recShap.yPos),
                Offset(recShap.xPos + recShap.width,
                    recShap.yPos + recShap.height)),
            paint);
      }

    }



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
