import 'package:flutter/material.dart';
import 'package:get/get.dart';

buildLoader() {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 1,
      valueColor:
          AlwaysStoppedAnimation<Color>(Theme.of(Get.context).accentColor),
    ),
  );
}

buildLoaderDash() {
  return Container(
    height: 25,
    alignment: Alignment.topLeft,
    width: 20,
    child: CircularProgressIndicator(
      strokeWidth: 1,
      valueColor:
          AlwaysStoppedAnimation<Color>(Theme.of(Get.context).primaryColorDark),
    ),
  );
}
