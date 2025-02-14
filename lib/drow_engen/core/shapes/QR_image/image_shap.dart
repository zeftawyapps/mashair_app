import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Mashair/drow_engen/core/bloc/main_bloc/main_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants.dart';
import '../../interfaces/rec_shaps.dart';
import '../rotate_point.dart';
import 'image_property.dart';

class QRImageShape extends RecShap {
  late RotatePoint rotatePoint;
  bool isResizing = false;
  bool isRotatePointSelected = false;
  int loadState = 0;
  ui.Image? qrImage;
  Uint8List? imageUint8;
  ByteData? imageData;
  Object? jsonData;
  double layoutWidth = 200;
  double layoutHeight = 300;
  bool isTransfrared = false;
  String _svg = "";
  double _rotateAngle = 0;
  String text = "this is the QR for scane the text ";

  QRImageShape({
    required super.xPos,
    required super.yPos,
   this .  layoutWidth = 200,
  this.layoutHeight = 400,
    super.width,
    super.height,
    this.text = 'this is the QR for scane the text ',
    required this.qrImage,
    this.isTransfrared = false,
  }) : super(
            id: 4, name: '${ShapeName.QRImage}', type: '${ShapeType.QRImage}')   {
    this.isResizable = true;

     _generteQR();
  }
// copy with
  QRImageShape copyWith({
    double? xPos,
    double? yPos,
    double? width,
    double? height,
    double layoutWidth = 200,
    double layoutHeight = 400,
    String? text ,
   ui. Image ?  image,

  })   {

    return QRImageShape(
      xPos: xPos ?? this.xPos,
      yPos: yPos ?? this.yPos,
      width: width ?? this.width,
      height: height ?? this.height,
      layoutWidth: layoutWidth,
      layoutHeight: layoutHeight,
      text: text ?? this.text,
      qrImage: image ?? this.qrImage,

    )
      .. xPos = layoutWidth/2
      .. yPos = layoutHeight -qrImage!.height.toDouble();



  }

  void _generteQR() async {
if (qrImage == null) {
    qrImage = await toQrImageData(text);
  }}

  Future<ui.Image> toQrImageData(String text) async {
    try {
      return await QrPainter(
        data: text,
        version: QrVersions.auto,
        gapless: false,
        color: Colors.black,
      ).toImage(300);
    } catch (e) {
      throw e;
    }
  }



  Widget get propertyBoox => QRImageProperty(shape: this);
  @override
  void drawShape( canvas) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

      _drow(canvas, paint);

  }

  void _drow(Canvas canvas, Paint painas) async {

    Paint paint = Paint();
if (!isTransfrared) {
  xPos = layoutWidth/2 ;
  yPos = layoutHeight - height.toDouble();
}

    if (qrImage != null) {


      canvas.drawImageRect(
           qrImage! ,
          Rect.fromLTWH(0, 0, qrImage!.width.toDouble(), qrImage!.height.toDouble()),
          Rect.fromLTWH(xPos, yPos, width, height),
          paint);

    }
drawSizePoints(canvas, xPos, yPos, width, height);
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    // TODO: implement onPanUpdate
    super.onPanUpdate(details);
    isTransfrared = true;
  }
}
