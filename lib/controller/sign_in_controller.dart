import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/view/home_screen.dart';

class SignInController extends GetxController {
  // ManageAdvertiseController adCtrl = Get.put(ManageAdvertiseController());

  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> fPFormKey = GlobalKey<FormState>();
  RxBool hidePassword = true.obs;
  RxBool isLoading = false.obs;
  ParseResponse loginData;
  RxBool forgotPassword = false.obs;
  RxBool hideConfirmPassword = true.obs;
  int textFieldCount = 2;
  Future<ParseUser> login(String username, String password) async {
    try {
      var user = ParseUser(username, password, null);
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        isLoading.value = true;
        var loginData = await user.login();
        if (loginData.success) {
          isLoading.value = false;
          print("object id here");
          print(user.objectId);
          var userParse = user;
          Get.to(HomeScreen());
        } else {
          isLoading.value = false;
          final snackBar = SnackBar(
            width: MediaQuery.of(Get.context).size.width / 2,
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Error ! Please try again with correct credentials",
              style: kInterText,
            ),
            elevation: 20.0,
            backgroundColor: Colors.cyan,
          );
          ScaffoldMessenger.of(Get.context).showSnackBar(snackBar);
          return null;
        }
      }
    } catch (e) {
      print("Error occured ${e}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword(String username, String password) async {
    isLoading.value = true;
    try {
      ParseUser user = await ParseUser.currentUser();
      /* if (oldPassword == password) {
        Get.snackbar('Reset Failed', 'Please set a new password',
            backgroundColor: Colors.cyan,
            margin: const EdgeInsets.all(10),
            snackPosition: SnackPosition.BOTTOM,
            maxWidth: MediaQuery.of(Get.context).size.width / 2,
            isDismissible: true,
            dismissDirection: SnackDismissDirection.VERTICAL,
            colorText: Colors.white,
            icon: Icon(Icons.cancel_rounded),
            backgroundGradient:
                LinearGradient(colors: [Colors.teal, Colors.cyan]));
      } else
*/
      user.set('password', password);

      var response = await user.save();

      if (response.success) {
        isLoading.value = false;
        print("password changed successfully");
        Get.back();
        Get.snackbar('Reset Success', 'Password changed Successfully',
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

      /*QueryBuilder<ParseObject> userData =
          QueryBuilder<ParseObject>(ParseObject('User'))
            //ParseObject userData = ParseObject('UserMetadata')
            ..whereEqualTo('username', username);*/

      /*ParseResponse response = await userData.query();
      if (response.success) {
        if (response.results == null) {
          print("result is null");
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
        } else {
          ParseObject changePassword = response.results[0]
            ..set('username', username)
            ..set('password', password);
          ParseResponse result = await changePassword.save();
          if (result.success) {
            isLoading.value = false;
            print("password changed successfully");
            Get.snackbar('Password changed Successfully', '',
                backgroundGradient:
                    LinearGradient(colors: [Colors.teal, Colors.cyan]));
            Get.back();
          }
        }
      }*/
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
