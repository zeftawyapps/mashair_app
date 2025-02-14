import 'package:flutter/material.dart';

import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDimension {

  // singleton constructor
 ScreenType screenType;
  MyDimension(this.screenType) ;
    double headerHeight = 900.h;
    double appBarHeight = 400.h;
    double spaceSizeHeight = 20.h;
    double spaceSizeWidth = 20.w;
    double cardSpaceSizeHeight = 20.h;
    double CardSpaceSizeWidth = 20.w;
    double footerHeight = 400.h;
    double contentHeight = 8000.h;
    double screenPadding = 10.sp;
    double cardWidth = 500.w;
    double cardHeight = 300.h;
    double cardHeightOptions = 600.h;
    double cardWidthOptions = 300.w;
    double cardPadding = 5.sp;
    double reduce = 10.sp;
}

class MyFontStyle {
  // singleton constructor

 ScreenType screenType;
  MyFontStyle(this.screenType) ;

    double headerTitle() =>  screenType == ScreenType.web ?  10.sp     :  20.sp;
    double headerDescribtion = 10.sp;
    double buttonSize = 20.sp;
    double cardTitle = 20.sp;
    double cardText = 7.sp;
    double title = 20.sp;
    double text() => screenType ==ScreenType.web? 8.sp: 9.sp  ;
 double textTitle() => screenType ==ScreenType.web? 8.sp: 11.sp;
 double textListItem() => screenType ==ScreenType.web? 8.sp: 15.sp;

 double textTitleBar() => screenType ==ScreenType.web? 8.sp: 15.sp;

 double small = 10.sp;
    double editText = 10.sp;
    double icon = 10.sp;





}
