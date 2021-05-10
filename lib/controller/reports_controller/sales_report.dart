import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm_admin/app_config.dart';

class SalesReportController extends GetxController {
  RxBool isLoading = false.obs;
  RxList salesReport = [].obs;

  Future<void> loadSalesReport() async {
    isLoading.value = true;
    print("called load client ");
    try {
      QueryBuilder<ParseObject> client =
          QueryBuilder<ParseObject>(ParseObject('SalesMetadata'))
            ..orderByDescending('clientsRegistered');

      print("execute try");
      ParseResponse result = await client.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        salesReport(result.results);
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

/*
  Future<void> loadClientReport(String name) async {
    isLoading.value = true;
    print("called load client report");
    try {
      QueryBuilder<ParseObject> fbData =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..whereEqualTo('customerName', name)
            ..count();

      print("execute try");
      ParseResponse result = await fbData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        clientReport(result.results);
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
*/

  Future<void> deleteFeedBack(ParseObject object) async {
    isLoading.value = true;
    try {
      ParseResponse adResult = await object.delete();
      if (adResult.success) {
        isLoading.value = false;
        //loadFeedBack();
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
}
