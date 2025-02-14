import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../../../../../drow_engen/core/bloc/main_bloc/main_bloc.dart';
import '../../../../../../../../../../../drow_engen/core/models/drow_tools.dart';
class AppMobileToolBoxItems extends StatelessWidget {
    AppMobileToolBoxItems({super.key , required  this.shapeType ,    });
DrawTools shapeType ;

  @override
  Widget build(BuildContext context) {

    var bloc = context.read<DrawEngineMainBloc>();
    return    MaterialButton(
      onPressed:   (){
        bloc.add(OnNewShapeAdded(shape: shapeType.onShapeClick()));
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child:shapeType.iconSvg !=null ?SvgPicture.asset(shapeType.iconSvg! ,width:  20.w, height:  20.h ,) :  Icon(shapeType.icon , size: 15.sp ,)),
          SizedBox(width: 10,),
          Text(shapeType.shape.name  , style:  Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 20),)
        ],
      ),
    ) ;
  }
}


