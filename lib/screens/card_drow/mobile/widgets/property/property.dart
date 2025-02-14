import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../../drow_engen/core/bloc/main_bloc/main_bloc.dart';
import '../../../../../../../../../../drow_engen/core/contrallers/property_switcher.dart';
import '../../../../../drow_engen/core/interfaces/base_shap.dart';

class MoblieProperty extends StatefulWidget {
  const MoblieProperty({super.key});

  @override
  State<MoblieProperty> createState() => _MobliePropertyState();
}

class _MobliePropertyState extends State<MoblieProperty> {
late   DrawEngineMainBloc bloc ;
  PropertySwitcher? _propertySwitcher  ;
  late  BaseShape shape ;
  Widget _propertyBox = Container(
    height: 100.h,
    width: 100.w,
    child: Center(
      child: Text('اختار شكل' , style: TextStyle(fontSize: 20.sp),
    ),
  ));
  @override
  Widget build(BuildContext context) {
    bloc = context.read<DrawEngineMainBloc>();
    BaseShape? shape = bloc!.engen!.selectedShape;
    if (shape != null) {
      _propertyBox =  bloc!.engen!.selectedShape!.propertyBoox  ;
    }
    return Container(


          child: BlocListener<DrawEngineMainBloc, MainState>(
            listener: (context, state) {

              if (state is ShapeSelected) {
                _propertyBox = Container();
             BaseShape shape = state.shape;
              _propertyBox =   shape.propertyBoox ;
              // _propertyBox  =Container();
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _propertyBox,
                  ],
                ),
              ),
            ),
          ),
        ) ;
  }
}
