import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm_admin/app_config.dart';

class AdReportC extends GetxController {
  RxBool isLoading = false.obs;
  RxList adReport = [].obs;
  RxInt adsCount = 0.obs;
  Future<void> loadAdReport() async {
    isLoading.value = true;
    print("called load ad ");
    try {
      QueryBuilder<ParseObject> client =
          QueryBuilder<ParseObject>(ParseObject('AdvertisementMetadata'))
            ..orderByDescending('adsAssigned');

      print("execute try");
      ParseResponse result = await client.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;
        adReport(result.results);
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

  Future<void> advReport(String name, int adsCount) async {
    print("called ad report");
    try {
      QueryBuilder<ParseObject> userData =
          QueryBuilder<ParseObject>(ParseObject('AdvertisementMetadata'))
            //ParseObject userData = ParseObject('UserMetadata')
            ..whereEqualTo('adName', name);

      ParseResponse response = await userData.query();
      if (response.success) {
        if (response.results == null) {
          print("no ad exist creating new one");
          ParseObject newClient = ParseObject('AdvertisementMetadata')
            ..set<String>('adName', name)
            ..set('adsAssigned', adsCount);

          ParseResponse reportResult = await newClient.create();
          if (reportResult.success) {
            print('new ad created');
            adsCount = 0;
            //rCtrl.setOrdersMetadataObjectId(reportResult.result['objectId']);
            //print(reportResult.result['objectId']);
            //rCtrl.loadObjId();
            //SharedPreferences preference =
            //  await SharedPreferences.getInstance();
            // print("@@@${preference.getString(rCtrl.kOrderObjectId)}");
          }
        } else {
          print("user already there updating purchaseCount");
          ParseObject client = response.result[0]
            ..set('adName', name)
            ..set('adsAssigned', response.result[0]['adsAssigned'] + adsCount);

          ParseResponse reportResult = await client.save();
          if (reportResult.success) {
            adsCount = 0;
            print("ads Count counted and report made");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

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
