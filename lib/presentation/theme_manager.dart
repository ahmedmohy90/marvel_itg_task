  import 'package:flutter/material.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
 return ThemeData(
   // main colors of the app
      primaryColor: ColorManager.primary,
      scaffoldBackgroundColor: ColorManager.backgroundColor,
   );
}