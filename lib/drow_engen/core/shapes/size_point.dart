import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SizePoint  {
  // add text style

  bool isSelected = false;
  double width = 10;
  double height = 10;
  double rewidth = 0;
  double reheight = 0;
  double xPos = 0;
  double yPos = 0;
  bool _dragging = false;
  SizePoint({required this .  xPos, required this.   yPos});

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
    paint.color =   Color(0xffC3A9CE);
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Rect.fromLTWH(xPos, yPos , 10, 10), paint);
// draw the border
    paint.color =   Color(0xffC3A9CE) ;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    // drow reduce button
    canvas.drawOval(Rect.fromLTWH(xPos, yPos , 10, 10), paint);
  }

  @override
  void drawText(Canvas canvas) {

}
}
