import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/advertise_controller.dart';
import 'package:pcm_admin/controller/home_screen_controller.dart';
import 'package:pcm_admin/controller/products_controller.dart';
import 'package:pcm_admin/controller/support_details_controller.dart';
import 'package:pcm_admin/controller/users_controller.dart';

class FormDialog extends StatelessWidget {
  ManageAdvertiseController adCtrl = Get.put(ManageAdvertiseController());
  ProductsController proCtrl = Get.put(ProductsController());
  HomeScreenController homeCtrl = Get.put(HomeScreenController());
  SupportDetailsController sCtrl = Get.put(SupportDetailsController());
  UserController userCtrl = Get.put(UserController());

  RxList labelText = [].obs;
  final int count;
  final String proNameValue;
  final String proDescriptionValue;
  final TextEditingController adTxtCtrl;

  FormDialog(
      {this.adTxtCtrl,
      this.proNameValue,
      this.proDescriptionValue,
      this.labelText,
      this.count});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Form(
        key: homeCtrl.selectedIndex.value == 0
            ? adCtrl.formKey
            : homeCtrl.selectedIndex.value == 1
                ? proCtrl.formKey
                : homeCtrl.selectedIndex.value == 5
                    ? sCtrl.formKey
                    : homeCtrl.selectedIndex.value == 3
                        ? userCtrl.formKey
                        : null,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter a value";
                          }
                        },
                        controller: adTxtCtrl,
                        onChanged: (value) {
                          print(value);
                          if (index == 0) {
                            homeCtrl.selectedIndex.value == 0
                                ? adCtrl.adNameValue.value = value
                                : homeCtrl.selectedIndex.value == 1
                                    ? proCtrl.proNameValue.value = value
                                    : homeCtrl.selectedIndex.value == 5
                                        ? sCtrl.sType.value = value
                                        : homeCtrl.selectedIndex.value == 3
                                            ? userCtrl.name.value = value
                                            : null;
                          } else if (index == 1) {
                            homeCtrl.selectedIndex.value == 0
                                ? adCtrl.adDescriptionValue.value = value
                                : homeCtrl.selectedIndex.value == 1
                                    ? proCtrl.proDescriptionValue.value = value
                                    : homeCtrl.selectedIndex.value == 5
                                        ? sCtrl.data.value = value
                                        : homeCtrl.selectedIndex.value == 3
                                            ? userCtrl.address.value = value
                                            : null;
                          } else if (index == 2) {
                            userCtrl.mobileNo.value = value;
                          } else if (index == 3) {
                            userCtrl.shopName.value = value;
                          } else if (index == 4) {
                            userCtrl.shopLocation.value = value;
                          } else if (index == 5) {
                            userCtrl.typeOfRole.value = value;
                          }
                        },
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          labelText: labelText[index],
                          labelStyle: kInterText.copyWith(
                            color: theme.accentColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: "....",
                          hintStyle: kInterText.copyWith(
                            color: theme.accentColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.primaryColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              homeCtrl.selectedIndex.value == 1
                  ? Obx(() => SingleChildScrollView(
                        child: Container(
                          alignment: Alignment.topLeft,
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 4,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: proCtrl.fileList?.length ?? 1,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    proCtrl.filename ?? "imagefile.jpg",
                                    textAlign: TextAlign.center,
                                    style: kInterText.copyWith(
                                        fontSize: 12, color: theme.accentColor),
                                  ),
                                  Container(
                                    child: IconButton(
                                        tooltip: "Remove",
                                        iconSize: 15,
                                        /*padding:
                                            EdgeInsets.only(bottom: 20),
                                        */
                                        alignment: Alignment.center,
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          proCtrl.fileList.removeAt(index);
                                        }),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
/*
  void onSaved(value) {
    adCtrl.adNameValue = value;
  }

  void onDescSaved(value) {
    adCtrl.adDescriptionValue = value;
  }*/
}
