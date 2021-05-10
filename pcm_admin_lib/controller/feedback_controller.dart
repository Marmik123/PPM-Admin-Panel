import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class FeedBackController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ParseObject> fbList = <ParseObject>[].obs;
  RxList userList = [].obs;

  QueryBuilder<ParseObject> fbData =
      QueryBuilder<ParseObject>(ParseObject('Feedback'))
        ..orderByDescending('createdAt')
        ..includeObject(['userData']);

  /*Future<void> getUserData(index) async {
    QueryBuilder<ParseObject> userData =
        QueryBuilder<ParseObject>(ParseObject('_User'))
          ..whereEqualTo('objectId', fbList[index]['userData']['objectId']);

    try {
      ParseResponse response = await userData.query();
      if (response.success) {
        print("User data Details");
        print(response.result);
        // ignore: deprecated_member_use
        userList.value = response.results;
      }
    } catch (e) {
      return e;
    }
  }*/

  Future<void> loadFeedBack() async {
    isLoading.value = true;
    print("called load fb data");
    try {
      print("execute try");
      ParseResponse result = await fbData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;

        // ignore: deprecated_member_use
        fbList.value = result.results;
      }
    } catch (e) {
      isLoading.value = false;
      print("default error---" + e);
    } finally {
      print("Finally executed");
    }
  }

  Future<void> deleteFeedBack(ParseObject object) async {
    isLoading.value = true;
    try {
      ParseResponse adResult = await object.delete();
      if (adResult.success) {
        isLoading.value = false;
        loadFeedBack();
        Get.back();
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
