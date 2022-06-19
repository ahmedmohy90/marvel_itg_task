import 'package:flutter/material.dart';
import 'package:marvel_task/model/character_comics.dart';
import 'package:marvel_task/presentation/assets_manager.dart';
import 'package:marvel_task/presentation/color_manager.dart';
import 'package:marvel_task/presentation/font_manager.dart';
import 'package:marvel_task/presentation/string_manager.dart';
import 'package:marvel_task/presentation/style_manager.dart';
import 'package:marvel_task/presentation/values_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../utilities/common_fns.dart';

class PriviewImagesWidget extends StatefulWidget {
  final List<dynamic> data;

  PriviewImagesWidget(this.data);

  @override
  _PriviewImagesWidgetState createState() => _PriviewImagesWidgetState();
}

class _PriviewImagesWidgetState extends State<PriviewImagesWidget> {
  PageController? pageController;
  @override
  void initState() {
    // TODO:implement initState
    super.initState();
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: PageView.builder(
            controller: pageController,
            itemCount: widget.data.length,
            itemBuilder: (context, position) {
              return imageSlider(position);
            })
        //  Center(
        //   child: SizedBox(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height / 2,
        //     child: PhotoViewGallery.builder(
        //       itemCount: widget.comics.length,
        //       builder: (context, index) {
        //         return PhotoViewGalleryPageOptions.customChild(
        //           minScale: PhotoViewComputedScale.contained,
        //           // Covered = the smallest possible size to fit the whole screen
        //           maxScale: PhotoViewComputedScale.covered * 2,
        //           child: Column(
        //             children: [
        //               Expanded(child: imageCharactersWidget(context, '${widget.comics[index].thumbnail.path}.jpg',AppHeight.h642, AppWidth.w254)),
        //               SizedBox(height: AppHeight.h8,),
        //               Text(widget.comics[index].title,style: getSemiBoldStyle(fontSize: FontSize.s14, color: ColorManager.primary),),
        //               SizedBox(height: AppHeight.h8,),
        //               Text('${index.toString()}/${widget.comics.length.toString()}',style: getSemiBoldStyle(fontSize: FontSize.s14, color: ColorManager.primary),)
        //             ],
        //           ),
        //         );
        //       },
        //       scrollPhysics: const BouncingScrollPhysics(),
        //       loadingBuilder: (context, event) => const Center(
        //         child: CircularProgressIndicator(
        //           backgroundColor: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        );
  }

  imageSlider(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: pageController!,
          builder: (context, widget) {
            double value = 1;
            if (pageController!.position.haveDimensions) {
              value = pageController!.page! - index;
              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
            }
            return Center(
              child: SizedBox(
                height: Curves.easeInOut.transform(value) * AppHeight.h193,
                width: Curves.easeInOut.transform(value) * AppWidth.w303,
                child: widget,
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(AppWidth.w8),
            child: 
            widget.data[index].thumbnail.path == ""
            ?Image.asset(AssetManager.marvelLogo)
            :Image.network('${widget.data[index].thumbnail.path}.jpg',
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          height: AppHeight.h8,
        ),
        Text(
          widget.data[index].title,
          style: getSemiBoldStyle(
              fontSize: FontSize.s14, color: ColorManager.primary),
        ),
        SizedBox(
          height: AppHeight.h8,
        ),
        Text(
          '${(index+1).toString()}/${widget.data.length.toString()}',
          style: getSemiBoldStyle(
              fontSize: FontSize.s14, color: ColorManager.primary),
        )
      ],
    );
  }
}
