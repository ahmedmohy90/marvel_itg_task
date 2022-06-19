import 'package:flutter/material.dart';

class ColorManager{
  static Color primary =Colors.white;
  static Color secondPrimaryColor = HexColor.fromHex('#F01023');
  static Color secondary = HexColor.fromHex("#F3AE4B");
  static Color backgroundColor = HexColor.fromHex('#0D0E0F');
  static Color lightGrayColor = HexColor.fromHex("#CCCCCC");
  static Color searchBGColor = HexColor.fromHex("#24272a");
  static Color searchItemBGColor = HexColor.fromHex("#35373b");
  
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color gray = Colors.grey;
  
  static Color alert = Colors.redAccent;


 
  }

  extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#','');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
                    
    return Color(int.parse(hexColorString, radix: 16));
}
  }