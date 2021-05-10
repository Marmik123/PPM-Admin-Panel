import 'package:flutter/material.dart';
import 'package:get/get.dart';

buildLoader() {
  return CircularProgressIndicator(
    strokeWidth: 1,
    valueColor:
        AlwaysStoppedAnimation<Color>(Theme.of(Get.context).accentColor),
  );
}
