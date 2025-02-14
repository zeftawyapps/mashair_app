 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mashair/drow_engen/core/shapes/text/text_shap.dart';

import '../../bloc/main_bloc/main_bloc.dart';
import '../../color_pecker.dart';
import '../../commons/fonts.dart';
import '../../interfaces/base_shap.dart';
import '../size_point.dart';

class TextPropertyDialoge extends StatefulWidget implements Widget {
  TextPropertyDialoge({super.key, required this.shape});

  BaseShape shape;

  @override
  State<TextPropertyDialoge> createState() => _TextPropertyDialogeState();
}

class _TextPropertyDialogeState extends State<TextPropertyDialoge> {
  TextEditingController _textEditingController = TextEditingController();
  var bloc;
  Color color = Color(0xff040404);
  String text = 'text';
  TextShape? newShape;

  String fontFamily = 'Roboto';
  double x = 0;
  double y = 0;
  TextStyle? selectedStyle;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<DrawEngineMainBloc>();

    newShape = widget.shape as TextShape;

    _textEditingController.text = newShape!.text;
    _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length));
    color = newShape!.color;
    fontFamily = newShape!.fontFamily!;
    x = newShape!.xPos;
    y = newShape!.yPos;
    List<TextStyle> _fonts = FontsList().getList();
    selectedStyle = _fonts.first;

    return BlocListener<DrawEngineMainBloc, MainState>(
      listener: (context, state) {
        if (state is ShapeSelected) {
          newShape = state.shape as TextShape;
          _textEditingController.text = newShape!.text;
          text = _textEditingController.text;
          _textEditingController.selection = TextSelection.fromPosition(
              TextPosition(offset: _textEditingController.text.length));
          color = newShape!.color;
          fontFamily = newShape!.fontFamily!;
          x = newShape!.xPos;
          y = newShape!.yPos;
          // selectedStyle = _fonts.firstWhere((element) => element.fontFamily == newShape!.fontFamily);
        }
      },
      child: Container(
          child: Wrap(
        children: [
          Center(
              child: Text(
            'Text',
            style: TextStyle(fontSize: 20),
          )),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 300,
            child: TextField(
              maxLines: 2,
              onChanged: (value) {},
              controller: _textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Text',
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (c) => Dialog(child: ColorPecker())).then((value) {
                if (value != null) {
                  setState(() {
                    color = value;
                    _textEditingController.text = text;

                    fontFamily = value!.fontFamily!;
                  });
                }
              });
            },
            child: Container(
              decoration:
                  BoxDecoration(color: color, border: Border.all(color: color)),
              child: Text(
                'font color ',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
          ),
          DropdownButton(
              items: _fonts
                  .map((e) => DropdownMenuItem(
                        child: Text(e.fontFamily!, style: e),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _textEditingController.text = text;
                  color = color;
                  fontFamily = value!.fontFamily!;
                });
              },
              value: selectedStyle ?? _fonts.first),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop(newShape!.copyWith(
                  xPos: x,
                  yPos: y,
                  fontFamily: fontFamily,
                  color: color,
                  text: text));
            },
            child: Container(
              width: 50,
              height: 50,
              child: Center(
                child: Text('ادخال '),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
