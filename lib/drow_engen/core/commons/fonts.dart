 import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class FontsList {
 List<TextStyle> _fonts =[];

 List<TextStyle> getList(){
   // get all the fonts from the google fonts
    _fonts.add(GoogleFonts.roboto());
    _fonts.add(GoogleFonts.reemKufi());
    _fonts.add(GoogleFonts.tajawal());
    _fonts.add(GoogleFonts.abel());
    _fonts.add(GoogleFonts.acme());
    _fonts.add(GoogleFonts.anton());
    _fonts.add(GoogleFonts.archivo());
    _fonts.add(GoogleFonts.arimo());
    _fonts.add(GoogleFonts.cairo());
    _fonts.add(GoogleFonts.averiaLibre());
    _fonts.add(GoogleFonts.notoKufiArabic());
    _fonts.add(GoogleFonts.farro());
    _fonts.add(GoogleFonts.firaSans());
    _fonts.add(GoogleFonts.ibmPlexSansArabic());
    _fonts.add(GoogleFonts.changa());
    _fonts.add(GoogleFonts.amiri());
    _fonts.add(GoogleFonts.lalezar());
    _fonts.add(GoogleFonts.lateef());


     // get all the fonts from the google fonts




   return _fonts;
 }

}