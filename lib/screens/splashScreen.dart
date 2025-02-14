import 'package:JoDija_view/util/google_font.dart';
import 'package:JoDija_view/util/widgits/screen_provider/screen_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mashair/screens/splashScreen/splash_screen_logic.dart';

import '../consts/views/assets.dart';
import 'splashScreen/splashScreen_show.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
   static String  routeName = "/splashscreen";
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenViews<SplashScreenLogic>(
      builder: (context, d, c) {
        d.timer();

        return SplashscreenShow();
      },
      notifier: SplashScreenLogic(),
    );
  }
}
