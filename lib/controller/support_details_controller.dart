import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../app_config.dart';

class SupportDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxString sType = "".obs;
  RxString data = "".obs;
  int textFieldCount = 2;
  TextEditingController typeCtrl = TextEditingController();
  TextEditingController dataCtrl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<ParseObject> sData = <ParseObject>[].obs;
  QueryBuilder<ParseObject> supportData =
      QueryBuilder<ParseObject>(ParseObject('Support'))
        ..orderByDescending('createdAt');

  Future<void> registerDetails() async {
    print("Called register details");
    isLoading.value = true;
    try {
      ParseObject adData = ParseObject('Support')
        ..set('supportType', sType)
        ..set('data', data);
      ParseResponse adResult = await adData.create();
      if (adResult.success) {
        isLoading.value = false;
        loadData();
        Get.back();
      } else {
        isLoading.value = false;
        final snackBar = SnackBar(
          content: Text(
            "Error ! Please try again.",
            style: kInterText,
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      }
    } catch (e) {
      isLoading.value = false;
      print("default error---" + e);
      final snackBar = SnackBar(
        content: Text(
          "Error ! Please try again.",
          style: kInterText,
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    } finally {
      print("Finally executed");
    }
  }

  Future<void> editData(ParseObject object) async {
    isLoading.value = true;
    try {
      object..set('supportType', sType)..set('data', data);
      ParseResponse adResult = await object.save();
      if (adResult.success) {
        isLoading.value = false;
        loadData();
        Get.back();
      } else {
        isLoading.value = false;
        final snackBar = SnackBar(
          content: Text(
            "Error ! Please try again.",
            style: kInterText,
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      }
    } catch (e) {
      isLoading.value = false;
      print("default error---" + e);
      final snackBar = SnackBar(
        content: Text(
          "Error ! Please try again.",
          style: kInterText,
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    } finally {
      print("Finally executed");
    }
  }

  Future<void> loadData() async {
    isLoading.value = true;
    print("called load ad data");
    try {
      print("execute try");
      ParseResponse result = await supportData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        sData(result.results);
        print("this is the list $sData");
      } else {
        isLoading.value = false;
        final snackBar = SnackBar(
          content: Text(
            "Error ! Please try again.",
            style: kInterText,
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      }
    } catch (e) {
      isLoading.value = false;
      print("default error---" + e);
      final snackBar = SnackBar(
        content: Text(
          "Error ! Please try again.",
          style: kInterText,
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    } finally {
      print("Finally executed");
    }
  }

  Future<void> deleteData(ParseObject object) async {
    isLoading.value = true;
    try {
      ParseResponse adResult = await object.delete();
      if (adResult.success) {
        isLoading.value = false;
        print("deleted successfully");
        loadData();
      } else {
        isLoading.value = false;
        final snackBar = SnackBar(
          content: Text(
            "Error ! Please try again.",
            style: kInterText,
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      }
    } catch (e) {
      isLoading.value = false;
      print("default error---" + e);
      final snackBar = SnackBar(
        content: Text(
          "Error ! Please try again.",
          style: kInterText,
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
    } finally {
      print("Finally executed");
    }
  }
}
