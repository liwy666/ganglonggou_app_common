import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ganglong_shop_app/common_import.dart';

class MyToast {
  static showToast({
    @required String msg,
    Toast toastLength,
    int timeInSecForIos = 1,
    double fontSize = COMMON_FONT_SIZE,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backgroundColor,
    Color textColor,
    // Function(bool) didTap,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        gravity: gravity,
        fontSize: fontSize,
        timeInSecForIos: timeInSecForIos,
        backgroundColor: backgroundColor,
        textColor: textColor,
        toastLength: toastLength); //短提示
  }
}
