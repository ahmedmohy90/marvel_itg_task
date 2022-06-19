import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_task/model/character_comics.dart';
import 'package:marvel_task/widgets/character_details_screen/priview_images_widget.dart';

import '../../presentation/color_manager.dart';
import '../../presentation/font_manager.dart';
import '../../presentation/style_manager.dart';
import '../../presentation/values_manager.dart';
import '../../utilities/common_fns.dart';

class ComicsWidget extends StatelessWidget {
   ComicsWidget({Key? key, required this.comic, required this.comics}) : super(key: key);
  final ComicsModel comic;
  List<ComicsModel> comics;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateTo(context, PriviewImagesWidget(comics));
      },
      child: Container(
                                    margin: EdgeInsets.only(right: AppWidth.w8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        imageWidget(context, 
                                        '${comic.thumbnail.path}.jpg', 
                                        AppHeight.h152,
                                         AppWidth.w100,),
                                         SizedBox(
                                           width: AppWidth.w85,
                                           child: Text(
                                             comic.title,
                                              style: getRegularStyle(
                                                fontSize: FontSize.s12, 
                                                color: ColorManager.white,),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textScaleFactor: 0.75,
                                                ),
                                         ),
                                      ],
                                    ),
                                  ),
    );
                        
  }
}