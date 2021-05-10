import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/users_controller.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:pcm_admin/widgets/form_screen.dart';

displayDialog(BuildContext context, ctrl) {
  UserController userCtrl = Get.put(UserController());
  final theme = Theme.of(context);
  return Get.defaultDialog(
    confirm: ctrl.isLoading.value
        ? Container(
            height: 30,
            width: 30,
            child: buildLoader(),
          )
        : button(
            onTap:
                /*userCtrl.editUserFlag.value
                ? () {
                    if (ctrl.formKey.currentState.validate()) {
                      ctrl.selectedIndex.value == 0
                          ? ctrl.editUser("Client")
                          : ctrl.selectedIndex.value == 1
                              ? ctrl.editUser("Distributor")
                              : ctrl.selectedIndex.value == 2
                                  ? ctrl.editUser("SalesPerson")
                                  : ctrl.editUser("DeliveryBoy");
                      Get.back();
                      ctrl.fileList.removeRange(0, ctrl.fileList?.length);
                    } else
                      return null;
                  }
                :*/
                () {
              if (ctrl.formKey.currentState.validate()) {
                ctrl.selectedIndex.value == 0
                    ? ctrl.registerUser("Client")
                    : ctrl.selectedIndex.value == 1
                        ? ctrl.registerUser("Marketing")
                        : ctrl.selectedIndex.value == 2
                            ? ctrl.registerUser("SalesPerson")
                            : ctrl.registerUser("DeliveryBoy");

                ctrl.fileList.removeRange(0, ctrl.fileList?.length);
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
        onTap: () {
          userCtrl.chooseFile();
        },
        buttonTxt: "Add Photo",
        buttonColor: theme.buttonColor,
        txtColor: theme.primaryColorDark,
        txtSize: 15,
      ),
    ],
    content: FormDialog(
      count: 5,
      labelText: [
        "Enter Name",
        "Enter Address",
        "Enter Mobile Number",
        "Enter Shop Name",
        "Assign pincode"
      ].obs,
    ),
  );
}
