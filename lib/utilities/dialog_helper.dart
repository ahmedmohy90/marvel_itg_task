import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../presentation/color_manager.dart';
import '../presentation/font_manager.dart';
import '../presentation/string_manager.dart';
import '../presentation/style_manager.dart';
import '../presentation/values_manager.dart';

class ShowDialogHelper {
 
  static void showSuccessMessage(String message1 ,String message2, BuildContext context) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context);

    fToast.showToast(
      
      toastDuration:const  Duration(seconds: 4),
      gravity: ToastGravity.BOTTOM,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding:const  EdgeInsets.all(8),
          decoration:  BoxDecoration(
            color:ColorManager.primary,
            borderRadius: BorderRadius.all(Radius.circular(AppHeight.h8)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              Text(
                message1,
                style: getBoldStyle(fontSize: FontSize.s14, color: ColorManager.white)
              ),
             const  SizedBox(height: 8,),
              Text(
                message2,
                style: getRegularStyle(fontSize: FontSize.s14, color: ColorManager.white)
              ),
            ],
          ),
        ),
      ),
    );
  }

static void showErrorMessage(String message, BuildContext context) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context);

    fToast.showToast(
      toastDuration: const Duration(seconds: 3),
      gravity: ToastGravity.BOTTOM,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding:const  EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorManager.alert,
            borderRadius:  BorderRadius.all(Radius.circular(AppHeight.h8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              Expanded(
                child: Text(
                  message,
                  style: getRegularStyle(fontSize: FontSize.s14, color: ColorManager.white)
                ),
              ),
               const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.error,
                color: Colors.white,
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  
  
  

}
