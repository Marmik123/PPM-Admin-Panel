import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/users_controller.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:pcm_admin/widgets/default_dialog.dart';
import 'package:pcm_admin/widgets/form_screen.dart';
import 'package:responsive_table/responsive_table.dart';

class DeliveryBoy extends StatelessWidget {
  UserController userCtrl = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<DatatableHeader> header = [
      DatatableHeader(
          text: "Sr No.",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Full Name",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Role",
          value: "role",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Address",
          value: "add",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Document",
          value: "doc",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Mobile Number",
          value: "mobile",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Pin Code",
          value: "pincode",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Shop Name",
          value: "shopN",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
/*      DatatableHeader(
          text: "IsActive",
          value: "active",
          show: true,
          flex: 2,
          sourceBuilder: (value, row) => Obx(() => CupertinoSwitch(
                value: userCtrl.isActive.value,
                onChanged: (value) {
                  userCtrl.isActive.value = value;
                },
                activeColor: theme.accentColor,
              )),
          sortable: true,
          textAlign: TextAlign.center)*/
      DatatableHeader(
          text: "Actions",
          value: "ad",
          show: true,
          flex: 2,
          sortable: true,
          sourceBuilder: (value, row) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      tooltip: "Edit Delivery boy",
                      onPressed: () {
                        Get.defaultDialog(
                          confirm: userCtrl.isLoading.value
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  child: buildLoader(),
                                )
                              : button(
                                  onTap: () {
                                    if (userCtrl.formKey.currentState
                                        .validate()) {
                                      userCtrl.editUser(
                                          userCtrl.distriInfo[row['index']],
                                          "DeliveryBoy");
                                    } else
                                      return null;
                                  },
                                  buttonTxt: "Save",
                                  buttonColor: theme.buttonColor,
                                  txtColor: theme.primaryColorDark,
                                  txtSize: 10,
                                ),
                          actions: [
                            button(
                              onTap: () {
                                userCtrl.chooseFile();
                              },
                              buttonTxt: "Add Photo",
                              buttonColor: theme.buttonColor,
                              txtColor: theme.primaryColorDark,
                              txtSize: 15,
                            )
                          ],
                          title: "Edit Details",
                          content: FormDialog(
                            count: 5,
                            labelText: [
                              "Enter Name",
                              "Enter Address",
                              "Enter Mobile Number",
                              "Enter Shop Name",
                              "Assign Pincode",
                            ].obs,
                          ),
                        );
                      },
                      icon: Icon(Icons.edit_outlined),
                      iconSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    tooltip: "Delete Delivery Boy",
                    onPressed: () {
                      Get.defaultDialog(
                        radius: 25,
                        title: "Are you sure you want to delete this product?",
                        titleStyle: kInterText.copyWith(
                          color: theme.accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        content: Column(
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        theme.primaryColor)),
                                onPressed: () {
                                  userCtrl.deleteUser(
                                      row['object'], userCtrl.returnDUser());
                                  userCtrl.distriInfo.removeAt(row['index']);
                                },
                                child: SelectableText(
                                  'Yes',
                                  style: kInterText.copyWith(
                                    color: theme.hintColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        theme.primaryColor)),
                                onPressed: () {
                                  Get.back();
                                },
                                child: SelectableText(
                                  'No',
                                  style: kInterText.copyWith(
                                    color: theme.hintColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                    iconSize: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
          textAlign: TextAlign.left),
    ];
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          button(
              buttonColor: theme.buttonColor,
              txtSize: 15,
              txtColor: theme.primaryColorDark,
              buttonTxt: "Add New",
              onTap: () {
                displayDialog(
                  context,
                  userCtrl,
                );
              }),
          SizedBox(
            height: 5,
          ),
          Obx(() => userCtrl.isLoading.value
              ? Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    child: buildLoader(),
                  ),
                )
              : (userCtrl.distriInfo()?.isNotEmpty ?? false)
                  ? Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          ResponsiveDatatable(
                            footers: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 25, bottom: 15),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 8,
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            icon: userCtrl.dPageNo.value == 0
                                                ? Icon(
                                                    Icons.arrow_back_ios_sharp,
                                                    color: Colors.grey,
                                                  )
                                                : Icon(
                                                    Icons.arrow_back_ios_sharp),
                                            onPressed: userCtrl.dPageNo.value ==
                                                    0
                                                ? () {}
                                                : () {
                                                    /* if (userCtrl
                                          .startIndex
                                          .value >
                                          0) {
                                        userCtrl
                                            .startIndex
                                            .value = userCtrl
                                            .startIndex
                                            .value -
                                            10;
                                      }*/
                                                    userCtrl.dPageNo.value--;
                                                    userCtrl.loadUser(
                                                        userCtrl.returnDUser());
                                                  },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Text(
                                              "${userCtrl.dPageNo.value + 1}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            icon: userCtrl.distriInfo.length !=
                                                    10
                                                ? Icon(
                                                    Icons
                                                        .arrow_forward_ios_sharp,
                                                    color: Colors.grey,
                                                  )
                                                : Icon(Icons
                                                    .arrow_forward_ios_sharp),
                                            onPressed: userCtrl
                                                        .distriInfo.length !=
                                                    10
                                                ? () {}
                                                : () {
                                                    /* userCtrl.showPaginatedList
                                                                .value = true;*/

                                                    userCtrl.dPageNo.value++;
                                                    userCtrl.loadUser(
                                                        userCtrl.returnDUser());
                                                  },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                            headers: header,
                            autoHeight: true,
                            isLoading: userCtrl.isLoading.value,
                            title: Text("Manage Delivery Boy",
                                style: kInterText.copyWith(
                                  color: theme.accentColor,
                                  fontSize: 25,
                                )),
                            source: List.generate(
                                userCtrl.distriInfo.isNotEmpty
                                    ? userCtrl.distriInfo?.length
                                    : null,
                                (index) => {
                                      'id': index + 1,
                                      'index': index,
                                      'object': userCtrl.distriInfo[index],
                                      'name': userCtrl.distriInfo[index]
                                              ['name'] ??
                                          "-",
                                      'role': userCtrl.distriInfo[index]
                                              ['role'] ??
                                          "-",
                                      'desc': "Description",
                                      'mobile': userCtrl.distriInfo[index]
                                              ['number'] ??
                                          "-",
                                      'add': userCtrl.distriInfo[index]
                                              ['address1'] ??
                                          "-",
                                      'doc': userCtrl.distriInfo[index]
                                              ['docName'] ??
                                          "-",
                                      'shopN': userCtrl.distriInfo[index]
                                              ['shopName'] ??
                                          "-",
                                      'pincode': userCtrl.distriInfo[index]
                                              ['pincode'] ??
                                          "-",
                                    }),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: SelectableText(
                      "No data to display",
                      style: kInterText.copyWith(
                          fontSize: 25, color: theme.accentColor),
                    )))
        ],
      ),
    );
  }
}
