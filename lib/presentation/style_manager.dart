import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      height: 1.4,
      color: color,
      fontWeight: fontWeight);
    }
  // regular style
  TextStyle getLiteStyle(
      {required double fontSize, required Color color}) {
    return _getTextStyle(
        fontSize, FontConstants.fontFamily, FontWeightManager.light, color);
      }
      TextStyle getRegularStyle(
      {required double fontSize, required Color color}) {
    return _getTextStyle(
        fontSize, FontConstants.fontFamily, FontWeightManager.regular, color,);
      }

      // semiBold style
TextStyle getSemiBoldStyle(
    {required double fontSize, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, color);
    }

    // bold style
TextStyle getBoldStyle(
    {required double fontSize, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
    }