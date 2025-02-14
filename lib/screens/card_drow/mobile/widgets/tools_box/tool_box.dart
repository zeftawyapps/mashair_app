
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mashair/screens/card_drow/mobile/widgets/tools_box/widgets/items.dart';

import '../../../../../../../../../../drow_engen/core/contrallers/drow_tools_contraller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppMoblieToolBox extends StatefulWidget {
  const AppMoblieToolBox({super.key});

  @override
  State<AppMoblieToolBox> createState() => _AppMoblieToolBoxState();
}

class _AppMoblieToolBoxState extends State<AppMoblieToolBox> {
  @override
  Widget build(BuildContext context) {
    DrawToolsController drawToolsController = DrawToolsController();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70.h,

      child: ListView (
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 10,
          ),
          for (var item in drawToolsController.tools)
            AppMobileToolBoxItems(
              shapeType: item,
            )
        ],
      ),
    );
  }
}
