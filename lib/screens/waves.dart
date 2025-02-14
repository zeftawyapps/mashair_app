import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/consts/views/assets.dart';
class Waves extends StatelessWidget {
  const Waves({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height/2+80.h  ,
            left: -70.w ,

             child: Image(image: AssetImage(MyAsset.wave2),
              width: 526.6.w,
              height: 280.12.h,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height/2+100.h  ,
            left: -100.w ,
            child: Image(image: AssetImage(MyAsset.wave3),
              width: 526.6.w,
              height: 242.12.h,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height/2+100.h  ,
            left: -100.w ,
            child: Image(image: AssetImage(MyAsset.wave1),
              width: MediaQuery.of(context).size.width.w+180.w,
              height: 340.12.h,
            ),
          ),


        ],
      ),
    );
  }
}
