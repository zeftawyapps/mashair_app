import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../drow_engen/core/bloc/main_bloc/main_bloc.dart';
import '../../../../../../../../../drow_engen/core/interfaces/base_shap.dart';
import '../../../../../../../../../drow_engen/core/paint_contral/painter.dart';
import '../../../../../../../../../drow_engen/core/shapes/rectangel/rectangel_shap.dart';


class AppMobliePaintBoard extends StatefulWidget {
  const AppMobliePaintBoard({super.key});

  @override
  State<AppMobliePaintBoard> createState() => _AppMobliePaintBoardState();
}

class _AppMobliePaintBoardState extends State<AppMobliePaintBoard> {
 late  DrawEngineMainBloc bloc ;
  double width = 300;
  double height = 400;
  List<BaseShape> shapes  =[];
  @override
  Widget build(BuildContext context) {
    bloc = context.read<DrawEngineMainBloc>();
      width =  bloc.engen .layout.width;
      height =  bloc. engen.layout .height;

    return Container(
        child: Center(
      child: GestureDetector(
        onTapDown: (details) {
          details = TapDownDetails(globalPosition: Offset(0, 0));
          bloc.add(OnPanStart(details: details));
        },
        onPanUpdate: (details) {
          bloc.add(OnPanUpdate(details: details));
        },

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // add border
            border: Border.all(
              color: Colors.black,
              width: 0.2,
            ),
            // shape border

          ),
          child: BlocListener<DrawEngineMainBloc, MainState>(
            listener: (context, state) {
              if (state is ShapeDraw) {
                shapes = state.shapes;
                width = state.layout!.width;
                height = state.layout!.height;
                setState(() {

                });
              }
              // do something

              if (state is MainLoaded){
                TapDownDetails   details = TapDownDetails(globalPosition: Offset(0, 0));
                bloc.add(OnPanStart(details: details));
              }
            },
                child:  CustomPaint(
                  size:   Size( width,  height),
                  painter: Painter(
                      board: RectangleShape( width: width , height: height , primaryColor: Colors.white, xPos: 0 , yPos: 0),
                      Shaps: shapes ),
                ) ),
          ),
      ),
      ),
    ) ;
  }
}
