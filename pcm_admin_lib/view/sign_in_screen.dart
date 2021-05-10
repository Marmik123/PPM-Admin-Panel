import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/sign_in_controller.dart';
import 'package:pcm_admin/view/reset_password.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';

class SignIn extends StatelessWidget {
  final loginCtrl = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 0,
                spreadRadius: 2,
                //offset: Offset(3, 2),
              )
            ],
            borderRadius: BorderRadius.circular(30),
            shape: BoxShape.rectangle,
          ),
          height: MediaQuery.of(context).size.height / 1,
          width: MediaQuery.of(context).size.width / 2,
          margin: EdgeInsets.all(100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
            child: Form(
              key: loginCtrl.formKey,
              child: Obx(
                () => loginCtrl.forgotPassword.value
                    ? ResetPassword()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "PCM Admin Panel",
                            style: kInterText.copyWith(
                                fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: loginCtrl.username,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter the username";
                                } else
                                  return null;
                              },
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                hintText: "Enter the Username",
                                hintStyle: kInterText.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: loginCtrl.password,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter a password";
                                } else
                                  return null;
                              },
                              obscureText: loginCtrl.hidePassword.value,
                              keyboardType: TextInputType.visiblePassword,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    loginCtrl.hidePassword.value =
                                        !loginCtrl.hidePassword.value;
                                  },
                                  child: loginCtrl.hidePassword.value
                                      ? Icon(
                                          Icons.visibility_off,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye_sharp,
                                        ),
                                ),
                                hintText: "Enter Your password",
                                hintStyle: kInterText.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          loginCtrl.isLoading.value
                              ? buildLoader()
                              : button(
                                  buttonColor: Theme.of(context).buttonColor,
                                  txtSize: 15,
                                  txtColor: Theme.of(context).primaryColor,
                                  buttonTxt: "Login",
                                  onTap: () {
                                    if (loginCtrl.formKey.currentState
                                        .validate()) {
                                      loginCtrl.login(
                                          loginCtrl.username.text.trim(),
                                          loginCtrl.password.text.trim());
                                    }
                                  },
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              loginCtrl.forgotPassword.value = true;
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: kInterText.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
