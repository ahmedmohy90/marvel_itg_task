import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_task/model/character_comics.dart';
import 'package:marvel_task/model/character_events_model.dart';

import '../../presentation/color_manager.dart';
import '../../presentation/font_manager.dart';
import '../../presentation/style_manager.dart';
import '../../presentation/values_manager.dart';
import '../../utilities/common_fns.dart';
import 'priview_images_widget.dart';

class EventsWidget extends StatelessWidget {
  const EventsWidget({Key? key, required this.event, required this.enevnts}) : super(key: key);
  final EventsModel event;
  final List<EventsModel> enevnts;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         navigateTo(context, PriviewImagesWidget(enevnts));
      },
      child: Container(
                                    margin: EdgeInsets.only(right: AppWidth.w8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          child: imageWidget(context, 
                                          '${event.thumbnail.path}.jpg', 
                                          AppHeight.h152,
                                           AppWidth.w100,),
                                        ),
                                         SizedBox(
                                           width: AppWidth.w85,
                                           child: Text(
                                             event.title,
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