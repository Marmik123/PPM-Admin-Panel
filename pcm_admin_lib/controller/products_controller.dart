import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart';

class ProductsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList productsList = [].obs;
  int textFieldCount = 2;
  RxString proNameValue = "".obs;
  String filename;
  RxList<dynamic> fileList = [].obs;
  RxString proDescriptionValue = "".obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  QueryBuilder<ParseObject> proData =
      QueryBuilder<ParseObject>(ParseObject('Products'))
        ..orderByDescending('createdAt');

  Future<void> registerPro() async {
    print("register product called");
    isLoading.value = true;
    try {
      List<ParseWebFile> fileListData = List.generate(
          fileList.length,
          (index) => ParseWebFile(
                fileList()[index],
                name: basename(fileList()[index].path),
              ));
      print("Here is filelistData");
      print(fileListData);
      ParseObject proData = ParseObject('Products')
        ..set('productName', proNameValue)
        ..set('productDesc', proDescriptionValue);
      proData.setAddAll("fileImage", fileListData);
      //proData.set<List<ParseWebFile>>("fileImages", fileListData);
      ParseResponse adResult = await proData.create();
      if (adResult.success) {
        isLoading.value = false;
        loadPro();
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

  Future<void> loadPro() async {
    isLoading.value = true;
    print("called load product data");
    try {
      print("execute try");
      ParseResponse result = await proData.query();
      print(result);
      print("result starts");
      print(result.result);
      print("result end");
      if (result.success) {
        print("if block ");
        isLoading.value = false;

        // ignore: deprecated_member_use
        productsList(result.results);
      }
    } catch (e) {
      isLoading.value = false;
      print("default error---" + e);
    } finally {
      print("Finally executed");
    }
  }

  Future<void> editPro(ParseObject object) async {
    isLoading.value = true;
    try {
      object
        ..set('productName', proNameValue)
        ..set('productDesc', proDescriptionValue)
        ..set('productPhoto',
            List.generate(fileList.length, (index) => fileList[index]));
      ParseResponse adResult = await object.save();
      if (adResult.success) {
        isLoading.value = false;
        loadPro();
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

  Future<void> deletePro(ParseObject object) async {
    isLoading.value = true;
    try {
      ParseResponse adResult = await object.delete();
      if (adResult.success) {
        isLoading.value = false;
        loadPro();
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

  Future<void> chooseFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print(result);
      try {
        print('try executed');
        var file = Image.memory(result.files.single.bytes);
        print(file);
        filename = result.files.single.name;
        print(filename);
        fileList.add(file);
        print(fileList.length);
        print('sdsssdsds $fileList');
      } catch (e) {
        print(e);
        return e;
      }
    } else {
      // User canceled the picker
    }
  }
}
