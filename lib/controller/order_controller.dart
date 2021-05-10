import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/reports_controller/advertisement_report.dart';

class OrderController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool ongoingO = false.obs;
  RxBool pastO = false.obs;
  RxBool showPaginatedList = false.obs;
  RxList isBoyAssigned = [].obs;
  RxInt assignDelBoy = 0.obs;
  RxInt startIndex = 0.obs;
  RxList paginatedList = [].obs;
  RxList pastPaginatedList = [].obs;
  RxList<ParseObject> orderList = <ParseObject>[].obs;
  RxList orderDetails = [].obs;
  RxInt pageNo = 0.obs;
  RxInt pastOPageNo = 0.obs;
  RxList<ParseObject> pastOrders = <ParseObject>[].obs;
  RxList pastOrderDetails = [].obs;
  RxBool boyAssigned = false.obs;
  AdReportC adR = Get.put(AdReportC());
  /* QueryBuilder<ParseObject> deliveryBoy =
  QueryBuilder<ParseObject>(ParseObject('Orders'))
    ..orderByDescending('createdAt');*/
/*
  Future<void> loadPaginatedData() async {
    ongoingO.value = true;
    print("called load order data");
    try {
      print("execute try");
      ParseResponse result = await skippedOrderData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        */
/*orderList.removeRange(0, orderList.length);*/ /*

        orderList(result.results);
        paginatedList.removeRange(0, paginatedList.length);
        paginatedList(
            orderList.sublist(startIndex.value, startIndex.value + 10));
        startIndex.value += 10;

        ongoingO.value = false;
        isLoading.value = false;
        isBoyAssigned.length = orderList.length;
        print("0000000 length of boolean list${isBoyAssigned.length}");
        isBoyAssigned.fillRange(0, isBoyAssigned.length, boyAssigned);
        print(isBoyAssigned);
        print("this is the list $orderData");
      } else {
        ongoingO.value = false;
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
      ongoingO.value = false;
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

  Future<void> loadData() async {
    ongoingO.value = true;
    print("called load order data");
    try {
      print("execute try");

      QueryBuilder<ParseObject> orderData =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..orderByDescending('createdAt')
            ..setLimit(10)
            ..setAmountToSkip(pageNo * 10)
            ..whereNotEqualTo('deliveryStatus', 'yes');

      ParseResponse result = await orderData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        orderList.removeRange(0, orderList.length);
        orderList(result.results);
        paginatedList.removeRange(0, paginatedList.length);
        paginatedList(
            orderList.sublist(startIndex.value, startIndex.value + 10));

        ongoingO.value = false;
        isLoading.value = false;
        isBoyAssigned.length = orderList.length;
        print("0000000 length of boolean list${isBoyAssigned.length}");
        isBoyAssigned.fillRange(0, isBoyAssigned.length, boyAssigned);
        print(isBoyAssigned);
        print("this is the list $orderList");
      } else {
        ongoingO.value = false;
        final snackBar = SnackBar(
          content: Text(
            "Error in displaying ongoing order! Please try again.",
            style: kInterText,
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      }
    } catch (e) {
      ongoingO.value = false;
      print("default error---" + e);
      final snackBar = SnackBar(
        content: Text(
          "Error in displaying ongoing order! Please try again.",
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

  Future<void> loadPastData() async {
    pastO.value = true;
    print("called load past order data");
    try {
      print("execute try");
      QueryBuilder<ParseObject> pastOrderData =
          QueryBuilder<ParseObject>(ParseObject('Orders'))
            ..orderByDescending('updatedAt')
            ..setLimit(10)
            ..setAmountToSkip(pastOPageNo.value * 10)
            ..whereEqualTo('deliveryStatus', 'yes');

      ParseResponse result = await pastOrderData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        pastOrders.removeRange(0, pastOrders.length);
        pastOrders(result.results);

        /* pastPaginatedList.removeRange(0, paginatedList.length);
        pastPaginatedList(
            orderList.sublist(startIndex.value, startIndex.value + 10));
*/
        pastO.value = false;
        /*isBoyAssigned.length = orderList.length;
        print("0000000 length of boolean list${isBoyAssigned.length}");
     */ //isBoyAssigned.fillRange(0, isBoyAssigned.length, boyAssigned);
        // print(isBoyAssigned);
        //print("this is the list $pastOrders");
      } else {
        pastO.value = false;
        final snackBar = SnackBar(
          content: Text(
            "Error in displaying past orders! Please try again.",
            style: kInterText,
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      }
    } catch (e) {
      pastO.value = false;
      print("default error---" + e);
      final snackBar = SnackBar(
        content: Text(
          "Error in displaying past orders! Please try again.",
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

  Future<void> assignAd(
      String name,
      String id,
      int rowIndex,
      int orderItemIndex,
      Map<String, dynamic> orderObject,
      List orderDetails,
      String oId) async {
    isLoading.value = true;
    try {
      // List<Map<String, dynamic>> orderDet = orderDetails;
      var objId = oId;
      //orderObject..setAdd('deliveryBoy', object);
      orderDetails[orderItemIndex]['adName'] = name;
      orderDetails[orderItemIndex]['adId'] = id;
      print("###### ${orderDetails[orderItemIndex]['adName']}");
      print("###### ${orderDetails[orderItemIndex]['adId']}");
      var orders = ParseObject('Orders')
        ..set('objectId', oId)
        ..set('order_details', orderDetails)
        ..update();

      ParseResponse adResult = await orders.save();
      if (adResult.success) {
        print("ad assigned");
        adR.adsCount.value = 0;
        adR.adsCount.value++;
        adR.advReport(name,
            orderDetails[orderItemIndex]['quantity'] * adR.adsCount.value);
        //adboyAssigned.value = true;
        print(isBoyAssigned);
        loadData();
        Get.back();
        final snackBar = SnackBar(
          width: MediaQuery.of(Get.context).size.width / 2,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Ad for this order selected Successfully",
            style: kInterText,
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
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

  Future<void> assignBoy(
      String name, String mobile, ParseObject orderObject) async {
    isLoading.value = true;
    try {
      //orderObject..setAdd('deliveryBoy', object);
      orderObject..set('deliveryBoyName', name)..set('deliveryBoyNum', mobile);
      ParseResponse adResult = await orderObject.save();
      if (adResult.success) {
        print("assigned Delivery boy success");
        loadData();
        boyAssigned.value = true;
        print(isBoyAssigned);
        isLoading.value = false;
        Get.back();
        final snackBar = SnackBar(
          width: MediaQuery.of(Get.context).size.width / 2,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Delivery Boy for this order Assigned Successfully",
            style: kInterText,
          ),
          elevation: 20.0,
          backgroundColor: Colors.cyan,
        );
        ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
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

  Future<void> deleteOngoingOrder(int orderItemIndex,
      Map<String, dynamic> orderObject, List orderDetails, String oId) async {
    isLoading.value = true;
    try {
      var objId = oId;
      // var removedProduct = orderDetails.remove(orderObject);
      RxList updatedOrderDetails = orderDetails.obs;
      var removedProduct = updatedOrderDetails().remove(orderObject);
      print("!@!@!@!@!@${removedProduct}");
      print("#####${updatedOrderDetails}");
      var orders = ParseObject('Orders')
        ..set('objectId', oId)
        // ignore: invalid_use_of_protected_member
        ..set(
            'order_details', removedProduct ? updatedOrderDetails.value : null)
        ..update();
      ParseResponse adResult = await orders.save();
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
}
