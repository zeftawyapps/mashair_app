import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../interfaces/rec_shaps.dart';

class SizePoint  {
  // add text style

  bool isSelected = false;
  double width = 10;
  double height = 10;
  double rewidth = 0;
  double reheight = 0;
  double xPos = 0;
  double yPos = 0;
  double  size = 10;
  Color color = Colors.white ;
  Color borderColor = Colors.black;
  bool _dragging = false;
  SizePoint({required this .  xPos, required this.   yPos ,  this.  size = 10
    , this.color = Colors.white , this.borderColor = Colors.black
  }) {
    height = size;
    width = size;
  }

  bool _insideRect(double x, double y) =>
      x >= xPos && x <= xPos + width && y >= yPos && y <= yPos + height;
  @override
  bool onTapDown(TapDownDetails details) {
    isSelected =    _insideRect(details.localPosition.dx, details.localPosition.dy);
    return isSelected;
  }
  @override
  void onPanUpdate(DragUpdateDetails details) {
    // TODO: implement onPanUpdate
    if (_dragging) {
      xPos += details.delta.dx;
      yPos += details.delta.dy;

    }

    rewidth = details.delta.dx  ;
    reheight = details.delta.dy  ;
  }

  @override
  void onPanEnd(DragEndDetails details) {
    _dragging = false;
  }

  @override
  void drawShape(Canvas canvas ) {

    Paint paint = Paint();
    paint.color =  color;
    paint.style = PaintingStyle.fill;


    canvas.drawOval(Rect.fromLTWH(xPos, yPos , size, size ), paint);
// draw the border
    paint.color =   borderColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 0.5;
    // drow reduce button

    canvas.drawOval(Rect.fromLTWH(xPos, yPos , size, size), paint);

  }

  @override
  void drawText(Canvas canvas) {

  }
}
