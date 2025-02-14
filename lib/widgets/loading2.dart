import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../consts/views/colors.dart';

class Loading2 extends StatefulWidget {
      Loading2({super.key , this.color =Colors.red });
Color color;

  @override
  State<Loading2> createState() => _Loading2State();
}

class _Loading2State extends State<Loading2> {
  int i = 0;
 late  Timer timer ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   timer =     Timer .periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        i++;
        if (i == 3) {
          i = 0;
        }
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: i==0? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                color:widget.  color,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 20.h,
              width: 20.w,
            ),
          ) ,
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: i==1? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                color: widget.  color,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 20.h,
              width: 20.w,
            ),
          ) ,
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: i==2? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                color: widget.  color,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 20.h,
              width: 20.w,
            ),
          )
        ],
      )),
    );
  }
}
