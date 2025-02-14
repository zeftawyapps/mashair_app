import 'package:flutter/material.dart%20';

import 'interfaces/base_shap.dart';

class ShowPropertyDialogs<  T extends BaseShape >{

  BaseShape shape ;

  double? height ;
  double? width ;

  ShowPropertyDialogs({
     required this.shape
    , this.height , this.width
  });

  Future<void> showDialogs(
      BuildContext context, {

        void Function( T? data)? onResult,
      }) async {
    double h =    MediaQuery.of(context).size.height;
    double w =   MediaQuery.of(context).size.width;

    if (h > 700 ) {
      showDialog<T?> (
          context: context,
          builder: (_) {
            return
                 Dialog(child: Container(
                    width:width ??  w * 0.9,
                    height:  height ??   h * 0.4,

                    child: shape.propertyBoox )) ;
          }).then((value) =>
      {onResult!(value)});
    } else {
      showModalBottomSheet<T?> (
          context: context,
          builder: (_) {
            bool iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
            return   Container(
                  width:width ??  w * 0.9,
                  height: iskeyboard ? 20000 : height ??   h * 0.4,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SingleChildScrollView(
                        child: Container(

                          // height: iskeyboard ? height ??   h * 1.2 : height ??  h * .1,
                          child: shape.propertyBoox ,
                        ),
                      )),
                ) ;
          }).then((value) => {onResult!(value)});
    }
  }
}
