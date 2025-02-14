import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


import '../../constants.dart';
import '../../interfaces/rec_shaps.dart';
import '../size_point.dart';
import 'image_property.dart';

class AvatarImageShape extends RecShap {
  static Future<AvatarImageShape> ImageFromNetwork(
      {double x = 0,
      double y = 0,
      double widthMax = 200,
      double hightMax = 200,
      required String url}) async {
    http.Response response = await http.get(Uri.parse(url));
    var unit8List = response.bodyBytes;
    Codec codec = await instantiateImageCodec(unit8List);
    FrameInfo frameInfo = await codec.getNextFrame();
    var img = frameInfo.image;
    double w =
        img.width.toDouble() > widthMax ? widthMax - 20 : img.width.toDouble();
    double h = img.height.toDouble() > hightMax
        ? hightMax - 20
        : img.height.toDouble();
    return AvatarImageShape(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        drowImage: img,
        imageUint8: unit8List);
  }

  static Future<AvatarImageShape> ImageUnit8List(
      {double x = 0,
      double y = 0,
      double widthMax = 200,
      double hightMax = 200,
      required Uint8List img}) async {
    Codec codec = await instantiateImageCodec(img);
    FrameInfo frameInfo = await codec.getNextFrame();
    var imge = frameInfo.image;
    double w = imge.width > widthMax ? widthMax - 20 : imge.width.toDouble();
    double h = imge.height.toDouble() > hightMax
        ? hightMax - 20
        : imge.height.toDouble();

    return AvatarImageShape(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        drowImage: imge,
        imageUint8: img);
  }

  static Future<AvatarImageShape> ImageFromAsset({

    double x = 0,
    double y = 0,
    double widthMax = 200,
    double hightMax = 200,
    required  String path}) async {
    ByteData data = await rootBundle.load(path);
    var unit8List = data.buffer.asUint8List();
    Codec codec = await instantiateImageCodec(unit8List!);
    FrameInfo frameInfo = await codec.getNextFrame();
   var imge =    frameInfo.image;
   double w = 150;
    double h = 150;
    return AvatarImageShape(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        drowImage: imge,
        imageUint8: unit8List);

  }

  // add text style

  bool isPointSelected = false;
  int loadState = 0;
  String loadPath = 'asset/logo.png';
  Uint8List? imageUint8;
  ByteData? imageData;
  Object? jsonData;
  Color borderColor = Colors.black;
  Color fillColor =  Colors.green;

  AvatarImageShape({
    required super.xPos,
    required super.yPos,
    this.drowImage,
    this.imageUint8,
    this.loadPath = "",
    this.fillColor = Colors.transparent,
    super.width,
    super.height,
  }) : super(id: 5, name: '${ShapeName.avatarImage}', type: '${ShapeType.avatarImage}') {
    sizePointLeftDown = SizePoint(xPos: xPos, yPos: yPos);
  }

  ui.Image? drowImage;

  @override
  bool onTapDown(TapDownDetails details) {
    // TODO: implement onTapDown





    this.isSelected = super.onTapDown(details);
    return isSelected;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    // TODO: implement onPanUpdate


      super.onPanUpdate(details);

  }

// add copy with
  AvatarImageShape copyWith({
Color ? fillColor,
    double? xPos,
    double? yPos,
    double? width,
    double? height,
    ui.Image? image,
    Uint8List? imageData,
  }) {
    return AvatarImageShape(
      xPos: xPos ?? this.xPos,
      yPos: yPos ?? this.yPos,
      width: width ?? this.width,
      height: height ?? this.height,
      drowImage: image ?? this.drowImage,
      imageUint8: imageData ?? this.imageUint8,
      fillColor: fillColor ?? this.fillColor,

    );

  }

  @override
  void drawShape(Canvas canvas) async {
    Paint paint = Paint();

    if (drowImage == null) {

   if (jsonData != null ) {
          relaodImage(jsonData!).then((value) {
            _drow(canvas, paint);
          });

   } else  {
        paint.color = Color(0xFF0FADDC);
        paint.style = PaintingStyle.fill;
        _drowEmpty(canvas, paint);
      }
    } else {
      _drow(canvas, paint);
    }
  }

  void _drow(Canvas canvas, Paint paint) {

    paint.color = fillColor;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Rect.fromLTWH(xPos, yPos, width, height), paint);
   // drow border ovelay
    paint.color = borderColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawOval(Rect.fromLTWH(xPos, yPos, width, height), paint);

    canvas.drawImageRect(
        drowImage!,
        Rect.fromLTWH(
            0, 0, drowImage!.width.toDouble(), drowImage!.height.toDouble()),
        Rect.fromLTWH(xPos+30, yPos+30, width-55, height-55),
        paint);
    drawSizePoints(canvas, xPos, yPos, width, height);
  }

  void _drowEmpty(Canvas canvas, Paint paint) {
    canvas.drawRect(
        Rect.fromLTWH(
            0, 0, drowImage!.width.toDouble(), drowImage!.height.toDouble()),
        paint);
    paint.color = borderColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(xPos, yPos, width, height), paint);
    drawSizePoints(canvas, xPos, yPos, width, height);
  }
  factory AvatarImageShape.fromJson(Map<String, dynamic> json) {
    var w = json['width'];
    var h = json['height'];
    var x = json['xPos'];
    var y = json['yPos'];
    if (w is int) {
      w = w.toDouble();
    }
    if (h is int) {
      h = h.toDouble();
    }
    if (x is int) {
      x = x.toDouble();
    }
    if (y is int) {
      y = y.toDouble();
    }

    return AvatarImageShape(
      width: w,
      height: h,
      xPos: x,
      yPos: y,
    )..jsonData = json['imageData' ]
    ..fillColor = Color(json['fillColor'])
    ..borderColor= Color(json['borderColor']);

  }

  Future   relaodImage(Object object) async {
      List<dynamic> list  = object as List<dynamic> ;
      List<int>intList = list .cast<int>();
imageUint8 = Uint8List.fromList(intList);
     Codec codec = await instantiateImageCodec(imageUint8!);
     FrameInfo frameInfo = await codec.getNextFrame();
   drowImage  = frameInfo.image;

  }

  // to json
  Map<String, dynamic> toJson() {
    // convert drowaimage to byetData

    return {
      'id': id,
      'name': name,
      'type': type,
      'xPos': xPos,
      'yPos': yPos,
      'width': width,
      'height': height,
      'imageData': imageUint8!,
      'fillColor': fillColor.value,
      'borderColor': borderColor.value,
    };
  }

  @override
  // TODO: implement propertyBoox
  Widget get propertyBoox => AvatarImageProperty(shape: this);

  // to string
  @override
  String toString() {
    return 'ImageShape{id: $id, name: $name, type: $type, xPos: $xPos, yPos: $yPos, width: $width, height: $height}';
  }

}
