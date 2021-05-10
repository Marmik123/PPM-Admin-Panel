import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:pcm_admin/widgets/form_screen.dart';

displayDialog(BuildContext context, ctrl) {
  final theme = Theme.of(context);
  return Get.defaultDialog(
    confirm: ctrl.isLoading.value
        ? Container(
            height: 30,
            width: 30,
            child: buildLoader(),
          )
        : button(
            onTap: () {
              if (ctrl.formKey.currentState.validate()) {
                ctrl.registerUser();
                Get.back();
                ctrl.ctrl.fileList.removeRange(0, ctrl.fileList?.length);
              } else
                return null;
            },
            buttonTxt: "Save",
            buttonColor: theme.buttonColor,
            txtColor: theme.primaryColorDark,
            txtSize: 15,
          ),
    title: "Enter Details",
    actions: [
      button(
        onTap: () {},
        buttonTxt: "Add Photo",
        buttonColor: theme.buttonColor,
        txtColor: theme.primaryColorDark,
        txtSize: 15,
      ),
    ],
    content: FormDialog(
      count: ctrl.textFieldCount,
      labelText: [
        "Enter Name",
        "Enter Address",
        "Enter Mobile Number",
        "Enter Shop Name",
        "Enter Shop Location",
        "Enter Role",
      ].obs,
    ),
  );
}
