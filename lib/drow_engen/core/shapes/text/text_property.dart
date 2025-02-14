import 'package:JoDija_view/util/view_data_model/base_data_model.dart';
import 'package:Mashair/loclization/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/drow_engen/core/shapes/text/text_shap.dart';
import '../../../../consts/views/colors.dart';
import '../../bloc/main_bloc/main_bloc.dart';
import '../../color_pecker.dart';
import '../../commons/colors.dart';
import '../../commons/fonts.dart';
import '../../interfaces/base_shap.dart';
import '../size_point.dart';
import 'text_editor.dart';

class TextProperty extends StatefulWidget implements Widget {
  TextProperty({super.key, required this.shape});

  BaseShape shape;

  @override
  State<TextProperty> createState() => _TextPropertyState();
}

class _TextPropertyState extends State<TextProperty> {
  TextEditingController _textEditingController = TextEditingController();
  late DrawEngineMainBloc bloc;
  Color color = Color(0xff040404);
  Color backgroundColor = Color(0x40404);
  String text = 'text';
  TextShape? newShape;
  int allignment = 0; // 0 center 1 right 2 left
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;

  List<Color> _color = CalarsBalet().getList();
  List<Color> _colorBackground = CalarsBalet().getWithTransList();

  String fontFamily = 'Roboto';
  double x = 0;
  double y = 0;
  double maxFontSize = 50;
  double minFontSize = 10;
  double layoutWidth = 0;
  double layoutHeight = 0;
  TextStyle? selectedStyle;
  double fontSize = 20;
  int isPorpertyState = 0;
  int textDirection = 0;
  bool isContstraint = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<DrawEngineMainBloc>();
    layoutWidth = bloc.engen.layout.width;
    layoutHeight = bloc.engen.layout.height;
    BaseShape Shape = widget.shape;

    newShape = Shape as TextShape;
    _textEditingController.text = newShape!.text;
    text = _textEditingController.text;
    _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length));
    color = newShape!.color;
    fontSize = newShape!.fontSize;
    fontFamily = newShape!.fontFamily!;
    isBold = newShape!.isBold;
    isItalic = newShape!.isItalic;
    isUnderline = newShape!.isUnderline;
    backgroundColor = newShape!.backgroundColor;

    x = newShape!.xPos;
    y = newShape!.yPos;
    maxFontSize = newShape!.maxFontSize;
    minFontSize = newShape!.minFontSize;
    isContstraint = newShape!.isContstraint;
    List<TextStyle> _fonts = FontsList().getList();
    selectedStyle = _fonts.first;

    return BlocListener<DrawEngineMainBloc, MainState>(
      listener: (context, state) {
        if (state is ShapeSelected) {
          bool condition = state.shape is TextShape;
          if (condition) {
            newShape = state.shape as TextShape;
            _textEditingController.text = newShape!.text;
            text = _textEditingController.text;
            _textEditingController.selection = TextSelection.fromPosition(
                TextPosition(offset: _textEditingController.text.length));
            color = newShape!.color;
            backgroundColor = newShape!.backgroundColor;
            fontSize = newShape!.fontSize;
            fontFamily = newShape!.fontFamily!;
            isBold = newShape!.isBold;
            isItalic = newShape!.isItalic;
            isUnderline = newShape!.isUnderline;
            x = newShape!.xPos;
            y = newShape!.yPos;
            maxFontSize = newShape!.maxFontSize;
            minFontSize = newShape!.minFontSize;
            isContstraint = newShape!.isContstraint;
            textDirection = newShape!.textDirection;
          }
          // selectedStyle = _fonts.firstWhere((element) => element.fontFamily == newShape!.fontFamily);
        }
      },
      child: Container(
          child: Column(
        children: [
          Container(
            height: 50.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPorpertyState = 1;
                      editText();
                    });
                  },
                  child: AnimatedContainer(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    duration: Duration(milliseconds: 500),
                    decoration: isPorpertyState == 1
                        ? BoxDecoration(
                            color: LightColors().primary.withOpacity(0.3),
                            // border
                            borderRadius: BorderRadius.circular(50),
                          )
                        : BoxDecoration(),
                    child: Center(
                      child: Text(
                          Translation().translate().DrowEngetTextWrite,
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPorpertyState = 2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: isPorpertyState == 2
                        ? BoxDecoration(
                            color: LightColors().primary.withOpacity(0.3),
                            // border
                            borderRadius: BorderRadius.circular(50),
                          )
                        : BoxDecoration(),
                    child: Container(
                      height: 30.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPorpertyState = 7;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
                    decoration: isPorpertyState == 7
                        ? BoxDecoration(
                            color: LightColors().primary.withOpacity(0.3),
                            // border
                            borderRadius: BorderRadius.circular(50),
                          )
                        : BoxDecoration(),
                    child: Center(
                      child: Icon(
                        allignmintIcon(),
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPorpertyState = 8;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
                    decoration: isPorpertyState == 8
                        ? BoxDecoration(
                            color: LightColors().primary.withOpacity(0.3),
                            // border
                            borderRadius: BorderRadius.circular(50),
                          )
                        : BoxDecoration(),
                    child: Center(
                      child: Icon(
                        textDirectionIcon(),
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPorpertyState = 3;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
                    decoration: isPorpertyState == 3
                        ? BoxDecoration(
                            color: LightColors().primary.withOpacity(0.3),
                            // border
                            borderRadius: BorderRadius.circular(50),
                          )
                        : BoxDecoration(),
                    child: Center(
                      child: Text(
                        '${ Translation().translate().DrowEngetTextFontSize}: ${fontSize.toInt()}',
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPorpertyState = 4;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
                    decoration: isPorpertyState == 4
                        ? BoxDecoration(
                            color: LightColors().primary.withOpacity(0.3),
                            // border
                            borderRadius: BorderRadius.circular(50),
                          )
                        : BoxDecoration(),
                    child: Center(
                      child: Text(
                        Translation().translate().DrowEngetTextFontFamily,
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPorpertyState = 6;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
                    decoration: isPorpertyState == 6
                        ? BoxDecoration(
                            color: LightColors().primary.withOpacity(0.3),
                            // border
                            borderRadius: BorderRadius.circular(50),
                          )
                        : BoxDecoration(),
                    child: Center(
                      child: Text(
                         Translation().translate().DrowEngetTextFontDecoration,
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(child: WidgetTextProperty())
        ],
      )),
    );
  }

  Widget WidgetTextProperty() {
    if (isPorpertyState == 1) {
      return WidgetTextEdit();
    } else if (isPorpertyState == 2) {
      return widgetFontColor();
    } else if (isPorpertyState == 3) {
      return widgetfontSize();
    } else if (isPorpertyState == 4) {
      return widgetFontFamily();
    } else if (isPorpertyState == 5) {
      return widgetBackgroundColor();
    } else if (isPorpertyState == 6) {
      return widgetfontDecoration();
    } else if (isPorpertyState == 7) {
      return widgetTextAllignment();
    } else if (isPorpertyState == 8) {
      return widgetTextDirection();
    } else if (isPorpertyState == 9) {
      return widgetIsWarpText();
    } else {
      return Container();
    }
  }

  Widget WidgetTextEdit() {
    return Container(
      height: 50.h,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }

  void editText() {
    showDialog<Texting>(
        context: context,
        builder: (_) {
          return Positioned(
            top: 0,
            left: 0,
            child: Dialog(
              alignment: Alignment.topCenter,
              child: TextEditor(
                title:  Translation().translate().ScreenPrintSetting,
                text2:   Translation().translate().ScreenPrintSetting,
                text: text,
              ),
            ),
          );
        }).then((value) {
      text = value!.id!;
      newShape = newShape!.copyWith(
          layoutHeight: layoutHeight,
          layoutWidth: layoutWidth,
          text: text,
          color: color,
          fontFamily: fontFamily,
          xPos: x,
          yPos: y);
      bloc.add(OnLayerItemPropertyChange(shape: newShape!));
    });
  }

  Widget widgetfontSize() {
    int fs = fontSize.toInt();
    return Container(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Font Size:$fs', style: TextStyle(fontSize: 15.sp)),
          Slider(
            value: fontSize,
            min: minFontSize,
            max: maxFontSize,
            onChanged: (value) {
              setState(() {
                fontSize = value;
                reChange();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget widgetFontColor() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.h,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _color.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    color = _color[index];
                    reChange();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 25.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        color: _color[index],
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetBackgroundColor() {
    return Container(
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.h,
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (c) => Dialog(child: ColorPecker())).then((value) {
                  if (value != null) {
                    setState(() {
                      backgroundColor = value;

                      reChange();
                    });
                  }
                });
              },
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          // reduce
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, width: 0.2)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetfontDecoration() {
    return Container(
      height: 70.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: 50.h,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      isBold = !isBold;
                      reChange();
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: isBold ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'B',
                        style: TextStyle(
                            color: isBold ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      isItalic = !isItalic;
                      reChange();
                    });
                  },
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: isItalic ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'I',
                        style: TextStyle(
                            color: isItalic ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      isUnderline = !isUnderline;
                      reChange();
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: isUnderline ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'U',
                        style: TextStyle(
                            color: isUnderline ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetTextAllignment() {
    return Container(
      height: 60.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 50.h,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // right
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      allignment = 1;
                      reChange();
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: allignment == 1 ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.format_align_right,
                        color: allignment == 1 ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                //center
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      allignment = 0;
                      reChange();
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: allignment == 0 ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.format_align_center,
                        color: allignment == 0 ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                // left
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      allignment = 2;
                      reChange();
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: allignment == 2 ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.format_align_left,
                        color: allignment == 2 ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// set icon data function to set icon data
  IconData allignmintIcon() {
    if (allignment == 0) {
      return Icons.format_align_center;
    } else if (allignment == 1) {
      return Icons.format_align_right;
    } else {
      return Icons.format_align_left;
    }
  }

  Widget widgetTextDirection() {
    return Container(
      height: 60.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 50.h,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      textDirection = 0;
                      reChange();
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: textDirection == 0 ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.align_horizontal_right,
                        color: textDirection == 0 ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      textDirection = 1;
                      reChange();
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: textDirection == 1 ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.align_horizontal_left,
                        color: textDirection == 1 ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetIsWarpText() {
    return Container(
      height: 60.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 50.h,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                        'يتم تفعيل هذه الخاصية عندما يخرج النص عن اطار العمل فيتم تفعيل هذه الخاصية لعمل عدة اسطر بحيث لا يخرج عن الاطار',
                        style: TextStyle(fontSize: 15.sp))),
                // right
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      isContstraint = !isContstraint;
                      reChange();
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: isContstraint ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.format_align_right,
                        color: allignment == 1 ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetFontFamily() {
    List<TextStyle> _fonts = FontsList().getList();
    return DropdownButton(
        items: _fonts.map((e) {
          return DropdownMenuItem(
            child: Text(' اسم الخط هو${e.fontFamily!}',
                style: e.copyWith(fontSize: 15.sp)),
            value: e,
          );
        }).toList(),
        onChanged: (value) {
          fontFamily = value!.fontFamily!;
          reChange();
        },
        value: selectedStyle ?? _fonts.first);
  }

  void reChange() {
    setState(() {
      newShape = newShape!.copyWith(
          textAlignment: allignment,
          text: text,
          color: color,
          fontFamily: fontFamily,
          fontSize: fontSize,
          backgroundColor: backgroundColor,
          isBold: isBold,
          isItalic: isItalic,
          isUnderline: isUnderline,
          layoutHeight: layoutHeight,
          layoutWidth: layoutWidth,
          textDirection: textDirection,
          isContstraint: isContstraint,
          xPos: x,
          yPos: y);
    });
    bloc.add(OnLayerItemPropertyChange(shape: newShape!));
  }

  IconData textDirectionIcon() {
    if (textDirection == 0) {
      return Icons.align_horizontal_right;
    } else {
      return Icons.align_horizontal_left;
    }
  }
}

class Texting extends BaseViewDataModel {
  Texting(super.id);
}
