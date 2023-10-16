import 'package:flutter/material.dart';
import 'package:flutter_structure/helpers/colors.dart';
import 'package:flutter_structure/helpers/values.dart';

class SnackBarHelper {
  SnackBarHelper._();

  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackbar(
    Widget content, {
    Duration? duration,
    Color? backgroundColor,
    Alignment? alignment,
    double? height,
  }) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 1000,
          duration:
              duration ?? const Duration(milliseconds: AppValues.lowDuration),
          content: Container(
            height: height ?? AppValues.snackbarHeight,
            alignment: alignment ?? Alignment.center,
            child: content,
          ),
          margin: const EdgeInsets.only(
            // bottom: ScreenUtil().screenHeight -
            //     (Platform.isAndroid ? 100 : ScreenUtil().statusBarHeight * 3)
            bottom: 15,
            left: 10,
            right: 10,
          ),
          backgroundColor: backgroundColor ?? AppColors.transparentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      );
  }
}
