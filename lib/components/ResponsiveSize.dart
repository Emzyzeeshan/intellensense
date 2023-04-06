import 'package:flutter/material.dart';

class DeviceSizeConfig {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? textScale;
  static double? safeAreaHorizontal;
  static double? safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  static double? paddingRight;
  static double? paddingLeft;
  static double? paddingTop;
  static double? paddingBottom;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData?.size.width;
    screenHeight = mediaQueryData?.size.height;

    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    textScale = mediaQueryData?.textScaleFactor;
    paddingLeft = mediaQueryData?.padding.left;
    paddingRight = mediaQueryData?.padding.right;
    paddingTop = mediaQueryData?.padding.top;
    paddingBottom = mediaQueryData?.padding.bottom;
    safeAreaHorizontal = paddingRight! + paddingRight!;

    safeAreaVertical = paddingTop! + paddingBottom!;
    safeBlockHorizontal = (screenWidth! - safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - safeAreaVertical!) / 100;
  }
}
