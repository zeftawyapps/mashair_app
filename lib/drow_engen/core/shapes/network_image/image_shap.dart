import 'dart:async';
import 'dart:math';
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
import '../rotate_point.dart';
import '../size_point.dart';
import 'image_property.dart';

class NetWorkImageShape extends RecShap {
  static Future<NetWorkImageShape> ImageFromNetwork(
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
    return NetWorkImageShape(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        drowImage: img,
        imageUint8: unit8List)
      ..url = url;
  }

  static Future<NetWorkImageShape> ImageUnit8List(
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

    return NetWorkImageShape(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        drowImage: imge,
        imageUint8: img);
  }

  static Future<NetWorkImageShape> ImageFromAsset(
      {double x = 0,
      double y = 0,
      double widthMax = 200,
      double hightMax = 200,
      required String path}) async {
    ByteData data = await rootBundle.load(path);
    var unit8List = data.buffer.asUint8List();
    Codec codec = await instantiateImageCodec(unit8List!);
    FrameInfo frameInfo = await codec.getNextFrame();
    var imge = frameInfo.image;
    double w = imge.width > widthMax ? widthMax - 20 : imge.width.toDouble();
    double h = imge.height.toDouble() > hightMax
        ? hightMax - 20
        : imge.height.toDouble();
    return NetWorkImageShape(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        drowImage: imge,
        imageUint8: unit8List);
  }

  // add text style
  // late SizePoint sizePointLeftDown ;
  // late SizePoint sizePointRightDown;
  // late SizePoint sizePointLeftUp;
  // late SizePoint sizePointRightUp;

  late RotatePoint rotatePoint;
  // bool isSizePointLeftDownSelected = false;
  // bool isSizePointRightDownSelected = false;
  // bool isSizePointLeftUpSelected = false;
  // bool isSizePointRightUpSelected = false;
  bool isResizing = false;

  bool isRotatePointSelected = false;

  int loadState = 0;
  String loadPath = 'asset/logo.png';
  Uint8List? imageUint8;
  ByteData? imageData;
  Object? jsonData;
  double _rotateAngle = 0;
  String url = "";
  NetWorkImageShape({
    required super.xPos,
    required super.yPos,
    this.drowImage,
    this.imageUint8,
    this.loadPath = "",
    super.width,
    super.height,
  }) : super(
            id: 4,
            name: '${ShapeName.networkImage}',
            type: '${ShapeType.networkImage}') {
    rotatePoint = RotatePoint(xPos: xPos, yPos: yPos);
  }

  Color _color = Colors.transparent;
  set color(Color color) => _color = color;
  ui.Image? drowImage;

  @override
  bool onTapDown(TapDownDetails details) {
    isRotating = isRotatePointSelected;

    this.isSelected = super.onTapDown(details);
    return isSelected;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    super.onPanUpdate(details);
  }

// add copy with
  NetWorkImageShape copyWith(
      {Color? color,
      double? xPos,
      double? yPos,
      double? width,
      double? height,
      ui.Image? image,
      Uint8List? imageData,
      String? url}) {
    return NetWorkImageShape(
      xPos: xPos ?? this.xPos,
      yPos: yPos ?? this.yPos,
      width: width ?? this.width,
      height: height ?? this.height,
      drowImage: image ?? this.drowImage,
      imageUint8: imageData ?? this.imageUint8,
    )
      ..isSelected = false
      ..url = url ?? this.url;
  }

  @override
  void drawShape(Canvas canvas) async {
    Paint paint = Paint();

    if (drowImage == null) {
      if (jsonData != null) {
        relaodImage(jsonData!).then((value) {
          _drow(canvas, paint);
        });
      } else {
        paint.color = Color(0xFF0FADDC);
        paint.style = PaintingStyle.fill;
        _drowEmpty(canvas, paint);
      }
    } else {
      _drow(canvas, paint);
    }
  }

  void _drow(Canvas canvas, Paint paint) {
    if (_rotateAngle != 0) {
      canvas.translate(xPos + width / 2, yPos + height / 2);
      canvas.rotate(_rotateAngle * pi / 180);
      canvas.translate(-xPos - width / 2, -yPos - height / 2);
    }

    canvas.drawImageRect(
        drowImage!,
        Rect.fromLTWH(
            0, 0, drowImage!.width.toDouble(), drowImage!.height.toDouble()),
        Rect.fromLTWH(xPos, yPos, width, height),
        paint);
    paint.color = _color;
    paint.style = PaintingStyle.stroke;

    canvas.drawRect(Rect.fromLTWH(xPos, yPos, width, height), paint);

    drawSizePoints(canvas, xPos, yPos, width, height);
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
      sizePointLeftDown =
          SizePoint(xPos: (xPos + width - 6), yPos: (yPos + height - 6));
      sizePointLeftDown.drawShape(canvas);
    }
  }

  factory NetWorkImageShape.fromJson(Map<String, dynamic> json) {
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

    return NetWorkImageShape(
      width: w,
      height: h,
      xPos: x,
      yPos: y,
    )..jsonData = json['imageData'];
  }

  Future relaodImage(Object object) async {
    List<dynamic> list = object as List<dynamic>;
    List<int> intList = list.cast<int>();
    imageUint8 = Uint8List.fromList(intList);
    Codec codec = await instantiateImageCodec(imageUint8!);
    FrameInfo frameInfo = await codec.getNextFrame();
    drowImage = frameInfo.image;
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
      "url": url,
      'width': width,
      'height': height,
      'imageData': imageUint8!,
    };
  }

  @override
  // TODO: implement propertyBoox
  Widget get propertyBoox => NetWorkImageProperty(shape: this);

  // to string
  @override
  String toString() {
    return 'ImageShape{id: $id, name: $name, type: $type, xPos: $xPos, yPos: $yPos, width: $width, height: $height}';
  }




}
