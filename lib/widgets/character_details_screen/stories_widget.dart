import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_task/model/character_comics.dart';
import 'package:marvel_task/model/character_events_model.dart';
import 'package:marvel_task/model/character_storeis_model.dart';
import 'package:marvel_task/presentation/assets_manager.dart';

import '../../presentation/color_manager.dart';
import '../../presentation/font_manager.dart';
import '../../presentation/style_manager.dart';
import '../../presentation/values_manager.dart';
import '../../utilities/common_fns.dart';
import 'priview_images_widget.dart';

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({Key? key, required this.storiesList, required this.stories}) : super(key: key);
  final StoresModel stories;
  final List<StoresModel> storiesList;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         navigateTo(context, PriviewImagesWidget(storiesList));
      },
      child: Container(
                                    margin: EdgeInsets.only(right: AppWidth.w8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                          stories.thumbnail.path == ""
                                         ?SizedBox(
                                            height: AppHeight.h152,
                                          width: AppWidth.w100,
    
                                           child: Image.asset( AssetManager.marvelLogo, fit: BoxFit.fill, ),
                                         )
                                        :Container(
                                          child: imageWidget(context,'${stories.thumbnail.path}.jpg', 
                                          AppHeight.h152,
                                           AppWidth.w100,),
                                        ),
                                         SizedBox(
                                           width: AppWidth.w85,
                                           child: Text(
                                             stories.title,
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