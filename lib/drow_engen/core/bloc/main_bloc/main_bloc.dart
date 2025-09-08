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
import '../../interfaces/rec_shaps.dart';
import '../../models/layout.dart';
import '../../shapes/rectangel/rectangel_shap.dart';

part 'main_event.dart';
part 'main_state.dart';

class DrawEngineMainBloc extends Bloc<MainEvent, MainState> {
  DrowerEngen engen = DrowerEngen();
  late Register register;

  DrawEngineMainBloc() : super(MainInitial()) {
    on<MainEvent>((event, emit) {
      register = Register(engen: engen);
      if (engen.shapes.isEmpty) {
        emit(MainInitial());
      } else {
        emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
      }
    });
    on<MainInitialEvent>((event, emit) {
      engen.shapes = [];
      engen.layout = event.layout;
      emit(MainLoading(layout: engen.layout));
      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
    });
    on<MainInitialEventWithDefaultShapes>((event, emit) {
      engen.shapes = event.shapes;
      engen.layout = event.layout;
      emit(MainLoading(layout: engen.layout));
      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
    });
    on<MainDesposed>((event, emit) {
      register.despose();
      engen.despose();
    });
    on<OnNewShapeAdded>((event, emit) {
      BaseShape shape = event.shape;
      List<BaseShape> newShapes = engen.onShapeClick(shape);
      engen.shapes = newShapes;
      add(OnLayerItemClick(shape: shape));
      emit(ShapeSelectedFromPanel(shape: shape, index: engen.selectedShapeIndex)) ;

      emit(ShapeSelected(shape: shape, index: engen.selectedShapeIndex));
    });
    on<OnLayerItemClick>((event, emit) {
      BaseShape shape = event.shape;
      engen.selectedShapeIndex = engen.getShapeIndex(shape);
      engen.selectedShape = shape;
      engen.onShapeSelected(shape);
      emit(ShapeSelected(shape: shape, index: engen.selectedShapeIndex));
      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
    });
    on<OnLayerItemPropertyChange>((event, emit) {
      BaseShape shape = event.shape;
      engen.shapes[engen.selectedShapeIndex] = shape;
      engen.selectedShape = shape;

      engen.shapes[engen.selectedShapeIndex].isSelected = true   ;
      // register.onShapeChanged(engen.shapes);
      emit(ShapeSelected(shape: shape, index: engen.selectedShapeIndex));

      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));

    });
    on<OnPanStart>((event, emit) {
      for (var item in engen.shapes) {
        item.isSelected = false;
      }

      for (var item in engen.shapes) {
        RecShap recShap = item as RecShap;
        bool taped = recShap.onTapDown(event.details);
        if (taped) {
          engen.selectedShape = item;
          engen.selectedShapeIndex = engen.getShapeIndex(item);
          item.isSelected = true;
          emit(ShapeSelected(shape: item, index: engen.selectedShapeIndex));
          emit(ShapeSelectedFromPanel(shape: item, index: engen.selectedShapeIndex));
          emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));

          break;
        }else {
          emit(ShapeUnSelectedFromPanel());
          emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
        }
      }
    });
    on<OnPanUpdate>((event, emit) {
      if (engen.selectedShape != null) {
        RecShap recShap = engen.selectedShape as RecShap;
        recShap.onPanUpdate(event.details);

        add(OnLayerItemPropertyChange(shape: recShap));
      }
    });
    on<OnLoad>((event, emit) {
      engen = register.onLoad(event.data);
      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
      //reemat draw
      for (var item in engen.shapes) {
        engen.selectedShape = item;
        engen.selectedShapeIndex = engen.getShapeIndex(item);
        emit(ShapeSelected(shape: item, index: engen.selectedShapeIndex));
        emit(ShapeSelectedFromPanel(shape: item, index: engen.selectedShapeIndex));
        emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
      }
      engen.selectedShape = engen.shapes.first;
      engen.selectedShapeIndex = 0;
      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
    });
    on<OnLayerDelete>((event, emit) {
      BaseShape shape = event.shape;
      engen.shapes.remove(shape);
      // register.onShapeChanged(engen.shapes);
      emit(ShapeDeleted());
      emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
    });
    on<OnLayerMoveUp>((event, emit) {
      BaseShape shape = event.shape;
      int index = engen.getShapeIndex(shape);
      if (index > 0) {
        BaseShape temp = engen.shapes[index - 1];
        engen.shapes[index - 1] = shape;
        engen.shapes[index] = temp;
        // register.onShapeChanged(engen.shapes);
        emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
      }
    });
    on<OnLayerMoveDown>((event, emit) {
      BaseShape shape = event.shape;
      int index = engen.getShapeIndex(shape);
      if (index < engen.shapes.length - 1) {
        BaseShape temp = engen.shapes[index + 1];
        engen.shapes[index + 1] = shape;
        engen.shapes[index] = temp;
        // register.onShapeChanged(engen.shapes);
        emit(ShapeDraw(shapes: engen.shapes, layout: engen.layout));
      }
    });
    on<SaveFile>((event, emit) async {
      Layout l = engen.layout;
      Size size = Size(l.width, l.height);
      register.onShapeChanged(engen.shapes);
      ImageExporter export = ImageExporter(
          Shaps: engen.shapes,
          board: RectangleShape(xPos: 0, yPos: 0, width: size.width, height: size.height));
      var value =     await   export.exportUint8List()  ;
      emit(DrawSaved(image: value, register: register));


    });
  }

// on save
}

