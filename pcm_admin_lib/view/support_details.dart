import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/support_details_controller.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:pcm_admin/widgets/form_screen.dart';

class SupportScreen extends StatelessWidget {
  SupportDetailsController sCtrl = Get.put(SupportDetailsController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
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
          Container(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => sCtrl.isLoading.value
                  ? Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      child: buildLoader(),
                    )
                  : (sCtrl.sData()?.isNotEmpty ?? false)
                      ? DataTable(
                          sortAscending: true,
                          columns: [
                            DataColumn(
                              label: SelectableText(
                                "Sr No.",
                                style: kInterText.copyWith(
                                  fontSize: 15,
                                  color: theme.accentColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SelectableText(
                                "Support Type",
                                style: kInterText.copyWith(
                                  fontSize: 15,
                                  color: theme.accentColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SelectableText(
                                "Support Data",
                                style: kInterText.copyWith(
                                  fontSize: 15,
                                  color: theme.accentColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SelectableText(
                                "Actions",
                                style: kInterText.copyWith(
                                  fontSize: 15,
                                  color: theme.accentColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                          rows: List.generate(
                              sCtrl.sData?.length,
                              (index) => DataRow(
                                    cells: [
                                      DataCell(
                                        SelectableText(
                                          "${index + 1}",
                                          style: kInterText.copyWith(
                                            fontSize: 12,
                                            color: theme.unselectedWidgetColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        SelectableText(
                                          sCtrl.sData[index]['supportType'] ??
                                              "-",
                                          style: kInterText.copyWith(
                                            fontSize: 12,
                                            color: theme.unselectedWidgetColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        SelectableText(
                                          sCtrl.sData[index]['data'] ?? "-",
                                          style: kInterText.copyWith(
                                            fontSize: 12,
                                            color: theme.unselectedWidgetColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  tooltip: "Edit Product",
                                                  onPressed: () {
                                                    Get.defaultDialog(
                                                      confirm: sCtrl
                                                              .isLoading.value
                                                          ? Container(
                                                              height: 30,
                                                              width: 30,
                                                              child:
                                                                  buildLoader(),
                                                            )
                                                          : button(
                                                              onTap: () {
                                                                if (sCtrl
                                                                    .formKey
                                                                    .currentState
                                                                    .validate()) {
                                                                  sCtrl.editData(
                                                                      sCtrl.sData[
                                                                          index]);
                                                                  sCtrl
                                                                      .loadData();

                                                                  Get.back();
                                                                } else
                                                                  return null;
                                                              },
                                                              buttonTxt: "Save",
                                                              buttonColor: theme
                                                                  .buttonColor,
                                                              txtColor: theme
                                                                  .primaryColorDark,
                                                              txtSize: 15,
                                                            ),
                                                      title: "Enter Details",
                                                      content: FormDialog(
                                                        count: sCtrl
                                                            .textFieldCount,
                                                        labelText: [
                                                          "Enter  Support type",
                                                          "Enter Support Data"
                                                        ].obs,
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(Icons.edit)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                tooltip: "Delete support",
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                    radius: 25,
                                                    title:
                                                        "Are you sure you want to delete this feedback?",
                                                    titleStyle:
                                                        kInterText.copyWith(
                                                      color: theme.accentColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    content: Column(
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              sCtrl.deleteData(
                                                                  sCtrl.sData[
                                                                      index]);
                                                              sCtrl.sData
                                                                  .removeAt(
                                                                      index);
                                                              Get.back();
                                                            },
                                                            child:
                                                                SelectableText(
                                                              'Yes',
                                                              style: kInterText
                                                                  .copyWith(
                                                                color: theme
                                                                    .hintColor,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child:
                                                                SelectableText(
                                                              'No',
                                                              style: kInterText
                                                                  .copyWith(
                                                                color: theme
                                                                    .hintColor,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )))
                      : Center(
                          child: SelectableText(
                          "No data to display",
                          style: kInterText.copyWith(
                              fontSize: 25, color: theme.accentColor),
                        )),
            ),
          )
        ],
      ),
    );
  }
}
