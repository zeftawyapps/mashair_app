import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Wave1Castom extends StatelessWidget {
  const Wave1Castom({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Positioned(
          top: MediaQuery.of(context).size.height/2+100.h  ,
          left: 20.w ,
          child: CustomPaint(
            size: Size(400, 400),
            painter: W2(),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height/2+175.h  ,
          left: 0.w ,
          child: CustomPaint(
            size: Size(400, 400),
            painter: W3(),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height/2+210.h  ,
          left: 50.w ,
          child: CustomPaint(
            size: Size(400, 400),
            painter: W1(),
          ),
        ),


      ],
    );
  }
}




class W1 extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Path path_0 = Path();
path_0.moveTo(-118.588,26.9468);
path_0.cubicTo(-62.6209,-7.78973,12.8583,-8.19113,69.2612,25.9078);
path_0.cubicTo(86.2738,36.1993,101.544,49.2628,117.022,61.7928);
path_0.cubicTo(151.188,89.3562,188.509,115.194,231.218,125.332);
path_0.cubicTo(297.685,141.133,372.225,113.656,412.598,58.6154);
path_0.lineTo(370.637,297.075);
path_0.lineTo(-150,205.46);
path_0.lineTo(-118.588,26.9468);
path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0xff976D9D).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}



//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class W2 extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Path path_0 = Path();
path_0.moveTo(-63.3148,21.6749);
path_0.cubicTo(-3.71069,-10.4579,73.9782,-6.28758,130.035,32.0128);
path_0.cubicTo(146.943,43.5717,161.897,57.8601,177.096,71.6155);
path_0.cubicTo(210.652,101.882,247.555,130.574,290.911,143.536);
path_0.cubicTo(358.387,163.732,436.681,140.151,481.419,86.3042);
path_0.lineTo(424.4,327.66);
path_0.lineTo(-106,202.356);
path_0.lineTo(-63.3148,21.6749);
path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0xffF0E6FF).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}



//Copy this CustomPainter code to the Bottom of the File
class W3 extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Path path_0 = Path();
path_0.moveTo(467,54.8033);
path_0.cubicTo(422.696,15.2681,355.683,3.13451,300.227,24.5705);
path_0.cubicTo(283.499,31.0417,267.887,40.243,252.173,48.9388);
path_0.cubicTo(217.5,68.0492,180.293,85.1373,140.754,87.4629);
path_0.cubicTo(79.2158,91.103,17.2716,55.1067,-9.99997,0);
path_0.lineTo(-9.99997,218);
path_0.lineTo(467,218);
path_0.lineTo(467,54.8033);
path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0x61c3a9ce).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}