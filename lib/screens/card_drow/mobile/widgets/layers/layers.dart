import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../drow_engen/core/bloc/main_bloc/main_bloc.dart';
import '../../../../../../../../../../drow_engen/core/interfaces/base_shap.dart';
import 'layers_item.dart';


class AppMoblieLayers extends StatefulWidget {
    AppMoblieLayers({super.key  });

  @override
  State<AppMoblieLayers> createState() => _AppMoblieLayersState();
}

class _AppMoblieLayersState extends State<AppMoblieLayers> {
  List<BaseShape> shapes = [];
  int index = 0;
  late Timer timer;
  bool isTimerStart = false;
  // add bloc to the state
  var bloc;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<DrawEngineMainBloc>();
    shapes = bloc.state.shapes;
    return BlocListener<DrawEngineMainBloc, MainState>(
        listener: (context, state) {
          if (state is ShapeDraw) {
            shapes = state.shapes;
          }
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: Container(

              height: MediaQuery.of(context).size.height  * 0.3,

              child: Column(
                children: [
                  Text(
                    'Layers',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: shapes.length,
                      itemBuilder: (context, index) {
                        this.index = shapes.length - 1;
                        isTimerStart = true;

                        return GestureDetector(
                            onTap: () {
                              // onselscted

                              setState(() {
                                isTimerStart = false;
                                this.index = index;

                                seletItem(index);
                              });
                            },
                            child: Column(
                              children: [
                                AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    decoration: BoxDecoration(
                                      color: shapes[index].isSelected
                                          ? Colors.blue.withOpacity(0.5)
                                          : Colors.white,
                                    ),
                                    child: MobileLayersItem(
                                        shape: shapes[index] ,
                                    delete: () {
                                       bloc.add(OnLayerDelete(shape: shapes[index]));
                                    },
                                    moveUp: () {
                                        bloc.add(OnLayerMoveUp(shape: shapes[index]));
                                    },
                                    moveDown: () {
                                        bloc.add(OnLayerMoveDown(shape: shapes[index]));
                                    },
                                    )),
                                const Divider(
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                ],
              ),
            )));
  }

  void seletItem(int index) {
    for (var item in shapes) {
      print(item);
      item.isSelected = false;
    }
    shapes[index].isSelected = true;

    bloc.add(OnLayerItemClick(shape: shapes[index]));
  }
}

