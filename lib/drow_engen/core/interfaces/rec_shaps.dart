import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';

import '../shapes/size_point.dart';
import 'base_shap.dart';

abstract class RecShap extends BaseShape {
  double xPos = 0.0;
  double yPos = 0.0;
  double width = 100.0;
  double height = 100.0;

  bool _dragging = false;
  Offset _offset = Offset.zero;
  bool isResizable = true;
  bool isTranslatable = true;
  bool isResizing = false;
  bool isRotating = false;
  double pointSizerSize = 20; // the size of the point sizer
  Color selectColor = Colors.red;
  Color rotateColor = Colors.green;
  Color sizeingColor = Colors.blue;
  Color pointSizerColor = Colors.blue;
  Color pointSizerBorderColor = Colors.black;

  bool isResizedLiftDown= false;
  bool isResizedLiftUp= false;
  bool isResizedRightDown= false;
  bool isResizedRightUp= false;
  late  SizePoint sizePointLeftDown  ;
  late  SizePoint sizePointRightDown ;
  late  SizePoint sizePointLeftUp  ;
  late  SizePoint sizePointRightUp ;


  RecShap(
      {required super.id,
        required super.name,
        required super.type,
        this.selectColor = Colors.blue ,
        this.rotateColor = Colors.red ,
        this.sizeingColor = Colors.green ,
        this.pointSizerColor = Colors.white,
        this.pointSizerBorderColor = Colors.black ,
        this.pointSizerSize = 15,



        this.xPos = 0.0,
        this.yPos = 0.0,
        this.width = 100,
        this.height = 100}) {
    sizePointLeftDown = SizePoint(xPos: 0, yPos: height);
    sizePointRightDown = SizePoint(xPos: width, yPos: height);
    sizePointLeftUp = SizePoint(xPos: 0, yPos: 0);
    sizePointRightUp = SizePoint(xPos: width, yPos: 0);

  }

  bool _insideRect(double x, double y) =>
      x >= xPos && x <= xPos + width && y >= yPos && y <= yPos + height;


  @override
  void onPointLiftDownPanUpdate(DragUpdateDetails details) {
    if (!isResizedLiftDown) {
      return;
    }
    sizePointLeftDown.onPanUpdate(details);
    width = width - sizePointLeftDown.rewidth;
    height = height + sizePointLeftDown.reheight ;
    // yPos = yPos - sizePointLeftDown.reheight;
    xPos = xPos + sizePointLeftDown.rewidth;




  }

  @override
  void onPointLiftUpPanUpdate(DragUpdateDetails details) {
    if (!isResizedLiftUp) {
      return;
    }

    sizePointLeftUp.onPanUpdate(details);

    width = width - sizePointLeftUp.rewidth;
    height = height - sizePointLeftUp.reheight ;
    yPos = yPos + sizePointLeftUp.reheight;
    xPos = xPos + sizePointLeftUp.rewidth;

  }

  @override
  void onPointRightDownPanUpdate(DragUpdateDetails details) {
    if (!isResizedRightDown) {
      return;
    }
    sizePointRightDown.onPanUpdate(details);
    width = width + sizePointRightDown.rewidth;
    height = height + sizePointRightDown.reheight;


  }

  @override
  void onPointRightUpPanUpdate(DragUpdateDetails details) {
    if (!isResizedRightUp) {
      return;
    }
    sizePointRightUp.onPanUpdate(details);
    width = width + sizePointRightUp.rewidth*2;
    height = height - sizePointRightUp.reheight;
    xPos = xPos ;
    yPos = yPos + sizePointRightUp.reheight;
  }





  bool onTapDown(TapDownDetails details) {
    // check if the inside point is selected

    isResizedLiftDown = sizePointLeftDown.onTapDown(details);
    isResizedLiftUp = sizePointLeftUp.onTapDown(details);
    isResizedRightDown = sizePointRightDown.onTapDown(details);
    isResizedRightUp = sizePointRightUp.onTapDown(details);


    if (isResizedLiftDown || isResizedLiftUp || isResizedRightDown || isResizedRightUp) {
      isResizing = true;
      return true;
    }else {
      isResizing = false;
    }
    if (_insideRect(details.localPosition.dx, details.localPosition.dy)) {
      _dragging = true;
      return true;
    }
    _dragging = false;
    return false;
  }

  // on drag update
  void onPanUpdate(DragUpdateDetails details) {
    if (!isTranslatable) {
      return;
    }
    isResizedLiftUp ?    onPointLiftUpPanUpdate(details):null;
    isResizedLiftDown ?    onPointLiftDownPanUpdate(details):null;
    isResizedRightUp ?    onPointRightUpPanUpdate(details):null;
    isResizedRightDown ?    onPointRightDownPanUpdate(details):null;
    if (_dragging) {
      if (isResizing) {
        return;
      }
      xPos += details.delta.dx;
      yPos += details.delta.dy;
    }
  }

  // end drag
  void onPanEnd(DragEndDetails details) {
    _dragging = false;
    isResizedLiftDown = false;
    isResizedLiftUp = false;
    isResizedRightDown = false;
    isResizedRightUp = false;
    isRotating = false;
    isResizing = false;
  }

  void drawSizePoints(Canvas canvas ,double xPos , double yPos , double width , double height) {
    Paint paint = Paint();
    if (!isResizable) {
      return;
    }
    if (isSelected) {


      paint.color =  isResizing ? sizeingColor  :  isRotating? rotateColor  :  selectColor;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 1;
      double meddele = pointSizerSize/2 ;
      canvas.drawRect(
          Rect.fromPoints(
              Offset(  xPos,  yPos),
              Offset( xPos + width,
                  yPos +  height)),
          paint);



      paint.color = Color(0xffC3A9CE);
      paint.style = PaintingStyle.fill;

      // draw the size point lift up
      sizePointLeftUp= SizePoint(xPos: xPos-meddele, yPos: yPos-meddele
          , size: pointSizerSize, color: pointSizerColor, borderColor: pointSizerBorderColor);

      sizePointLeftUp.drawShape(canvas);
      // draw the size point lift down
      sizePointLeftDown = SizePoint(xPos: xPos-meddele, yPos: yPos +  height-meddele ,
          size: pointSizerSize, color: pointSizerColor, borderColor: pointSizerBorderColor);
      sizePointLeftDown.drawShape(canvas);
      // draw the size point right up
      sizePointRightUp = SizePoint(xPos:  xPos +  width-meddele, yPos: yPos-meddele
          , size: pointSizerSize, color: pointSizerColor, borderColor: pointSizerBorderColor);
      sizePointRightUp.drawShape(canvas);
      // draw the size point right down
      sizePointRightDown = SizePoint(xPos:  xPos +  width-meddele, yPos: yPos +   height-meddele
          , size: pointSizerSize, color: pointSizerColor, borderColor: pointSizerBorderColor);
      sizePointRightDown.drawShape(canvas);
    }
  }

// tojson
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'xPos': xPos,
    'yPos': yPos,
    'width': width,
    'height': height,
  };
  // to string
  @override
  String toString() {
    return 'RecShap{id: $id, name: $name, type: $type, xPos: $xPos, yPos: $yPos, width: $width, height: $height}';
  }
}
