import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';

import '../../constants.dart';
import '../../interfaces/rec_shaps.dart';
import '../size_point.dart';
import 'text_property.dart';

class TextShape extends RecShap {
  String text = 'Text';

  // add text style
  TextShape({
    required this.text,
    this.myProperty,
  }) : super(id: 1, name: '${ShapeName.text}', type: '${ShapeType.text}') {
  }

  Color _color = Color(0xff000000);
  Color backgroundColor = Color(0x00000000);
  double _fontSize = 20;
  String fontFamily = 'Roboto';
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;
  double layoutWidth = 400;
  double layoutHeight = 400;
  double _maxWith = 100;
  double _maxHeight = 100;
  double maxFontSize = 70;
  double minFontSize = 10;
  bool isContstraint = false;
  Widget? myProperty;
  int textAlignment = 0;
  int _textDirection = 1;

  set color(Color color) => _color = color;

  set fontSize(double fontSize) => _fontSize = fontSize;

  set textDirection(int textDirection) => _textDirection = textDirection;

  Color get color => _color;

  double get fontSize => _fontSize;
  int get textDirection => _textDirection;
  TextDirection get _settextDirection =>
      _textDirection == 0 ? TextDirection.ltr : TextDirection.rtl;

  TextAlign get _setTextAlign => textAlignment == 0
      ? TextAlign.center
      : textAlignment == 1
      ? TextAlign.right
      : TextAlign.left;

  @override
  void drawShape(Canvas canvas) {
    TextStyle textStyle = TextStyle(
      color: _color,
      fontSize: _fontSize > 50 ? 50 : _fontSize,
      fontFamily: fontFamily,
      background: Paint()..color = backgroundColor,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
      textAlign: _setTextAlign,
      textDirection: _settextDirection,
    );
    textPainter.layout();
    double w = textPainter.width;
    double h = textPainter.height;
    double maxPossX = xPos + w;
    double maxPossY = yPos + h;
    _maxWith = layoutWidth;
    _maxHeight = layoutHeight;
    if (maxPossX > layoutWidth) {
      _maxWith = layoutWidth - xPos;
    } else {
      _maxWith = w;
    }
    if (isContstraint) {
      textPainter.layout(maxWidth: _maxWith, minWidth: 0);
    }else {
      textPainter.layout();
    }
    width = textPainter.width;
    height = textPainter.height;
    textPainter.paint(canvas, Offset(xPos, yPos));

    // add size point
    drawSizePoints(canvas , xPos , yPos , width , height);


  }

  TextShape copyWith({
    String? text,
    Color? color,
    double? fontSize,
    Color? backgroundColor,
    double layoutWidth = 200,
    double layoutHeight = 200,
    int? textAlignment,
    bool? isBold = false,
    bool? isItalic = false,
    bool? isUnderline = false,
    int? textDirection,
    double? xPos,
    double? yPos,
    double? width,
    double? height,
    String? fontFamily,
    bool isContstraint = false,
  }) {
    TextShape x = TextShape(
      text: text ?? this.text,
    )
      ..color = color ?? this._color
      ..fontSize = fontSize ?? this._fontSize
      ..fontFamily = fontFamily ?? this.fontFamily
      ..textDirection = textDirection ?? this._textDirection
      ..backgroundColor = backgroundColor ?? this.backgroundColor
      ..xPos = xPos ?? this.xPos
      ..yPos = yPos ?? this.yPos
      ..width = width ?? this.width
      ..height = height ?? this.height
      ..isBold = isBold ?? this.isBold
      ..isItalic = isItalic ?? this.isItalic
      ..layoutWidth = layoutWidth
      ..layoutHeight = layoutHeight
      ..textAlignment = textAlignment ?? this.textAlignment
      ..isUnderline = isUnderline ?? this.isUnderline
      ..isContstraint = isContstraint;

    print(x.toString());
    return x;
  }

  factory TextShape.fromJson(Map<String, dynamic> json) {
    var x = json['xPos'];
    var y = json['yPos'];
    var f = json['fontSize'];
    if (x is int) {
      x = x.toDouble();
    }
    if (y is int) {
      y = y.toDouble();
    }
    if (f is int) {
      f = f.toDouble();
    }

    return TextShape(
      text: json['text'],
    )
    // put position and size
      ..xPos = x
      ..yPos = y
      ..width = json['width']
      ..height = json['height']
      ..layoutWidth = json['layoutWidth']
      ..layoutHeight = json['layoutHeight']
      ..color = Color(json['color'])
      ..fontSize = f
      ..backgroundColor = Color(json['backgroundColor'])
      ..isBold = json['isBold']
      ..isItalic = json['isItalic']
      ..isUnderline = json['isUnderline']
      ..textDirection = int.tryParse(json['textDirectionData'] ?? '1') ?? 1
      ..fontFamily = json['fontFamily'] ?? 'Roboto'
      ..isContstraint = json['isContstraint'] ?? false
      ..textAlignment = int.tryParse(json['textAlignment'] ?? '0') ?? 0;

  }

  @override
  bool onTapDown(TapDownDetails details) {

    this.isSelected = super.onTapDown(details);
    return isSelected;
  }

  bool _stopResize(double w, double h) {
    if (!isContstraint)  {   return false;}

    double maxPossX = xPos + w;
    double maxPossY = yPos + h;
    _maxWith = layoutWidth;
    if (xPos < 0) {
      return true;
    }
    if (yPos < 0) {
      return true;
    }

    if (maxPossX > layoutWidth) {
      return true;
    }
    if (maxPossY > layoutHeight) {
      return true;
    }

    return false;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    // TODO: implement onPanUpdate

    super.onPanUpdate(details);
    // set max x and max y

    // double maxPossY = (yPos + height);
    // if (maxPossY > layoutHeight) {
    //   yPos = layoutHeight - height;
    // }
    // double maxPossX = (xPos + width);
    // if (maxPossX > layoutWidth) {
    //   xPos = layoutWidth - width - 10;
    // }
    // if (xPos < 0) {
    //   xPos = 0;
    // }
    // if (yPos < 0) {
    //   yPos = 0;
    // }
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
    'layoutWidth': layoutWidth,
    'layoutHeight': layoutHeight,
    'text': text,
    'isBold': isBold,
    'fontFamily': fontFamily,
    'isItalic': isItalic,
    'isUnderline': isUnderline,
    'color': _color.value,
    'textDirection': _textDirection,
    'backgroundColor': backgroundColor.value,
    'fontSize': _fontSize,
    'isContstraint': isContstraint,
    'textDirection': _textDirection.toString(),
  };
  @override
  String toString() {
    return 'TextShape{id: $id, name: $name, type: $type, xPos: $xPos, yPos: $yPos, width: $width, height: $height, text: $text, color: $_color, fontSize: $_fontSize, textDirection: $_textDirection , backgroundColor: $backgroundColor , isBold: $isBold , isItalic: $isItalic  , isUnderline: $isUnderline}';
  }

  @override
  // TODO: implement propertyBoox
  Widget get propertyBoox => myProperty ?? TextProperty(shape: this);
  @override
  void onPointLiftUpPanUpdate(DragUpdateDetails details) {

    //
    sizePointLeftUp.onPanUpdate(details);
    bool isStop = _stopResize(width, height);
    double w = !isStop ? sizePointLeftUp.rewidth : 0;
    double h = !isStop ? sizePointLeftUp.reheight : 0;
    width = width + w;
    height = height - h;
    xPos = xPos + w;
    fontSize = fontSize - h / 2;
    if (fontSize > maxFontSize) {
      fontSize = maxFontSize;
    }
    if (fontSize <  minFontSize) {
      fontSize = minFontSize;
    }
  }

  @override
  void onPointLiftDownPanUpdate(DragUpdateDetails details) {
    sizePointLeftDown.onPanUpdate(details);
    bool isStop = _stopResize(width, height);
    double w = !isStop ? sizePointLeftDown.rewidth : 0;
    double h = !isStop ? sizePointLeftDown.reheight : 0;
    width = width + w;
    height = height + h;
    fontSize = fontSize + h / 2;
    xPos = xPos + w;
    if (fontSize > maxFontSize) {
      fontSize =  maxFontSize;
    }
    if (fontSize < minFontSize) {
      fontSize = minFontSize ;
    }
  }

  @override
  void onPointRightUpPanUpdate(DragUpdateDetails details) {
    sizePointLeftDown.onPanUpdate(details);
    bool isStop = _stopResize(width, height);
    double w = !isStop ? sizePointLeftDown.rewidth : 0;
    double h = !isStop ? sizePointLeftDown.reheight : 0;
    width = width - w;
    height = height - h;
    fontSize = fontSize - h / 2;
    xPos = xPos - w;
    if (fontSize > maxFontSize) {
      fontSize =  maxFontSize;
    }
    if (fontSize < minFontSize) {
      fontSize = minFontSize ;
    }
  }

  @override
  void onPointRightDownPanUpdate(DragUpdateDetails details) {
    sizePointRightDown.onPanUpdate(details);
    bool isStop = _stopResize(width, height);
    double w = !isStop ? sizePointRightDown.rewidth : 0;
    double h = !isStop ? sizePointRightDown.reheight : 0;
    width = width - w * 2;
    height = height + h * 2;
    fontSize = fontSize + h / 3;
    xPos = xPos - w/2;
    if (fontSize > maxFontSize) {
      fontSize = maxFontSize ;
    }
    if (fontSize < minFontSize) {
      fontSize = minFontSize;
    }
  }
}
