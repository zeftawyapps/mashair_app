import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mashair/drow_engen/core/bloc/print_bloc/print_bloc.dart';
import 'package:Mashair/drow_engen/core/contrallers/drower_engen.dart';
import 'package:Mashair/drow_engen/core/paint_contral/printer.dart';


import '../../../../../../../../../drow_engen/core/interfaces/base_shap.dart';
import '../../../../../../../../../drow_engen/core/paint_contral/painter.dart';
import '../models/layout.dart';
import '../shapes/rectangel/rectangel_shap.dart';



class AppMobilePrintViewer extends StatefulWidget {
    AppMobilePrintViewer({super.key ,
  this.  width = 100,this.height = 300 ,
      required this.image  ,
        this.isDouble = false ,

    });
    Uint8List image;

  double width = 300;
  double height = 400;

  bool isDouble = false;
  @override
  State<AppMobilePrintViewer> createState() => _AppMobilePrintViewerState();
}

class _AppMobilePrintViewerState extends State<AppMobilePrintViewer> {
  late  DrawEnginePrintBloc bloc ;

  List<BaseShape> shapes  =[];

  initState() {
    super.initState();
    bloc = context.read<DrawEnginePrintBloc>();
    bloc.add(PrintUnit8ListInitialEvent(image: widget .  image, layout:bloc.engen.layout));

    // bloc.add(PrintInitialEvent(
    //     shapes: widget.engen.shapes,
    //     layout:  widget.engen.layout));
  }

  @override
  Widget build(BuildContext context) {
    return   BlocListener<DrawEnginePrintBloc, PrintState>(
        listener: (context, state) {
          if (state is ShapeDraw) {
            shapes = state.shapes;
            widget.width =   state.layout!.width;
            widget.height = state.layout!.height;

            setState(() {

            });
          }
          // do something
        },
        child:  CustomPaint(
          size:   Size( widget.width, widget. height),
          painter: Printer(
              board: RectangleShape( width: widget.width  ,height:widget.height  , primaryColor: Colors.white,
                  xPos:     0 , yPos: 0),
              Shaps: shapes  , isDouble:   widget.isDouble),
        ) ) ;
  }
}
