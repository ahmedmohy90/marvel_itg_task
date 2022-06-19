import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel_task/presentation/assets_manager.dart';
import 'package:marvel_task/presentation/string_manager.dart';
import 'package:marvel_task/presentation/values_manager.dart';

import '../presentation/color_manager.dart';

Widget progresBarWidget() {
  return Center(
    child: CircularProgressIndicator(
      color: ColorManager.primary,
    ),
  );
}

Widget imageCharactersWidget(BuildContext context, String image, double height, double width) {
  return  CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
         
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      placeholder: (context, url) =>  SizedBox(
        height: height,
        width: width,
        child: Center(
          child: CircularProgressIndicator(
             color:ColorManager.primary
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: ColorManager.secondary,
        child: SizedBox(
            width: double.infinity,
            height: AppHeight.h160,
            child: Image.asset(AssetManager.logoImage)),
      ),
    
  );
}

Widget imageWidget(BuildContext context, String image, double height, double width) {
  return  CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
         
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) =>  SizedBox(
        height: height,
        width: width,
        child: Center(
          child: CircularProgressIndicator(
             color:ColorManager.primary
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: ColorManager.secondary,
        child: SizedBox(
            width: double.infinity,
            height: AppHeight.h160,
            child: Image.asset(AssetManager.logoImage)),
      ),
    
  );
}

navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (ctx) => widget),
  );
}
popScreen(BuildContext context) {
  Navigator.pop(
    context,
  );
}
