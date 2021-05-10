import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
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
  TextEditingController adTxtCtrl3 = TextEditingController(text: "Hello");

  RxList labelText = [].obs;
  final int count;
  final bool isEdit;
  String name;
  String desc;
  final String proNameValue;
  final String proDescriptionValue;
  final TextEditingController adTxtCtrl;
  RxList<ParseObject> adsData;

  FormDialog(
      {this.adTxtCtrl,
      this.proNameValue,
      this.proDescriptionValue,
      this.labelText,
      this.count,
      this.isEdit,
      this.adsData});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Form(
        key: homeCtrl.selectedIndex.value == 1
            ? adCtrl.formKey
            : homeCtrl.selectedIndex.value == 2
                ? proCtrl.formKey
                : homeCtrl.selectedIndex.value == 6
                    ? sCtrl.formKey
                    : homeCtrl.selectedIndex.value == 4
                        ? userCtrl.formKey
                        : null,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    /* var list = List.generate(
                        adsData.length,
                        (order) => {
                              'name': adsData[order]['adName'],
                              'desc': adsData[order]['adDescription']
                            });*/
                    return Column(
                      children: [
                        TextFormField(
                          initialValue: homeCtrl.selectedIndex.value == 0
                              ? /*List.generate(
                              adsData.length,
                                  (order) {
                                if(index==0){
                                  return name= adsData[order]['adName'];
                              }
                                else return desc=adsData[order]['adDescription'];
                                  });*/
                              index == 0
                                  ? name
                                  : desc
                              : null,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter a value";
                            }
                            if (index == 2 &&
                                homeCtrl.selectedIndex.value != 2) {
                              if (!value.isPhoneNumber) {
                                return "Please enter valid mobile number";
                              }
                              if (value.length != 10) {
                                return "Please enter 10 digit mobile number";
                              }
                            }
                            if (index == 3 &&
                                homeCtrl.selectedIndex.value == 2) {
                              if (value.isEmpty)
                                return "Please enter the unit";
                              else if (!(value
                                      .isCaseInsensitiveContains("kg") ||
                                  value.isCaseInsensitiveContains("pc"))) {
                                proCtrl.unitC.clear();
                                return "Please enter valid \nunit from Kg or Pc";
                              }
                            }
                          },
                          controller:
                              index == 3 && homeCtrl.selectedIndex.value == 2
                                  ? proCtrl.unitC
                                  : null,
                          /* controller: index == 0
                            ? initialValue('${adCtrl.adsData[index]['adName']}')
                            : initialValue(
                                '${adCtrl.adsData[index]['adDescription']}'),*/
                          onChanged: (value) {
                            print(value);
                            if (index == 0) {
                              homeCtrl.selectedIndex.value == 1
                                  ? adCtrl.adNameValue.value = value
                                  : homeCtrl.selectedIndex.value == 2
                                      ? proCtrl.proNameValue.value = value
                                      : homeCtrl.selectedIndex.value == 6
                                          ? sCtrl.sType.value = value
                                          : homeCtrl.selectedIndex.value == 4
                                              ? userCtrl.name.value = value
                                              : null;
                            } else if (index == 1) {
                              homeCtrl.selectedIndex.value == 1
                                  ? adCtrl.adDescriptionValue.value = value
                                  : homeCtrl.selectedIndex.value == 2
                                      ? proCtrl.proDescriptionValue.value =
                                          value
                                      : homeCtrl.selectedIndex.value == 6
                                          ? sCtrl.data.value = value
                                          : homeCtrl.selectedIndex.value == 4
                                              ? userCtrl.address.value = value
                                              : null;
                            } else if (index == 2) {
                              homeCtrl.selectedIndex.value == 2
                                  ? proCtrl.proPrice.value = value
                                  : userCtrl.mobileNo.value = value;
                            } else if (index == 3) {
                              homeCtrl.selectedIndex.value == 2
                                  ? proCtrl.unit.value = value
                                  : userCtrl.shopName.value = value;
                            } else if (index == 4) {
                              homeCtrl.selectedIndex.value == 4
                                  ? userCtrl.pincode.value = value
                                  : userCtrl.shopLocation.value = value;
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
                    );
                  },
                ),
              ),
              homeCtrl.selectedIndex.value == 2 ||
                      homeCtrl.selectedIndex.value == 1 ||
                      homeCtrl.selectedIndex.value == 4 ||
                      homeCtrl.selectedIndex.value == 3
                  ? Obx(() => SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "List of Images",
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 4,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: homeCtrl.selectedIndex.value == 1
                                    ? adCtrl.fileList()?.length
                                    : homeCtrl.selectedIndex.value == 2
                                        ? proCtrl.fileList()?.length
                                        : userCtrl.fileList()?.length ?? 1,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        homeCtrl.selectedIndex.value == 1
                                            ? adCtrl.filename
                                            : homeCtrl.selectedIndex.value == 2
                                                ? proCtrl.fileList[index]
                                                : userCtrl.filename ??
                                                    "imagefile.jpg",
                                        textAlign: TextAlign.center,
                                        style: kInterText.copyWith(
                                            fontSize: 12,
                                            color: theme.accentColor),
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
                                              userCtrl.selectedIndex.value == 1
                                                  ? adCtrl.fileList
                                                      .removeAt(index)
                                                  : userCtrl.selectedIndex
                                                              .value ==
                                                          2
                                                      ? proCtrl.fileList
                                                          .removeAt(index)
                                                      : userCtrl.fileList
                                                          .removeAt(index);
                                            }),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  initialValue(val) {
    return TextEditingController(text: val);
  }
}
