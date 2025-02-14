import 'dart:ui';

import 'package:JoDija_view/util/view_data_model/base_data_model.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseShape   {
  int id ;
  String name;
 late  String key  ;
 String type ;

 bool isSelected = false;

  BaseShape({required this.id, required this.name
  ,this.key="" , this.type = "BaseShap"
  }){
    if (key == ""){
      key =  name ;
    }
  }
  void drawShape(Canvas canvas )  ;
Map<String , dynamic> toJson() {
  return {
    "id": id,
    "name": name,
    "key": key,
    "type": type,
    "isSelected": isSelected
  };
}
  @override
  String toString() {
    return 'BaseShape{id: $id, name: $name, key: $key, type: $type, isSelected: $isSelected}';
  }
Widget get propertyBoox => Container();
}