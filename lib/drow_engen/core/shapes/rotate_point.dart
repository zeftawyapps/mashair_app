import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../interfaces/rec_shaps.dart';

class RotatePoint   {
  // add text style

  bool isSelected = false;
  double rex = 0;
  double reY = 0;
  Offset offset = Offset.zero;
  double angle = 0;
  double xPos = 0;
  double yPos = 0;
  double width = 30;
  double height = 30;
  RotatePoint({required  xPos, required  yPos}) ;

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
    if (isSelected) {
      xPos += details.delta.dx;
      yPos += details.delta.dy;

    }

    // resize the rectangle
    rex = details.globalPosition.dx  ;
    reY = details.globalPosition.dy  ;
    // get angle from drag point
    Offset cente = Offset( 0,0 );
    double rx = rex*10 ;
    double ry = reY*10 ;
    // get angle from drag point
    Offset point = Offset(rx, ry );
    // calculate the angle use  rotate matrix
       double newAngle = angle + rx * 0.01;

       angle = newAngle.clamp(-90, 90);




    this.angle = angle;
    print('angle $angle');



}

  @override
  void onPanEnd(DragEndDetails details) {
}

  @override
  void drawShape(Canvas canvas ) {

  Paint paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.fill;

    canvas.drawOval(Rect.fromLTWH(xPos, yPos , 30, 30), paint);
  }
}
