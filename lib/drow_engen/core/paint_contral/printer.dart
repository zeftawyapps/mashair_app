import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../interfaces/base_shap.dart';
import '../interfaces/rec_shaps.dart';
import '../shapes/image/image_shap.dart';
import '../shapes/rectangel/rectangel_shap.dart';

class Printer extends CustomPainter {
  List<BaseShape> Shaps;
  RectangleShape board;
  bool isDouble = false;

  Printer({required this.Shaps, required this.board, this.isDouble = false

  });
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint();
    ;
    board.primaryColor = Colors.white;
    board.borderColor = Colors.black;
board.xPos = 100;
    board.yPos = 50;
    board.height = size.height - 100;
    board.width = size.width-150  ;
    board.drawShape(canvas);

    if (isDouble) {
      board.xPos = 0;
      RectangleShape board2 = RectangleShape(
        width: size.width-150,
        height: size.height-100 ,
        xPos: board.xPos + board.width  ,
        yPos: 50,
        primaryColor: Colors.white,
      );
      board2.borderColor = Colors.black;
      board2.drawShape(canvas);
    }


    for (var shape in Shaps) {
      if (shape is ImageShape) {
        shape.xPos = board.xPos;
        shape.yPos =  50 ;
        shape.width =    size.width-150 ;  ;
        shape.height =  size.height-100  ;
      }
      shape.drawShape(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
