




import 'package:flutter/material.dart';

import 'colors.dart';

class Backgrounds {
// singleton constructor
  Backgrounds._privateConstructor();
  static final Backgrounds instance = Backgrounds._privateConstructor();
  Backgrounds(){
    instance ;
  }

  FixedColors fixedColors = FixedColors();

    LinearGradient screenBackGround() {
    return LinearGradient(
        colors:  fixedColors.screenBackGroundColors,
        begin: Alignment.bottomLeft,
        end: Alignment.topRight
    );
  }

    LinearGradient splashScreenBackGround() {
    return   LinearGradient(
        colors:  fixedColors.backGroundColors,
        begin: Alignment.bottomLeft,
        end: Alignment.topRight
    );
  }


    LinearGradient bottonBackGround() {
    return LinearGradient(
        colors: fixedColors.buttonBackGroundColors,
        begin: Alignment.bottomLeft,
        end: Alignment.topRight
    );
  }

    LinearGradient bottonBackGround2() {
    return LinearGradient(
        colors: fixedColors.button2BackGroundColors,
        begin: Alignment.bottomLeft,
        end: Alignment.topRight
    );
  }


}