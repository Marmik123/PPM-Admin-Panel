import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/products_controller.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:pcm_admin/widgets/form_screen.dart';

class ManageProducts extends StatelessWidget {
  ProductsController proCtrl = Get.put(ProductsController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
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
                proCtrl.fileList.clear();
                Get.defaultDialog(
                  confirm: proCtrl.isLoading.value
                      ? Container(
                          height: 30,
                          width: 30,
                          child: buildLoader(),
                        )
                      : button(
                          onTap: () {
                            if (proCtrl.formKey.currentState.validate()) {
                              proCtrl.registerPro();
                              Get.back();
                              proCtrl.fileList
                                  .removeRange(0, proCtrl.fileList?.length);
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
                        //  proCtrl.chooseFileUsingFilePicker();
                      },
                      buttonTxt: "Add Photo",
                      buttonColor: theme.buttonColor,
                      txtColor: theme.primaryColorDark,
                      txtSize: 15,
                    ),
                  ],
                  content: FormDialog(
                    count: proCtrl.textFieldCount,
                    labelText:
                        ["Enter Product Name", "Enter Product Description"].obs,
                  ),
                );
              }),
          SizedBox(
            height: 50,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => proCtrl.isLoading.value == true
                    ? Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        child: buildLoader(),
                      )
                    : (proCtrl.productsList()?.isNotEmpty ?? false)
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
                                  "Products Name",
                                  style: kInterText.copyWith(
                                    fontSize: 15,
                                    color: theme.accentColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SelectableText(
                                  "Description",
                                  style: kInterText.copyWith(
                                    fontSize: 15,
                                    color: theme.accentColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: SelectableText(
                                  "Product Photo",
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
                            rows: List.generate(proCtrl.productsList?.length,
                                (index) {
                              return DataRow(
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
                                      proCtrl.productsList[index]
                                              ['productName'] ??
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
                                      proCtrl.productsList[index]
                                              ['productDesc'] ??
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
                                      "${proCtrl.productsList[index]['productPhoto']}" ??
                                          "-",
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconButton(
                                              tooltip: "Edit Product",
                                              onPressed: () {
                                                Get.defaultDialog(
                                                  confirm: proCtrl
                                                          .isLoading.value
                                                      ? Container(
                                                          height: 30,
                                                          width: 30,
                                                          child: buildLoader(),
                                                        )
                                                      : button(
                                                          onTap: () {
                                                            if (proCtrl.formKey
                                                                .currentState
                                                                .validate()) {
                                                              /* proCtrl
                                                                  .uploadImg();*/
                                                              proCtrl.editPro(
                                                                  proCtrl.productsList[
                                                                      index]);
                                                              /*proCtrl
                                                                  .uploadPicture();*/
                                                              Get.back();
                                                            } else
                                                              return null;
                                                          },
                                                          buttonTxt: "Save",
                                                          buttonColor:
                                                              theme.buttonColor,
                                                          txtColor: theme
                                                              .primaryColorDark,
                                                          txtSize: 15,
                                                        ),
                                                  title: "Enter Details",
                                                  actions: [
                                                    button(
                                                      onTap: () {
                                                        proCtrl.chooseFile();
                                                      },
                                                      buttonTxt: "Add Photo",
                                                      buttonColor:
                                                          theme.buttonColor,
                                                      txtColor: theme
                                                          .primaryColorDark,
                                                      txtSize: 15,
                                                    ),
                                                  ],
                                                  content: FormDialog(
                                                    labelText: [
                                                      "Enter Product Name",
                                                      "Enter Product Description"
                                                    ].obs,
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.edit)),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                          tooltip: "Delete Product",
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title:
                                                  "Are you sure you want to delete this product?",
                                              titleStyle: kInterText.copyWith(
                                                color: theme.accentColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              content: Column(
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        proCtrl.deletePro(
                                                            proCtrl.productsList[
                                                                index]);
                                                        proCtrl.productsList
                                                            .removeAt(index);
                                                      },
                                                      child: SelectableText(
                                                        'Yes',
                                                        style:
                                                            kInterText.copyWith(
                                                          color:
                                                              theme.hintColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: SelectableText(
                                                        'No',
                                                        style:
                                                            kInterText.copyWith(
                                                          color:
                                                              theme.hintColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                        SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                            tooltip: "View Product",
                                            onPressed: () {},
                                            icon: Icon(Icons.rate_review))
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }))
                        : Center(
                            child: SelectableText(
                            "No data to display",
                            style: kInterText.copyWith(
                                fontSize: 25, color: theme.accentColor),
                          )),
              ))
        ],
      ),
    );
  }
}
