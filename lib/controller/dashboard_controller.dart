import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm_admin/app_config.dart';

class DashController extends GetxController {
  RxInt clientCount = 0.obs;
  RxInt delCount = 0.obs;
  RxInt salesCount = 0.obs;
  RxInt markCount = 0.obs;
  RxInt adCount = 0.obs;
  RxInt productCount = 0.obs;
  RxInt fbCount = 0.obs;
  RxInt ordersCount = 0.obs;
  RxBool isLoading = false.obs;
  Future<void> updateClientCount() async {
    try {
      QueryBuilder<ParseObject> showClient =
          QueryBuilder(ParseObject('UserMetadata'))
            ..whereEqualTo('role', 'Client');

      ParseResponse result = await showClient.count();
      if (result.success) {
        clientCount.value = result.result[0];
      } else {
        print('client count not edited');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error Occured while updating client count', '');
    }
  }

  Future<void> updateDelCount() async {
    try {
      QueryBuilder<ParseObject> showDel =
          QueryBuilder(ParseObject('UserMetadata'))
            ..whereEqualTo('role', 'DeliveryBoy');

      ParseResponse result = await showDel.count();
      if (result.success) {
        delCount.value = result.result[0];
      } else {
        print('client count not edited');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error Occured while updating client count', '');
    }
  }

  Future<void> updateSalesCount() async {
    try {
      QueryBuilder<ParseObject> showSales =
          QueryBuilder(ParseObject('UserMetadata'))
            ..whereEqualTo('role', 'SalesPerson');

      ParseResponse result = await showSales.count();
      if (result.success) {
        salesCount.value = result.result[0];
      } else {
        print('client count not edited');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error Occured while updating client count', '');
    }
  }

  Future<void> updateMarkCount() async {
    try {
      QueryBuilder<ParseObject> showMark =
          QueryBuilder(ParseObject('UserMetadata'))
            ..whereEqualTo('role', 'Marketing');

      ParseResponse result = await showMark.count();
      if (result.success) {
        markCount.value = result.result[0];
      } else {
        print('client count not edited');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error Occured while updating client count', '');
    }
  }

  Future<void> updateAdCount() async {
    isLoading.value = true;
    print("called load ad data");
    try {
      QueryBuilder<ParseObject> adData =
          QueryBuilder<ParseObject>(ParseObject('Advertisement'))
            ..orderByDescending('createdAt');

      print("execute try");
      ParseResponse result = await adData.count();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        adCount.value = result.result[0];
        // ignore: deprecated_member_use
        if (!result.isBlank) {
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

  Future<void> updateProCount() async {
    isLoading.value = true;
    print("called load ad data");
    try {
      QueryBuilder<ParseObject> products =
          QueryBuilder<ParseObject>(ParseObject('Products'))
            ..orderByDescending('createdAt');

      print("execute try");
      ParseResponse result = await products.count();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        productCount.value = result.result[0];
        // ignore: deprecated_member_use
        if (!result.isBlank) {
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

  Future<void> updateFeedbackCount() async {
    isLoading.value = true;
    print("called load ad data");
    try {
      QueryBuilder<ParseObject> fbData =
          QueryBuilder<ParseObject>(ParseObject('Feedback'))
            ..orderByDescending('createdAt');

      print("execute try");
      ParseResponse result = await fbData.count();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        fbCount.value = result.result[0];
        // ignore: deprecated_member_use
        if (!result.isBlank) {
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

  Future<void> updateOrdersCount() async {
    isLoading.value = true;
    print("called load ad data");
    try {
      QueryBuilder<ParseObject> orders =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..orderByDescending('createdAt');

      print("execute try");
      ParseResponse result = await orders.count();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        ordersCount.value = result.result[0];
        // ignore: deprecated_member_use
        if (!result.isBlank) {
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
