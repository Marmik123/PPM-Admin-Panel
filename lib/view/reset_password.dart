import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/sign_in_controller.dart';

class ResetPassword extends StatelessWidget {
  SignInController loginCtrl = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Reset Password",
              style: kInterText.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: TextFormField(
                controller: loginCtrl.newPassword,
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
                            color: Theme.of(context).accentColor,
                          )
                        : Icon(
                            Icons.remove_red_eye_sharp,
                            color: Theme.of(context).accentColor,
                          ),
                  ),
                  hintText: "Enter Your New password",
                  hintStyle: kInterText.copyWith(
                    color: Theme.of(context).primaryColor,
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
                controller: loginCtrl.confirmPassword,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter your password";
                  }
                  if (loginCtrl.newPassword.text !=
                      loginCtrl.confirmPassword.text) {
                    return "Password do not match";
                  } else
                    return null;
                },
                obscureText: loginCtrl.hideConfirmPassword.value,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      loginCtrl.hideConfirmPassword.value =
                          !loginCtrl.hideConfirmPassword.value;
                    },
                    child: loginCtrl.hideConfirmPassword.value
                        ? Icon(
                            Icons.visibility_off,
                            color: Theme.of(context).accentColor,
                          )
                        : Icon(
                            Icons.remove_red_eye_sharp,
                            color: Theme.of(context).accentColor,
                          ),
                  ),
                  hintText: "Confirm Your password",
                  hintStyle: kInterText.copyWith(
                    color: Theme.of(context).primaryColor,
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
            button(
              buttonColor: Theme.of(context).buttonColor,
              txtSize: 15,
              txtColor: Theme.of(context).primaryColor,
              buttonTxt: "Continue",
              onTap: () {
                if (loginCtrl.formKey.currentState.validate()) {
                  loginCtrl.forgotPassword.value = false;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
