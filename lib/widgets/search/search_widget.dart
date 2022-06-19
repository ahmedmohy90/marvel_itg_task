import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_task/model/characters.dart';

import '../../presentation/color_manager.dart';
import '../../presentation/font_manager.dart';
import '../../presentation/style_manager.dart';
import '../../presentation/values_manager.dart';
import '../../screens/character_details.dart';
import '../../utilities/common_fns.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key, required this.character}) : super(key: key);
  final Character character;
   @override
  Widget build(BuildContext context) {
      return  GestureDetector(
        onTap: (){
          navigateTo(context, CharacterDetailsScreen(character: character,));
        },
        child: Container(
                       color: ColorManager.searchItemBGColor,
                       height: AppHeight.h100,
                       width: double.infinity,
                       child: Row(
                          children: [
                            SizedBox(
                               height: AppHeight.h132,
                               child: imageWidget(context, '${character.thumbnail.path}.jpg', AppHeight.h100, AppWidth.w100),
                            ),
                            SizedBox(width: AppWidth.w12,),
                            Expanded(
                              child: Text(
                               character.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: getSemiBoldStyle(fontSize: FontSize.s16, color: ColorManager.primary,)
                                )
                                ),
                                
                          ],
                       ),
                     ),
      );
           
  }
}