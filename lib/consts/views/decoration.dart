import 'package:JoDija_view/theams/decorations/docorations.dart';
import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'dimension.dart';
import 'fons.dart';

class MyDecorations implements AppDecorations {
  ScreenType screenType = ScreenType.web;
  ThemeMode themeMode = ThemeMode.light;

  MyDecorations(BuildContext context) {
    screenType = ScreenTypeExtension.fromMediaQueryData(MediaQuery.of(context));
// get theme mode
  }

  @override
  BoxDecoration botton() {
    return BoxDecoration(
      color: themeMode == ThemeMode.light
          ? LightColors().primary
          : DarkColors().primary,
      borderRadius: BorderRadius.circular(25),
    );
  }

  @override
  BoxDecoration card() {
    // add shadow box
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: themeMode == ThemeMode.light
              ? LightColors().shadow
              : DarkColors().shadow,
          spreadRadius: 0.2,
          blurRadius: 3,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    );
  }

  @override
  BoxDecoration Profilecard() {
    // add shadow box
    return BoxDecoration(
      color: themeMode == ThemeMode.light
          ? Colors.white
          : Colors.black,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: themeMode == ThemeMode.light
              ? LightColors().shadow
              : DarkColors().shadow,
          spreadRadius: 0.5,
          blurRadius: 3,
          offset: Offset(1, 3), // changes position of shadow
        ),
      ],
    );
  }
  @override
  BoxDecoration Ideacard() {
    // add shadow box

    return BoxDecoration(

      color: themeMode == ThemeMode.light
          ? Colors.white
          : Colors.black,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: themeMode == ThemeMode.light
              ? LightColors().shadow
              : DarkColors().shadow,
          spreadRadius: 0.5,
          blurRadius: 3,
          offset: Offset(1, 3), // changes position of shadow
        ),
      ],
    );
  }
  @override
  BoxDecoration container() {
    return BoxDecoration();
  }

  @override
  InputDecoration input() {
    return InputDecoration(
      prefixIconColor: LightColors().iconColor.withOpacity(0.5),

      prefixStyle: MyFontFamily().textStyle.copyWith(
            color: LightColors().primary.withOpacity(0.5),
            fontWeight: FontWeight.normal,
            fontSize: MyFontStyle(screenType!).text(),
          ),

      hintStyle: MyFontFamily().textStyle.copyWith(
            color: LightColors().primary.withOpacity(0.5),
            fontSize: MyFontStyle(screenType!).text(),
          ),
      labelStyle: MyFontFamily().textStyle.copyWith(
            color: LightColors().primary.withOpacity(0.5),
            fontSize: MyFontStyle(screenType!).text(),
          ),
      filled: true,
      fillColor: LightColors().inputFill,
      // focusColor: DasgbordColors.textFieldsFoucs,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(50.sp),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(50.sp),
      ),
    );
  }

  BoxDecoration ProfileBar() {
    return BoxDecoration(
      color: themeMode == ThemeMode.light
          ? LightColors().profilBar
          : DarkColors().profilBar,
    );
  }

  @override
  BoxDecoration list() {
    return BoxDecoration();
  }

  @override
  BoxDecoration listItems() {
    return BoxDecoration(
      color: themeMode == ThemeMode.light
          ? LightColors().primary
          : DarkColors().primary,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
