 import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../consts/views/assets.dart';



class SplashscreenShow extends StatefulWidget {
  const SplashscreenShow({super.key});

  @override
  State<SplashscreenShow> createState() => _SplashscreenShowState();
}

class _SplashscreenShowState extends State<SplashscreenShow> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(MyAsset.imglogo),
                ).animate().fadeIn(duration: Duration(milliseconds: 1200)),
                SizedBox(height: 200.h),
                Text("Express your feelings",
                        style: Theme.of(context).textTheme.headlineLarge)
                    .animate()
                    .fadeIn(
                        delay: Duration(milliseconds: 2000),
                        duration: Duration(milliseconds: 600))
                    .moveY(
                        delay: Duration(milliseconds: 2000),
                        duration: Duration(milliseconds: 600))
              ],
            ),
          )),
    );
  }
}
