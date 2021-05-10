import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/advertise_controller.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:pcm_admin/widgets/form_screen.dart';
import 'package:responsive_table/responsive_table.dart';

class ManageAdvertise extends StatefulWidget {
  @override
  _ManageAdvertiseState createState() => _ManageAdvertiseState();
}

class _ManageAdvertiseState extends State<ManageAdvertise> {
  ManageAdvertiseController adCtrl = Get.put(ManageAdvertiseController());

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
          text: "Ad Id",
          value: "ad",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Advertise Name",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Description",
          value: "desc",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Activation Status",
          value: "isActive",
          show: true,
          sortable: true,
          sourceBuilder: (value, row) => CupertinoSwitch(
              activeColor: Colors.cyan,
              value: adCtrl.adsData[row['index']]['isActive'] == 'Yes'
                  ? true
                  : false,
              onChanged: (bool newValue) {
                setState(() {
                  adCtrl.adsData[row['index']]['isActive'] == 'Yes'
                      ? adCtrl.adDeactivate(adCtrl.adsData[row['index']])
                      : adCtrl.adActivate(adCtrl.adsData[row['index']]);
                });
              }),
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Payment Received",
          value: "payment",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          sourceBuilder: (value, row) {
            return Checkbox(
              value: adCtrl.adsData[row['index']]['paymentReceived'] == 'Yes'
                  ? true
                  : adCtrl.payment.value,
              onChanged: (bool newValue) {
                setState(() {
                  adCtrl.adsData[row['index']]['paymentReceived'] == 'Yes'
                      ? adCtrl.paymentNotR(adCtrl.adsData[row['index']])
                      : adCtrl.paymentR(adCtrl.adsData[row['index']]);
                });
              },
            );
          }),
      DatatableHeader(
          text: "Actions",
          value: "action",
          show: true,
          sortable: true,
          textAlign: TextAlign.left,
          sourceBuilder: (value, row) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                    tooltip: "Edit Ad",
                    onPressed: () {
                      Get.defaultDialog(
                        confirm: adCtrl.isLoading.value
                            ? Container(
                                height: 30,
                                width: 30,
                                child: buildLoader(),
                              )
                            : button(
                                onTap: () {
                                  if (adCtrl.formKey.currentState.validate()) {
                                    adCtrl.editAd(adCtrl.adsData[row['index']]);
                                  } else
                                    return null;
                                },
                                buttonTxt: "Save",
                                buttonColor: theme.buttonColor,
                                txtColor: theme.primaryColorDark,
                                txtSize: 15,
                              ),
                        title: "Edit Details",
                        actions: [
                          button(
                            onTap: () {
                              adCtrl.chooseFile();
                            },
                            buttonTxt: "Add Photo",
                            buttonColor: theme.buttonColor,
                            txtColor: theme.primaryColorDark,
                            txtSize: 15,
                          )
                        ],
                        content: FormDialog(
                          isEdit: true,
                          count: adCtrl.textFieldCount,
                          labelText:
                              ["Enter Ad Name", "Enter Ad Description"].obs,
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
                  tooltip: "Delete Ad",
                  onPressed: () {
                    Get.defaultDialog(
                      radius: 25,
                      title: "Are you sure you want to delete this ad?",
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
                                adCtrl.deleteAd(row['object']);
                                adCtrl.adsData.removeAt(row['index']);
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
            );
          }),
    ];
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          button(
              buttonColor: theme.buttonColor,
              txtSize: 15,
              txtColor: theme.primaryColorDark,
              buttonTxt: "Add New",
              onTap: () {
                Get.defaultDialog(
                  confirm: adCtrl.isLoading.value
                      ? Container(
                          height: 30,
                          width: 30,
                          child: buildLoader(),
                        )
                      : button(
                          onTap: () {
                            if (adCtrl.formKey.currentState.validate()) {
                              adCtrl.registerAd();
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
                        adCtrl.chooseFile();
                      },
                      buttonTxt: "Add Photo",
                      buttonColor: theme.buttonColor,
                      txtColor: theme.primaryColorDark,
                      txtSize: 15,
                    )
                  ],
                  content: FormDialog(
                    adsData: adCtrl.adsData,
                    count: adCtrl.textFieldCount,
                    labelText: ["Enter Ad Name", "Enter Ad Description"].obs,
                  ),
                );
              }),
          SizedBox(
            height: 8,
          ),
          Obx(
            () =>
                /*adCtrl.isLoading.value
                ? Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    child: buildLoader(),
                  )
                :*/
                (adCtrl.adsData()?.isNotEmpty ?? false)
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
                                    width:
                                        MediaQuery.of(context).size.width / 8,
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
                                              icon: adCtrl.pageNo.value == 0
                                                  ? Icon(
                                                      Icons
                                                          .arrow_back_ios_sharp,
                                                      color: Colors.grey,
                                                    )
                                                  : Icon(Icons
                                                      .arrow_back_ios_sharp),
                                              onPressed:
                                                  adCtrl.pageNo.value == 0
                                                      ? () {}
                                                      : () {
                                                          /* if (adCtrl
                                          .startIndex
                                          .value >
                                          0) {
                                        adCtrl
                                            .startIndex
                                            .value = adCtrl
                                            .startIndex
                                            .value -
                                            10;
                                      }*/
                                                          adCtrl.pageNo.value--;
                                                          adCtrl.loadAdData();
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
                                                "${adCtrl.pageNo.value + 1}",
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
                                              icon: adCtrl.adsData.length != 10
                                                  ? Icon(
                                                      Icons
                                                          .arrow_forward_ios_sharp,
                                                      color: Colors.grey,
                                                    )
                                                  : Icon(Icons
                                                      .arrow_forward_ios_sharp),
                                              onPressed:
                                                  adCtrl.adsData.length != 10
                                                      ? () {}
                                                      : () {
                                                          /* adCtrl.showPaginatedList
                                                                .value = true;*/

                                                          adCtrl.pageNo.value++;
                                                          adCtrl.loadAdData();
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
                              showSelect: true,
                              title: Text("Manage Advertisement",
                                  style: kInterText.copyWith(
                                    color: theme.accentColor,
                                    fontSize: 25,
                                  )),
                              isLoading: adCtrl.isLoading.value,
                              autoHeight: true,
                              source: List.generate(
                                  adCtrl.adsData.isNotEmpty
                                      ? adCtrl.adsData?.length
                                      : null,
                                  (index) => {
                                        'id': index + 1,
                                        'index': index,
                                        'ad': adCtrl.adsData[index]['objectId'],
                                        'name': adCtrl.adsData[index]['adName'],
                                        'desc': adCtrl.adsData[index]
                                            ['adDescription'],
                                        /* 'payment': adCtrl.adsData[index][''],*/
                                        'object': adCtrl.adsData[index],
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
                      )),
          )
        ],
      ),
    );
  }
}
