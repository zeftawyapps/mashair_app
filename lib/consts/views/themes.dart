import 'package:JoDija_view/theams/theams/theams.dart';
import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mashair/consts/views/fons.dart';
 import 'colors.dart';
import 'dimension.dart';

class Themes extends DashboardThemes  {
  BuildContext  context;
  double? width;
  double? height;
  ScreenType? screenType ;
  Themes( this.context ) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
   screenType =    ScreenTypeExtension.fromMediaQueryData(MediaQuery.of(context));

  }

  @override
  ThemeData light() {
    LightColors appColors = LightColors();
   return  ThemeData(
     textTheme: TextTheme(
       headlineLarge: MyFontFamily().headerTitleStyle.copyWith(
         color: appColors.primary,
         fontSize: MyFontStyle( screenType! ).headerTitle(),
       ) ,
       bodySmall: MyFontFamily().textStyle.copyWith(
         color: appColors.primary,

         fontSize: MyFontStyle( screenType! ).textTitle(),
       ) ,
       displaySmall: MyFontFamily().textStyle.copyWith(
         color: appColors.primary.withOpacity(0.6),
         fontSize: MyFontStyle( screenType! ).text(),
       ) ,
       displayLarge: MyFontFamily().textStyle.copyWith(
         color: appColors.primary,
         fontSize: MyFontStyle( screenType! ).text(),
       ) ,

       displayMedium: MyFontFamily().textStyle.copyWith(
         color: appColors.inputText,
         fontSize: MyFontStyle( screenType! ).text(),
       ) ,
       titleLarge: MyFontFamily().textStyle.copyWith(
         color: Colors.black,
         fontSize: MyFontStyle( screenType! ).textTitleBar(),
       ) ,
       titleSmall: MyFontFamily().textStyle.copyWith(
         color: Colors.black,
         fontSize: MyFontStyle( screenType! ).textListItem(),
       ) ,

     )
  ,
    primaryColorLight: appColors.primary,
    secondaryHeaderColor: appColors.secondary,


    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: appColors.primary,
    ),
    brightness: Brightness.light,

    primaryColor:  appColors.primary,
    appBarTheme:   AppBarTheme(
      backgroundColor: appColors.primary,

      titleTextStyle: MyFontFamily().headerTitleStyle.copyWith(
        color: appColors.textAppBar,
        fontSize: MyFontStyle( screenType! ).headerTitle(),
      ),
      iconTheme: IconThemeData(
        size: 25,
        color:  appColors.iconColor,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: appColors.drawer,
    ),

    iconTheme: IconThemeData(
      color: appColors.iconColor,
      size: 5.sp,
    ),
    inputDecorationTheme: InputDecorationTheme(
prefixIconColor: appColors.iconColor.withOpacity(0.5),

        prefixStyle: MyFontFamily().textStyle.copyWith(
          color: appColors.primary.withOpacity(0.5),
            fontWeight: FontWeight.normal,

          fontSize: MyFontStyle( screenType! ).text(),
        ),



        hintStyle:  MyFontFamily().textStyle.copyWith(
          color: appColors.hintText,
          fontSize: MyFontStyle( screenType! ).text(),
        ) ,
        labelStyle:  MyFontFamily().textStyle.copyWith(
          color: appColors.primary.withOpacity(0.5),
          fontSize: MyFontStyle( screenType! ).text(),
        ) ,
        filled: true,
        fillColor:   appColors.inputFill,
        // focusColor: DasgbordColors.textFieldsFoucs,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(20.sp),
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(50.sp),
        ),));
  }

  @override
  ThemeData dark() {
    DarkColors appColors = DarkColors();
    return  ThemeData(

        primaryColorLight: appColors.primary,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: appColors.primary,
        ),
        brightness: Brightness.light,

        primaryColor:  appColors.primary,
        appBarTheme:   AppBarTheme(
          backgroundColor: appColors.primary,
          titleTextStyle: TextStyle(
            color: appColors.textAppBar,
            fontSize: 15,
          ),
          iconTheme: IconThemeData(
            size: 25,
            color:  appColors.iconColor,
          ),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: appColors.drawer,
        ),

        iconTheme: IconThemeData(
          color: appColors.iconColor,
          size: 5.sp,
        ),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: MyFontFamily().textStyle.copyWith(
              color: appColors.inputText.withOpacity(0.5),
              fontSize: MyFontStyle( screenType! ).text(),
            ) ,
            labelStyle: MyFontFamily().textStyle.copyWith(
              color: appColors.inputText,
              fontSize: MyFontStyle( screenType! ).text(),
            ) ,
            filled: true,
            fillColor:   appColors.inputFill,
            // focusColor: DasgbordColors.textFieldsFoucs,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(3.sp),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(3.sp),
            )));
  }

}
