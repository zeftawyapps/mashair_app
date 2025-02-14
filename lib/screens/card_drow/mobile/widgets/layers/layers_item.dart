import 'package:flutter/material.dart';

import '../../../../../../../../../../drow_engen/core/contrallers/drow_tools_contraller.dart';
import '../../../../../../../../../../drow_engen/core/interfaces/base_shap.dart';


class MobileLayersItem extends StatelessWidget {
  MobileLayersItem({super.key, required this.shape , required this.delete , required this.moveUp , required this.moveDown});
  BaseShape shape;
  var delete;
  var moveUp;
  var moveDown;

  @override
  Widget build(BuildContext context) {
    return loadPrperty();
  }

   Widget  loadPrperty() {
    DrawToolsController drawToolsController = DrawToolsController();

    return ListTile(
      leading:  Icon(drawToolsController.getToolIcon(shape),size: 20,),
      title: Text(' ${shape.key}', style: TextStyle(fontSize: 15)),
      subtitle: Row(
        children: [
          Expanded(
              flex:  3 ,
              child: Text(' ${shape.name}', style: TextStyle(fontSize: 12))),
          // add  move up and down button and delete button
          Expanded(
            child: IconButton(
              icon: Icon(Icons.arrow_upward , size: 20,),
              onPressed: () {
                // move up
                moveUp();
              },
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.arrow_downward , size: 20,),
              onPressed: () {
                // move down
                moveDown();

              },
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.delete , color: Colors.red, size: 20,),
              onPressed: () {
                // delete
                delete();
              },
            ),
          ),
        ],
      )

    );
  }


 }
