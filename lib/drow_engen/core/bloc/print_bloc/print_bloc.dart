import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../contrallers/drower_engen.dart';
import '../../contrallers/image_exporter.dart';
import '../../contrallers/register.dart';
import '../../interfaces/base_shap.dart';
import '../../models/layout.dart';
import '../../shapes/image/image_shap.dart';
import '../../shapes/rectangel/rectangel_shap.dart';

part 'print_event.dart';
part 'Print_state.dart';


class DrawEnginePrintBloc extends Bloc<PrintEvent, PrintState> {
  DrowerEngen engen = DrowerEngen();
  late Register register;
  DrawEnginePrintBloc() : super(PrintMainInitial()) {
    on<PrintEvent>((event, emit) {
      register = Register(engen: engen);
      if (engen.shapes.isEmpty) {
        emit(PrintMainInitial());
      } else {
        emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
      }
    });
    on<PrintInitialEvent>((event, emit) {
      engen.shapes = [];
      engen.layout = event.layout;
      engen.shapes = event.shapes;
      emit(PrintLoading(layout: engen.layout));
      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
    });
    on <PrintUnit8ListInitialEvent>((event, emit) async {
      engen.shapes = [];
      engen.layout = event.layout;
      Uint8List image = event.image;
      engen.shapes.add(await  ImageShape.ImageUnit8List(
          x: 0,
          y: 0,
          img: image,
          widthMax: engen.layout.width,
          hightMax: engen.layout.height,
      )) ;
      emit(PrintLoading(layout: engen.layout));
      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
    });
    on<OnLoad>((event, emit) {
      engen = register.onLoad(event.data);
      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
    });
    on<SaveFile>((event, emit) async {
      Layout l = engen.layout;
      double width = event.width ?? l.width;
      double height = event.height ?? l.height;
    bool isDouble = event.isDouble ?? false;
      Size size = Size( width,  height);
      register.onShapeChanged(engen.shapes);
      ImageExporter export = ImageExporter(
          Shaps: engen.shapes,
          board: RectangleShape(xPos: 0, yPos: 0, width: size.width, height: size.height)
       , forPrint: true );
      var value =     await   export.exportUint8List()  ;
      emit(DrawSaved(image: value, register: register));
     });
  }
}
