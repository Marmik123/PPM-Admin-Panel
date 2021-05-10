import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pcm_admin/view/home_screen.dart';

class SignInController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool hidePassword = false.obs;
  RxBool isLoading = false.obs;
  RxBool forgotPassword = false.obs;
  RxBool hideConfirmPassword = false.obs;
  int textFieldCount = 2;

  Future<ParseUser> login(String username, String password) async {
    var user = ParseUser(username, password, null);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      isLoading.value = true;
      var result = await user.login();
      if (result.success) {
        print(user.objectId);
        var userParse = user;
        Get.to(HomeScreen());
      }
    } else {
      return null;
    }
  }
}
