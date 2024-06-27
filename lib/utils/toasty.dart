import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_booking/utils/helper.dart';

import '../values/dimen.dart';
import '../values/theme_colors.dart';


class Toasty {
  static void success(String msg, {duration = 2}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: duration,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: fontSizeLarge);
  }

  static void failed(String msg, {duration = 2}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: duration,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: fontSizeLarge);
  }

  static void info(String msg, {duration = 2}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: duration,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: fontSizeLarge);
  }

  static void normal(String msg, {duration = 2}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: duration,
        backgroundColor: ThemeColors.colorPrimary,
        fontSize: fontSizeLarge);
  }

}



class CustomToast {
  static void show(BuildContext context, String message, String image,
      {Color color=Colors.orangeAccent,int duration=2,double vPadding= 5,double hPadding=10}) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: hPadding,vertical: vPadding),
              decoration: BoxDecoration(
                color: color, // your app's theme color
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // image==''?empty():assetImage(image,width: 40,height: 40),
                10.hs,
                  Text(
                    message,
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(overlayEntry);

    Future.delayed(Duration(seconds: duration), () {
      overlayEntry.remove();
    });
  }
}
