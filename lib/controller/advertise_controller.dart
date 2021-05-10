import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../app_config.dart';

class ManageAdvertiseController extends GetxController {
  RxString adNameValue = "".obs;
  RxString adDescriptionValue = "".obs;
  RxBool isLoading = false.obs;
  int textFieldCount = 2;
  RxInt pageNo = 0.obs;
  ParseWebFile imageFile;
  RxBool payment = false.obs;
  String filename;
  RxList<dynamic> fileList = [].obs;
  TextEditingController adNameController = TextEditingController();
  TextEditingController adDescriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //RxList<Map<String, dynamic>> source = [].obs;
  RxList<ParseObject> adsData = <ParseObject>[].obs;
  RxList<ParseObject> activeAdData = <ParseObject>[].obs;
  final theme = Theme.of(Get.context);

  QueryBuilder<ParseObject> activeAd =
      QueryBuilder<ParseObject>(ParseObject('Advertisement'))
        ..orderByDescending('createdAt')
        ..whereEqualTo('isActive', 'Yes');

/*  Future<void> generateData() async {
    var i = source.length;
    for (var data in adsData) {
      source.add({
        "id": i,
        "name": data['adName'],
        "desc": data['adDescription'],
        "action": "action",
      });
      i++;
    }
  }*/

  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

/*  void addAdvertise(adName, adDesc) {
    final newAd = ParseObject(adName, adDesc);
    adsData.add(newAd);
  }*/

  Future<void> adActivate(ParseObject object) async {
    isLoading.value = true;
    try {
      object..set('isActive', 'Yes');
      ParseResponse adResult = await object.save();
      if (adResult.success) {
        isLoading.value = false;
        loadAdData();
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

  Future<void> adDeactivate(ParseObject object) async {
    isLoading.value = true;
    try {
      object..set('isActive', 'No');
      ParseResponse adResult = await object.save();
      if (adResult.success) {
        isLoading.value = false;
        loadAdData();
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

  Future<void> paymentR(ParseObject object) async {
    isLoading.value = true;
    try {
      object..set('paymentReceived', 'Yes');
      ParseResponse adResult = await object.save();
      if (adResult.success) {
        isLoading.value = false;
        loadAdData();
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

  Future<void> paymentNotR(ParseObject object) async {
    isLoading.value = true;
    try {
      object..set('paymentReceived', 'No');
      ParseResponse adResult = await object.save();
      if (adResult.success) {
        isLoading.value = false;
        loadAdData();
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

  Future<void> registerAd() async {
    isLoading.value = true;
    try {
      ParseObject adData = ParseObject('Advertisement')
        ..set('adName', adNameValue)
        ..set('adDescription', adDescriptionValue)
        ..set('registeredBy', 'Admin')
        ..set<ParseWebFile>('adPhoto', imageFile);
      ParseResponse adResult = await adData.create();
      if (adResult.success) {
        isLoading.value = false;
        Get.back();
        loadAdData();
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

  Future<void> deleteAd(ParseObject object) async {
    isLoading.value = true;
    try {
      ParseResponse adResult = await object.delete();
      if (adResult.success) {
        isLoading.value = false;
        loadAdData();
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

  Future<void> editAd(ParseObject object) async {
    isLoading.value = true;
    try {
      object
        ..set('adName', adNameValue)
        ..set('adDescription', adDescriptionValue)
        ..set<ParseWebFile>('adPhoto', imageFile);
      ParseResponse adResult = await object.save();
      if (adResult.success) {
        isLoading.value = false;
        loadAdData();
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

  Future<void> loadActiveAdData() async {
    isLoading.value = true;
    print("called load ad data");
    try {
      print("execute try");
      ParseResponse result = await activeAd.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;

        // ignore: deprecated_member_use
        if (!result.isBlank) {
          activeAdData(result.results);
        } else {
          isLoading.value = false;
          final snackBar = SnackBar(
            content: Text(
              "Empty Data",
              style: kInterText,
            ),
            elevation: 20.0,
            backgroundColor: Colors.cyan,
          );
          ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
        }
        print("this is the list $adsData");
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

  Future<void> loadAdData() async {
    isLoading.value = true;
    print("called load ad data");
    try {
      QueryBuilder<ParseObject> adData =
          QueryBuilder<ParseObject>(ParseObject('Advertisement'))
            ..setLimit(10)
            ..setAmountToSkip(pageNo * 10)
            ..orderByDescending('isActive');
      print("execute try");
      ParseResponse result = await adData.query();
      print(result.result);
      if (result.success) {
        print("if block ");
        isLoading.value = false;

        // ignore: deprecated_member_use
        if (!result.isBlank) {
          adsData(result.results);
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
        print("this is the list $adsData");
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

        fileList.add(imageFile);
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
}
