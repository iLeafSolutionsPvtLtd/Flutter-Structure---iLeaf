import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingHelper {
  LoadingHelper._();
  static void showLoading({String? text}) {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      status: text,
      indicator: const CircularProgressIndicator.adaptive(),
      dismissOnTap: false,
    );
  }

  static void hideLoading() {
    EasyLoading.dismiss();
  }
}
