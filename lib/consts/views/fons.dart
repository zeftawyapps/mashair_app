import 'package:flutter/material.dart%20';
import 'package:google_fonts/google_fonts.dart';

class MyFontFamily{
String fontFamilySego = 'segoescript' ;

  TextStyle get headerTitleStyle =>  TextStyle(fontFamily: fontFamilySego, fontSize: 15, fontWeight: FontWeight.bold)  ;
  TextStyle get textStyle =>   GoogleFonts.tajawal(fontSize: 15, fontWeight: FontWeight.bold)  ;

}