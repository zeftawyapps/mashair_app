import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Mashair/drow_engen/core/shapes/rectangel/rectangle_property.dart';


import '../../constants.dart';
import '../../interfaces/rec_shaps.dart';
import '../size_point.dart';

class RectangleShape extends RecShap {
  // add text style
  late SizePoint sizePoint;
  bool isPointSelected = false;
  double stickWidth = 1;
  RectangleShape(
      {required super.xPos,
      required super.yPos,
      super.width,
      super.height,
        this.stickWidth = 0.5,

      this.primaryColor = Colors.white})
      : super(
            id: 1,
            name: '${ShapeType.rectangle}',
            type: '${ShapeType.rectangle}') {
    sizePoint = SizePoint(xPos: xPos, yPos: yPos);
    fillColor = [primaryColor];

  }

  Color _borderColor = Color(0xff000000);
  List<Color> fillColor = [Colors.red.withOpacity(0.5)];
  Color primaryColor = Colors.red.withOpacity(0.5);
  set borderColor(Color color) => _borderColor = color;

  @override
  bool onTapDown(TapDownDetails details) {

    isPointSelected = sizePoint.onTapDown(details);

    isResizing = isPointSelected;

    this.isSelected = super.onTapDown(details);
    return isSelected;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    // TODO: implement onPanUpdate
    if (isPointSelected) {
      sizePoint.onPanUpdate(details);
      width = width + sizePoint.rewidth;
      height = height + sizePoint.reheight;
    } else {
      super.onPanUpdate(details);
    }
  }

  @override
  void drawShape(Canvas canvas) {
    // drow the rectangle

    Paint paint = Paint();
    paint.color = _borderColor;
    if (stickWidth >0 ) {
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = stickWidth;
    }
    canvas.drawRect(Rect.fromLTWH(xPos, yPos, width, height), paint);

    paint.color = fillColor[0];
    paint.style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(xPos, yPos, width, height), paint);

    if (isSelected) {
      paint.color = Colors.green;
      paint.style = PaintingStyle.fill;
      sizePoint =
          SizePoint(xPos: (xPos + width - 6), yPos: (yPos + height - 6));
      // canvas.drawRect(
      //     Rect.fromLTWH((xPos+width), (yPos +  width),5, 5), paint);
      sizePoint.drawShape(canvas);
    }
  }

  // add copy with
  RectangleShape copyWith({
    int? id,
    String? name,
    String? type,
    double? xPos,
    double? yPos,
    double? width,
    double? height,
    Color? borderColor,
    Color? primaryColor,
  }) {
    return RectangleShape(
      xPos: xPos ?? this.xPos,
      yPos: yPos ?? this.yPos,
      width: width ?? this.width,
      height: height ?? this.height,
    )
      ..borderColor = borderColor ?? this._borderColor
      ..fillColor = [primaryColor ?? this.fillColor[0]];
  }

  factory RectangleShape.fromJson(Map<String, dynamic> json) {
    return RectangleShape(
      xPos: json['xPos'],
      yPos: json['yPos'],
      width: json['width'],
      height: json['height'],
    )..borderColor = Color(json['color']);
  }

  // to json
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
    return 'RectangleShape{id: $id, name: $name, type: $type, xPos: $xPos, yPos: $yPos, width: $width, height: $height}';
  }
  @override
  // TODO: implement propertyBoox
  Widget get propertyBoox => RectangleProperty() ;

  @override
  void onPointLiftDownPanUpdate(DragUpdateDetails details) {
    // TODO: implement onPointLiftDownPanUpdate
  }

  @override
  void onPointLiftUpPanUpdate(DragUpdateDetails details) {
    // TODO: implement onPointLiftUpPanUpdate
  }

  @override
  void onPointRightDownPanUpdate(DragUpdateDetails details) {
    // TODO: implement onPointRightDownPanUpdate
  }

  @override
  void onPointRightUpPanUpdate(DragUpdateDetails details) {
    // TODO: implement onPointRightUpPanUpdate
  }
}
