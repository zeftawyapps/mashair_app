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

class ImageShape extends RecShap {
  static Future<ImageShape> ImageFromNetwork(
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
    return ImageShape(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        drowImage: img,
        imageUint8: unit8List);
  }

  static Future<ImageShape> ImageUnit8List(
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

    return ImageShape(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        drowImage: imge,
        imageUint8: img);
  }

  static Future<ImageShape> ImageFromAsset({

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
   double w = imge.width > widthMax ? widthMax - 20 : imge.width.toDouble();
    double h = imge.height.toDouble() > hightMax
        ? hightMax - 20
        : imge.height.toDouble();
    return ImageShape(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        drowImage: imge,
        imageUint8: unit8List);

  }

  // add text style
  late SizePoint sizePoint;
  bool isPointSelected = false;
  int loadState = 0;
  String loadPath = 'asset/card.png';
  Uint8List? imageUint8;
  ByteData? imageData;
  Object? jsonData;

  ImageShape({
    required super.xPos,
    required super.yPos,
    this.drowImage,
    this.imageUint8,
    this.loadPath = "",
    super.width,
    super.height,
  }) : super(id: 1, name: '${ShapeType.image}', type: '${ShapeType.image}') {
    sizePoint = SizePoint(xPos: xPos, yPos: yPos);
  }

  Color _color = Colors.transparent;
  set color(Color color) => _color = color;
  ui.Image? drowImage;

  @override
  bool onTapDown(TapDownDetails details) {
    // TODO: implement onTapDown
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

// add copy with
  ImageShape copyWith({
    Color? color,
    double? xPos,
    double? yPos,
    double? width,
    double? height,
    ui.Image? image,
    Uint8List? imageData,
  }) {
    return ImageShape(
      xPos: xPos ?? this.xPos,
      yPos: yPos ?? this.yPos,
      width: width ?? this.width,
      height: height ?? this.height,
      drowImage: image ?? this.drowImage,
      imageUint8: imageData ?? this.imageUint8,
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
    canvas.drawImageRect(
        drowImage!,
        Rect.fromLTWH(
            0, 0, drowImage!.width.toDouble(), drowImage!.height.toDouble()),
        Rect.fromLTWH(xPos, yPos, width, height),
        paint);
    paint.color = _color;
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(xPos, yPos, width, height), paint);
    if (isSelected) {
      paint.color = Colors.green;
      paint.style = PaintingStyle.fill;
      sizePoint =
          SizePoint(xPos: (xPos + width - 6), yPos: (yPos + height - 6));
      sizePoint.drawShape(canvas);
    }
  }

  void _drowEmpty(Canvas canvas, Paint paint) {
    canvas.drawRect(
        Rect.fromLTWH(
            0, 0, drowImage!.width.toDouble(), drowImage!.height.toDouble()),
        paint);
    paint.color = _color;
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(xPos, yPos, width, height), paint);
    if (isSelected) {
      paint.color = Colors.green;
      paint.style = PaintingStyle.fill;
      sizePoint =
          SizePoint(xPos: (xPos + width - 6), yPos: (yPos + height - 6));
      sizePoint.drawShape(canvas);
    }
  }

  factory ImageShape.fromJson(Map<String, dynamic> json) {
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

    return ImageShape(
      width: w,
      height: h,
      xPos: x,
      yPos: y,
    )..jsonData = json['imageData' ];
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
    };
  }

  @override
  // TODO: implement propertyBoox
  Widget get propertyBoox => ImageProperty(shape: this);

  // to string
  @override
  String toString() {
    return 'ImageShape{id: $id, name: $name, type: $type, xPos: $xPos, yPos: $yPos, width: $width, height: $height}';
  }

}
