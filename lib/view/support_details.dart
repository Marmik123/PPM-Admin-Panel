import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/support_details_controller.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:pcm_admin/widgets/form_screen.dart';
import 'package:responsive_table/responsive_table.dart';

class SupportScreen extends StatelessWidget {
  SupportDetailsController sCtrl = Get.put(SupportDetailsController());
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
          text: "Support Type",
          value: "type",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Support Data",
          value: "data",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Actions",
          value: "action",
          show: true,
          sortable: true,
          sourceBuilder: (value, row) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      tooltip: "Edit Ad",
                      onPressed: () {
                        Get.defaultDialog(
                          confirm: sCtrl.isLoading.value
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  child: buildLoader(),
                                )
                              : button(
                                  onTap: () {
                                    if (sCtrl.formKey.currentState.validate()) {
                                      sCtrl.editData(sCtrl.sData[row['index']]);
                                    } else
                                      return null;
                                  },
                                  buttonTxt: "Save",
                                  buttonColor: theme.buttonColor,
                                  txtColor: theme.primaryColorDark,
                                  txtSize: 15,
                                ),
                          title: "Edit Details",
                          content: FormDialog(
                            count: sCtrl.textFieldCount,
                            labelText: [
                              "Enter  Support type",
                              "Enter Support Data",
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
                    tooltip: "Delete Details",
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
                                  sCtrl.deleteData(row['object']);
                                  sCtrl.sData.removeAt(row['index']);
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          button(
              buttonColor: theme.buttonColor,
              txtSize: 15,
              txtColor: theme.primaryColorDark,
              buttonTxt: "Add New",
              onTap: () {
                Get.defaultDialog(
                  confirm: sCtrl.isLoading.value
                      ? Container(
                          height: 30,
                          width: 30,
                          child: buildLoader(),
                        )
                      : button(
                          onTap: () {
                            if (sCtrl.formKey.currentState.validate()) {
                              print('about to call register');
                              sCtrl.registerDetails();
                              Get.back();
                            } else
                              return null;
                          },
                          buttonTxt: "Save",
                          buttonColor: theme.buttonColor,
                          txtColor: theme.primaryColorDark,
                          txtSize: 15,
                        ),
                  title: "Enter Details",
                  content: FormDialog(
                    count: sCtrl.textFieldCount,
                    labelText:
                        ["Enter  Support type", "Enter Support Data"].obs,
                  ),
                );
              }),
          SizedBox(
            height: 30,
          ),
          Obx(
            () =>
                /* sCtrl.isLoading.value
                ? Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    child: buildLoader(),
                  )
                :*/
                (sCtrl.sData()?.isNotEmpty ?? false)
                    ? Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ResponsiveDatatable(
                              headers: header,
                              autoHeight: true,
                              isLoading: sCtrl.isLoading.value,
                              title: Text("Manage Support Details",
                                  style: kInterText.copyWith(
                                    color: theme.accentColor,
                                    fontSize: 25,
                                  )),
                              source: List.generate(
                                  sCtrl.sData.isNotEmpty
                                      ? sCtrl.sData?.length
                                      : null,
                                  (index) => {
                                        'id': index + 1,
                                        'index': index,
                                        'object': sCtrl.sData[index],
                                        'type': sCtrl.sData[index]
                                                ['supportType'] ??
                                            "-",
                                        'data':
                                            sCtrl.sData[index]['data'] ?? "-",
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
