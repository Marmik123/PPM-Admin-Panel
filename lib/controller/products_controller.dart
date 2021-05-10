import 'dart:convert';
import 'dart:html' hide FormData;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as p;

//import 'package:universal_io/io.dart';

import '../app_config.dart';

class ProductsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList productsList = [].obs;
  RxInt pageNo = 0.obs;
  int textFieldCount = 3;
  RxString proNameValue = "".obs;
  String filename;
  RxList fileList = [].obs;
  RxList nameList = [].obs;
  ParseWebFile imageFile;
  var imageData;
  RxString proDescriptionValue = "".obs;
  RxString proPrice = "".obs;
  RxString unit = "".obs;
  Uint8List finalImage;
  RxList finalImageList = [].obs;
  RxString path = "".obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController unitC = TextEditingController();

  Future<void> registerPro() async {
    print("register product called");
    isLoading.value = true;
    try {
      print("trying to register");
      print(nameList());
      /*List<ParseWebFile> fileListData = List.generate(
          fileList.length, (index) => fileList[index]
          ParseWebFile(
                fileList()[index],
                name: basename(fileList()[index].path),
              )
          );
      print("Here is filelistData");
      print(fileListData);*/
      ParseObject proData = ParseObject('Products')
        ..set('productName', proNameValue())
        ..set('productDesc', proDescriptionValue())
        ..set('productPrice', proPrice())
        ..set('unit', unit())
        ..set("imageFileName",
            List.generate(nameList.length, (index) => nameList[index]));
      //proData.saveInStorage('productPhoto');

      //proData.setAddAll("fileImage", fileListData);

      ParseResponse adResult = await proData.create();
      if (adResult.success) {
        isLoading.value = false;
        loadPro();
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

  Future<void> loadPro() async {
    isLoading.value = true;
    print("called load product data");
    try {
      QueryBuilder<ParseObject> proData =
          QueryBuilder<ParseObject>(ParseObject('Products'))
            ..setLimit(10)
            ..setAmountToSkip(pageNo * 10)
            ..orderByDescending('createdAt');
      print("execute try");
      ParseResponse result = await proData.query();
      print(result);
      print("result starts");
      print(result.results);
      print("result end");
      if (result.success) {
        print("if block ");
        isLoading.value = false;

        // ignore: deprecated_member_use
        productsList(result.results);
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

  Future<void> editPro(ParseObject object) async {
    isLoading.value = true;
    try {
      object
        ..set('productName', proNameValue)
        ..set('productDesc', proDescriptionValue)
        ..set('productPrice', proPrice)
        ..set('unit', unit)
        ..set('imageFileName',
            List.generate(nameList.length, (index) => nameList[index]));
      ParseResponse adResult = await object.save();
      if (adResult.success) {
        isLoading.value = false;
        loadPro();
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

  Future<void> deletePro(ParseObject object) async {
    isLoading.value = true;
    try {
      ParseResponse adResult = await object.delete();
      if (adResult.success) {
        isLoading.value = false;
        loadPro();
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
    final picker = ImagePicker();
    PickedFile filePicked = await picker.getImage(source: ImageSource.gallery);

    print("picked file $filePicked");
    if (filePicked != null) {
      final bytes = await filePicked.readAsBytes();
      finalImage = bytes;
      finalImageList.add(finalImage);
      print("###${bytes.length}");
      path.value = filePicked.path;
      print("###${path}");
      filename = p.basename(filePicked.path);
      fileList().add(filename);
      print(fileList());
      /*imageFile = ParseWebFile(
        bytes,
        name: p.basename(path.value.toString()),
        autoSendSessionId: true,
      );*/
      /* if (imageData != null) {
        uploadPicture();
      }*/
    }
  }

  Future<bool> uploadImg(String filename, finalImage) async {
    isLoading.value = true;
    try {
      String url = "https://cup.marketing.dharmatech.in/product/upload/image";
      var uri = Uri.parse(url);
      var request = new http.MultipartRequest("POST", uri);

      var multipartFile = new http.MultipartFile.fromBytes('image', finalImage,
          filename: '${filename}.jpg',
          contentType: MediaType('application', 'octet-stream'));
      request.files.add(multipartFile);

      /* var response = await request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Uploaded!");
      }
    });*/
      http.Response result =
          await http.Response.fromStream(await request.send());
      print("Result: ${result.statusCode}");
      print(result.body.trArgs());
      print(result.body);
      var json = jsonDecode(result.body);
      print(json);
      print(json['file']);
      nameList().add(json['file']);
      if (result.statusCode != 200) {
        print("FILE UPLOAD FAILED");
        Get.snackbar('Some error occured', 'File Upload Failed',
            backgroundColor: Colors.cyan,
            margin: const EdgeInsets.all(10),
            snackPosition: SnackPosition.BOTTOM,
            maxWidth: MediaQuery.of(Get.context).size.width / 2,
            isDismissible: true,
            dismissDirection: SnackDismissDirection.VERTICAL,
            colorText: Colors.white,
            icon: Icon(Icons.cancel),
            backgroundGradient:
                LinearGradient(colors: [Colors.teal, Colors.cyan]));
      } else {
        print("FILE UPLOAD SUCCESS");
        isLoading.value = false;
        Get.snackbar('Photo Added Successfully', 'Action Success',
            backgroundColor: Colors.cyan,
            margin: const EdgeInsets.all(10),
            snackPosition: SnackPosition.BOTTOM,
            maxWidth: MediaQuery.of(Get.context).size.width / 2,
            isDismissible: true,
            dismissDirection: SnackDismissDirection.VERTICAL,
            colorText: Colors.white,
            icon: Icon(Icons.check_circle),
            backgroundGradient:
                LinearGradient(colors: [Colors.teal, Colors.cyan]));
      }
    } catch (e) {
      isLoading.value = false;
      print('Error while uploding Image $e');
      Get.snackbar('Some Error Catched', 'Please Try again',
          backgroundColor: Colors.cyan,
          margin: const EdgeInsets.all(10),
          snackPosition: SnackPosition.BOTTOM,
          maxWidth: MediaQuery.of(Get.context).size.width / 2,
          isDismissible: true,
          dismissDirection: SnackDismissDirection.VERTICAL,
          colorText: Colors.white,
          icon: Icon(Icons.cancel),
          backgroundGradient:
              LinearGradient(colors: [Colors.teal, Colors.cyan]));
    }
  }
}

/* PlatformFile objFile = null;

  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform.pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      */
/*
      objFile = result.files.single;
    }
  }

  void uploadSelectedFile() async {
    //---Create http package multipart request object
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://cup.marketing.dharmatech.in/product/upload/image"),
    );
    //-----add other fields if needed
    request.fields["id"] = "abc";

    //-----add selected file with request
    request.files.add(new http.MultipartFile(
        "image", objFile.readStream, objFile.size,
        filename: objFile.name));

    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();

    //-------Your response
    print(result);
  }*/

/*
  Future<void> uploadImage() async {
    var pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    print('Bytes length :: ${pickedFile.files.first.bytes.length}');
    print('file path :: ${pickedFile.files.first.path}');
    print('file name :: ${pickedFile.files.first.name}');

    filename = pickedFile.files.first.name;

    if (pickedFile != null) {
      imageFile = ParseWebFile(
        pickedFile.files.first.bytes,
        name: pickedFile.files.first.name,
        autoSendSessionId: true,
      );
    }
  }
*/

/*
  Future<void> uploadPicture() async {
    isLoading.value = true;
    try {
      if (imageData != null) {
        PickedFile imageFile = PickedFile(path.value);
        int length = finalImage.length;
        var stream =
            new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        print('@@!!@@');
        print(p.basename(path.value));
        var multipartFile = await http.MultipartFile('files', stream, length,
            filename: 'file.jpg', contentType: MediaType('image', '*'));

        var uploadProfile = <String, dynamic>{
          "image": imageData,
        };

        var response =
            await API.uploadProfilePictureApi(FormData.fromMap(uploadProfile));
        print(response);
        if (response?.statusCode == 200) {
          print(response?.data);
          print("Image added success");
          isLoading.value = false;
        } else {
          print(response.statusCode);
          print(response.data);
          print("Image added failed");
        }
      }
    } catch (e) {
      print(e);
      print("Error occured ,try again");
    }
  }
*/
