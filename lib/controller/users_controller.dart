import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm_admin/app_config.dart';

class UserController extends GetxController {
  int textFieldCount = 4;
  RxBool isActive = false.obs;
  RxInt selectedIndex = 0.obs;
  RxInt userIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxInt cPageNo = 0.obs;
  RxInt sPageNo = 0.obs;
  RxInt mPageNo = 0.obs;
  RxInt dPageNo = 0.obs;
  RxBool editUserFlag = false.obs;
  ParseWebFile imageFile;
  String filename;
  RxList<dynamic> fileList = [].obs;
  RxString typeOfRole = "".obs;
  RxList<ParseObject> distriInfo = <ParseObject>[].obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString name = "".obs;
  RxString address = "".obs;
  RxString mobileNo = "".obs;
  RxString shopName = "".obs;
  RxString shopLocation = "".obs;
  RxString pincode = "".obs;

  /* void onInit() {
    loadUser(clientInfo);
  }*/

  QueryBuilder returnMUser() {
    QueryBuilder<ParseObject> markInfo =
        QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
          /*..setLimit(10)
      ..setAmountToSkip(mPageNo * 10)*/
          ..whereEqualTo('role', 'Marketing')
          ..includeObject(['shopName']);
    return markInfo;
  }

  QueryBuilder returnCUser() {
    QueryBuilder<ParseObject> clientInfo =
        QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
          ..setLimit(10)
          ..setAmountToSkip(cPageNo * 10)
          ..whereEqualTo('role', 'Client')
          ..includeObject(['shopName']);
    return clientInfo;
  }

  QueryBuilder returnDUser() {
    QueryBuilder<ParseObject> delInfo =
        QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
          ..setLimit(10)
          ..setAmountToSkip(dPageNo * 10)
          ..whereEqualTo('role', 'DeliveryBoy');
    return delInfo;
  }

  QueryBuilder returnSUser() {
    QueryBuilder<ParseObject> salesInfo =
        QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
          ..setLimit(10)
          ..setAmountToSkip(sPageNo * 10)
          ..whereEqualTo('role', 'SalesPerson')
          ..includeObject(['shopName']);
    return salesInfo;
  }

  Future<void> loadUser(QueryBuilder<ParseObject> role) async {
    /*if (role == distInfo) {
      typeOfRole.value = "Distributor";
    } else if (role == clientInfo) {
      typeOfRole.value = "Client";
    } else if (role == delInfo) {
      typeOfRole.value = "DeliveryBoy";
    } else {
      typeOfRole.value = "SalesPerson";
    }*/
    isLoading.value = true;
    print("called load fb data");
    try {
      QueryBuilder<ParseObject> markInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(mPageNo * 10)
            ..whereEqualTo('role', 'Marketing')
            ..includeObject(['shopName']);

      QueryBuilder<ParseObject> clientInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(cPageNo * 10)
            ..whereEqualTo('role', 'Client')
            ..includeObject(['shopName']);

      QueryBuilder<ParseObject> delInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(dPageNo * 10)
            ..whereEqualTo('role', 'DeliveryBoy');

      QueryBuilder<ParseObject> salesInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(sPageNo * 10)
            ..whereEqualTo('role', 'SalesPerson')
            ..includeObject(['shopName']);
      print("execute try");
      ParseResponse result = await role.query();
      print(result.result);
      if (result.success) {
        distriInfo.removeRange(0, distriInfo.length);
        print("if block ");

        print(result.results);
        // ignore: deprecated_member_use
        distriInfo(result.results);
        isLoading.value = false;
        //print("distrinfo called ${distriInfo[0].get('shop').get('shopName')}");
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

  Future<void> registerUser(String role) async {
    isLoading.value = true;
    try {
      QueryBuilder<ParseObject> markInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(mPageNo * 10)
            ..whereEqualTo('role', 'Marketing')
            ..includeObject(['shopName']);

      QueryBuilder<ParseObject> clientInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(cPageNo * 10)
            ..whereEqualTo('role', 'Client')
            ..includeObject(['shopName']);

      QueryBuilder<ParseObject> delInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(dPageNo * 10)
            ..whereEqualTo('role', 'DeliveryBoy');

      QueryBuilder<ParseObject> salesInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(sPageNo * 10)
            ..whereEqualTo('role', 'SalesPerson')
            ..includeObject(['shopName']);
      ParseObject adData = ParseObject('UserMetadata')
        ..set('name', name)
        ..set('number', mobileNo)
        ..set('address1', address)
        ..set('shopName', shopName)
        ..set('pincode', pincode)
        ..set('docName', filename)
        ..set<ParseWebFile>('document', imageFile)
        ..set('role', role);
      ParseResponse adResult = await adData.create();
      if (adResult.success) {
        isLoading.value = false;
        Get.back();
        if (role == "Client") {
          loadUser(clientInfo);
        } else if (role == "Marketing") {
          loadUser(markInfo);
        } else if (role == "SalesPerson") {
          loadUser(salesInfo);
        } else {
          loadUser(delInfo);
        }
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

  Future<void> editUser(ParseObject object, String role) async {
    isLoading.value = true;
    try {
      QueryBuilder<ParseObject> markInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(mPageNo * 10)
            ..whereEqualTo('role', 'Marketing')
            ..includeObject(['shopName']);

      QueryBuilder<ParseObject> clientInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(cPageNo * 10)
            ..whereEqualTo('role', 'Client')
            ..includeObject(['shopName']);

      QueryBuilder<ParseObject> delInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(dPageNo * 10)
            ..whereEqualTo('role', 'DeliveryBoy');

      QueryBuilder<ParseObject> salesInfo =
          QueryBuilder<ParseObject>(ParseObject('UserMetadata'))
            ..setLimit(10)
            ..setAmountToSkip(sPageNo * 10)
            ..whereEqualTo('role', 'SalesPerson')
            ..includeObject(['shopName']);
      object
        ..set('name', name)
        ..set('number', mobileNo)
        ..set('address1', address)
        ..set('shopName', shopName)
        ..set('pincode', pincode)
        ..set('docName', filename)
        ..set<ParseWebFile>('document', imageFile)
        ..set('role', role);
      ParseResponse adResult = await object.save();
      if (adResult.success) {
        isLoading.value = false;
        if (role == "Client") {
          loadUser(clientInfo);
        } else if (role == "Marketing") {
          loadUser(markInfo);
        } else if (role == "SalesPerson") {
          loadUser(salesInfo);
        } else {
          loadUser(delInfo);
        }
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

  Future<void> chooseFile() async {
    //final picker = ImagePicker();
    //PickedFile filePicked = await picker.getImage(source: ImageSource.gallery);
    final pickedFile = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
      allowCompression: true,
      /*allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
      ],*/
    );
    try {
      //var image = Image.network(pickedFile.path);
      print("picked file $pickedFile");
      if (pickedFile != null) {
        PlatformFile file = pickedFile.files.first;
        print(file.name);
        print(file.bytes);
        print(file.size);
        //print(path);
        print(file.extension);
        print(file.path);
        print('try executed');
        //var file = Image.memory(result.files.single.bytes);
        ParseWebFile pic =
            ParseWebFile(file.bytes, name: file.name, url: file.path);
        print("this is url");
        print(pic.url);

        imageFile = pic;
        filename = file.name;
        //print(filename);

        fileList.add(pic);
        /*print(fileList.length);
        print('sdsssdsds $fileList');
        proData.selectKeys("fileImage", parseFile);*/
      }
    } catch (e) {
      print(e);
      final snackBar = SnackBar(
        content: Text(
          "Error ! Please try again.",
          style: kInterText,
        ),
        elevation: 20.0,
        backgroundColor: Colors.cyan,
      );
      ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
      return e;
    }
  }

  Future<void> deleteUser(ParseObject object, role) async {
    isLoading.value = true;
    try {
      ParseResponse adResult = await object.delete();
      if (adResult.success) {
        isLoading.value = false;
        loadUser(role);
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
