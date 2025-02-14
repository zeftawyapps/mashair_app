import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../consts/views/colors.dart';

class Loading3 extends StatefulWidget {
      Loading3({super.key , this.isloading = false });
 bool isloading = false ;

  @override
  State<Loading3> createState() => _Loading3State();
}

class _Loading3State extends State<Loading3> {

    String category1 = "assets/img/laocal_image/c3.png";
    String category2 = "assets/img/laocal_image/c2.png";
    String category4 = "assets/img/laocal_image/c4.png";
    String category5 = "assets/img/laocal_image/c5.png";
    String category6 = "assets/img/laocal_image/c6.png";

    List<String> categories = [  ];


    int i = 0;
 late  Timer timer ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = [ category1,  category2,  category4,  category5,  category6];


   timer =     Timer .periodic(Duration(milliseconds: 600), (timer) {
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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        color: widget.  isloading? Colors.black.withOpacity(0.5): Colors.transparent,
        child: Center(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),

                     image: DecorationImage(
                       image: AssetImage(categories[i]),
                       fit: BoxFit.cover
                     ),
                  ),
                  height: 100.h,
                  width: 100.w,
                ),
                SizedBox(height: 10.h,),
                Text("جاري التحميل" , style: TextStyle(color: Colors.white , fontSize: 20.sp),).animate().fadeIn(
                  duration: Duration(milliseconds: 600),
                ),
              ],
            ) ,

        ),
      ),
    )
    .animate().fadeIn(
      duration: Duration(milliseconds: 600),
     )
    ;
  }
}
