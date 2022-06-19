import 'package:flutter/material.dart';
import 'package:marvel_task/presentation/color_manager.dart';
import 'package:marvel_task/presentation/font_manager.dart';
import 'package:marvel_task/presentation/style_manager.dart';
import 'package:marvel_task/presentation/values_manager.dart';

import '../../utilities/common_fns.dart';

class ShaderMaskWidget extends StatelessWidget {
  String? _imageUrl;
  String? _name;

  ShaderMaskWidget.fromUrl({
    required String imageUrl,
    required String name,
  }) {
    this._imageUrl = imageUrl;
    this._name = name;
  }
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Stack(children: <Widget>[
      ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).backgroundColor, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: NetworkImage(_imageUrl!),
              fit: BoxFit.cover,
            ),
          ),
          height: deviceSize.height * 0.35,
        ),
      ),
      Container(
        height: AppHeight.h100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).backgroundColor, Colors.transparent],
          ),
        ),
      ),
      Positioned(
        bottom: AppHeight.h24,
        left: AppWidth.w16,
        right: AppWidth.w16,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            _name ?? "",
            style:getBoldStyle(fontSize: FontSize.s20, color: ColorManager.secondary)
          ),
        ),
      ),
      Positioned(
        top: AppHeight.h32,
        left: AppWidth.w8,
        child: IconButton(
          onPressed: (){
            popScreen(context);
          },
           icon:  Icon(Icons.arrow_back_ios_new, color: ColorManager.primary,)
           ))
    ]);
  }
}
