
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_booking/utils/helper.dart';


class ExitDialog{
  String title;
  String heading;
  Function() callback;
  ExitDialog(this.title,this.callback,this.heading){
    exitDialog();
  }

  void exitDialog(){
    Get.dialog(
      Dialog(
        child: Container(
          width: 100.w,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(heading.nullSafe,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
              10.vs,
              Text(title.nullSafe),
                10.vs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){Get.back();}, child: Text("no".tr,style: TextStyle(color: Colors.black),),),
                    TextButton(onPressed: (){
                      callback();
                    }, child: Text("yes".tr,style: TextStyle(color: Colors.black),),),
                  ],
                )
            ],
          ),
        ),
      )
    );
  }

}