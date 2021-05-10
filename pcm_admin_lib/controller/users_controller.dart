import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserController extends GetxController {
  int textFieldCount = 6;
  RxBool isActive = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxString typeOfRole = "".obs;
  RxList<ParseObject> distriInfo = <ParseObject>[].obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString name = "".obs;
  RxString address = "".obs;
  RxString mobileNo = "".obs;
  RxString shopName = "".obs;
  RxString shopLocation = "".obs;
  QueryBuilder<ParseObject> distInfo =
      QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
        ..whereEqualTo('role', 'Distributor')
        ..includeObject(['shopName']);

  QueryBuilder<ParseObject> clientInfo =
      QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
        ..whereEqualTo('role', 'Client')
        ..includeObject(['shopName']);

  QueryBuilder<ParseObject> delInfo =
      QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
        ..whereEqualTo('role', 'DeliveryBoy');

  QueryBuilder<ParseObject> salesInfo =
      QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
        ..whereEqualTo('role', 'SalesPerson')
        ..includeObject(['shopName']);

  Future<void> loadUser(QueryBuilder<ParseObject> role) async {
    if (role == distInfo) {
      typeOfRole.value = "Distributor";
    } else if (role == clientInfo) {
      typeOfRole.value = "Client";
    } else if (role == delInfo) {
      typeOfRole.value = "DeliveryBoy";
    } else {
      typeOfRole.value = "SalesPerson";
    }
    isLoading.value = true;
    print("called load fb data");
    try {
      print("execute try");
      ParseResponse result = await role.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        print(result.results);
        // ignore: deprecated_member_use
        distriInfo(result.results);
        print("distrinfo called ${distriInfo[0].get('shop').get('shopName')}");
      }
    } catch (e) {
      isLoading.value = false;
      print("default error---" + e);
    } finally {
      print("Finally executed");
    }
  }

  Future<void> registerUser() async {
    isLoading.value = true;
    try {
      ParseObject adData = ParseObject('UserMetadata')
        ..set('name', name)
        ..set('number', mobileNo)
        ..set('address1', address)
        ..set('shopName', shopName)
        ..set('role', "Client")
        ..set('shopLocation', shopLocation);
      ParseResponse adResult = await adData.create();
      if (adResult.success) {
        isLoading.value = false;
        Get.back();
        loadUser(clientInfo);
      } else
        return null;
    } catch (e) {
      isLoading.value = false;
      print("default error---" + e);
    } finally {
      print("Finally executed");
    }
  }
}
