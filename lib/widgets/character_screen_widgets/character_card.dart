import 'package:flutter/material.dart';
import 'package:marvel_task/presentation/assets_manager.dart';
import 'package:marvel_task/presentation/color_manager.dart';
import 'package:marvel_task/presentation/font_manager.dart';
import 'package:marvel_task/presentation/style_manager.dart';
import 'package:marvel_task/presentation/values_manager.dart';

import '../../model/characters.dart';
import '../../utilities/common_fns.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
              Stack(
                children:[ 
                  Hero(
                  tag: character.id.toString(),
                  child: imageCharactersWidget(context,'${ character.thumbnail.path}.jpg',AppHeight.h182, double.infinity )     
                ),
                Positioned(
                  bottom: AppHeight.h12,
                  left: AppWidth.w12,
                  child: Stack(
                    children: [
                      Image.asset(AssetManager.marvel_cell),
                      Positioned(
                        top: AppHeight.h6,
                        bottom: 0,
                        left: AppWidth.w12,
                        right: 0,
                        child: Text(
                          character.name,style: getBoldStyle(fontSize: FontSize.s15, color: ColorManager.black),
                        ),
                      )
                    ],
                  ),
                )
                ]
              );
            
        
      
    
  }
}
