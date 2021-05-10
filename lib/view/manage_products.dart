import 'dart:html' hide FormData;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/products_controller.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:pcm_admin/widgets/form_screen.dart';
import 'package:responsive_table/responsive_table.dart';

class ManageProducts extends StatefulWidget {
  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  ProductsController proCtrl = Get.put(ProductsController());
  Uint8List uploadedImage;

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
          text: "Product Name",
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
          text: "Price",
          value: "price",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Product Unit",
          value: "unit",
          show: true,
          flex: 1,
          sortable: true,
          textAlign: TextAlign.center),
/*      DatatableHeader(
          text: "Product Photo",
          value: "img",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center)*/
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
                    tooltip: "Edit Product",
                    onPressed: () {
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
                                    //proCtrl.uploadImg();
                                    proCtrl.editPro(
                                        proCtrl.productsList[row['index']]);
                                  } else
                                    return null;
                                },
                                buttonTxt: "Save",
                                buttonColor: theme.buttonColor,
                                txtColor: theme.primaryColorDark,
                                txtSize: 15,
                              ),
                        actions: [
                          button(
                            onTap: () {
                              proCtrl.chooseFile();
                            },
                            buttonTxt: "Add Photo",
                            buttonColor: theme.buttonColor,
                            txtColor: theme.primaryColorDark,
                            txtSize: 15,
                          )
                        ],
                        title: "Edit Details",
                        content: FormDialog(
                          count: 4,
                          labelText: [
                            "Enter Product Name",
                            "Enter Product Description",
                            "Enter Price",
                            "Enter Unit",
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
                  tooltip: "Delete Product",
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
                                proCtrl.deletePro(row['object']);
                                proCtrl.productsList.removeAt(row['index']);
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
                Expanded(
                  child: IconButton(
                    tooltip: "View Photo",
                    onPressed: () {
                      Get.defaultDialog(
                        confirm: proCtrl.isLoading.value
                            ? Container(
                                height: 30,
                                width: 30,
                                child: buildLoader(),
                              )
                            : button(
                                onTap: () {
                                  Get.back();
                                },
                                buttonTxt: "Close",
                                buttonColor: theme.buttonColor,
                                txtColor: theme.primaryColorDark,
                                txtSize: 10,
                              ),
                        title: "List of Photos",
                        content: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: row['action']?.length ?? "-",
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Image.network(
                                      'https://cup.marketing.dharmatech.in/file/product/${row['action'][index] ?? 'image_1620455027186.jpg'}')),
                            ),
                            Text("Scroll Through Images"),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.view_carousel_outlined),
                    iconSize: 15,
                  ),
                )
              ],
            );
          }),
    ];

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
                proCtrl.fileList().clear();
                proCtrl.finalImageList().clear();
                proCtrl.nameList().clear();
                print(proCtrl.nameList().length);
                print(proCtrl.fileList().length);
                Get.defaultDialog(
                  cancel: Obx(() => button(
                        onTap: proCtrl.nameList().length !=
                                proCtrl.fileList.length
                            ? () {}
                            : () {
                                if (proCtrl.formKey.currentState.validate()) {
                                  proCtrl.registerPro();
                                }
                              },
                        buttonTxt: "Ok",
                        buttonColor: theme.buttonColor,
                        txtColor: theme.primaryColorDark,
                        txtSize: 10,
                      )),
                  confirm: proCtrl.isLoading.value
                      ? buildLoaderDash()
                      : button(
                          onTap: () {
                            if (proCtrl.formKey.currentState.validate()) {
                              for (var i = 0;
                                  i < proCtrl.fileList()?.length;
                                  i++) {
                                proCtrl.uploadImg(
                                    proCtrl.fileList[i].toString(),
                                    proCtrl.finalImageList[i]);
                              }

                              // proCtrl.uploadPicture();
                              /*proCtrl.fileList
                                  .removeRange(0, proCtrl.fileList?.length);*/
                              //proCtrl.uploadSelectedFile();
                            }
                          },
                          buttonTxt: "Save",
                          buttonColor: theme.buttonColor,
                          txtColor: theme.primaryColorDark,
                          txtSize: 10,
                        ),
                  title: "Enter Details",
                  actions: [
                    button(
                      onTap: () {
                        proCtrl.chooseFile();
                      },
                      buttonTxt: "Add Photo",
                      buttonColor: theme.buttonColor,
                      txtColor: theme.primaryColorDark,
                      txtSize: 10,
                    ),
                  ],
                  content: FormDialog(
                    count: 4,
                    labelText: [
                      "Enter Product Name",
                      "Enter Product Description",
                      "Enter Price",
                      "Enter Unit"
                    ].obs,
                  ),
                );
              }),
          SizedBox(
            height: 50,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () =>
                    /* proCtrl.isLoading.value == true
                    ? Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        child: buildLoader(),
                      )
                    :*/
                    (proCtrl.productsList()?.isNotEmpty ?? false)
                        ? ResponsiveDatatable(
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
                                            icon: proCtrl.pageNo.value == 0
                                                ? Icon(
                                                    Icons.arrow_back_ios_sharp,
                                                    color: Colors.grey,
                                                  )
                                                : Icon(
                                                    Icons.arrow_back_ios_sharp),
                                            onPressed: proCtrl.pageNo.value == 0
                                                ? () {}
                                                : () {
                                                    /* if (proCtrl
                                          .startIndex
                                          .value >
                                          0) {
                                        proCtrl
                                            .startIndex
                                            .value = proCtrl
                                            .startIndex
                                            .value -
                                            10;
                                      }*/
                                                    proCtrl.pageNo.value--;
                                                    proCtrl.loadPro();
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
                                              "${proCtrl.pageNo.value + 1}",
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
                                            icon: proCtrl.productsList.length !=
                                                    10
                                                ? Icon(
                                                    Icons
                                                        .arrow_forward_ios_sharp,
                                                    color: Colors.grey,
                                                  )
                                                : Icon(Icons
                                                    .arrow_forward_ios_sharp),
                                            onPressed:
                                                proCtrl.productsList.length !=
                                                        10
                                                    ? () {}
                                                    : () {
                                                        /* proCtrl.showPaginatedList
                                                                .value = true;*/

                                                        proCtrl.pageNo.value++;
                                                        proCtrl.loadPro();
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
                            isLoading: proCtrl.isLoading.value,
                            title: Text("Products detail",
                                style: kInterText.copyWith(
                                  color: theme.accentColor,
                                  fontSize: 25,
                                )),
                            source: List.generate(
                                proCtrl.productsList.isNotEmpty
                                    ? proCtrl.productsList?.length
                                    : null,
                                (index) => {
                                      'id': index + 1,
                                      'object': proCtrl.productsList[index],
                                      'index': index,
                                      'name': proCtrl.productsList[index]
                                              ['productName'] ??
                                          "-",
                                      'desc': proCtrl.productsList[index]
                                              ['productDesc'] ??
                                          "-",
                                      'unit': proCtrl.productsList[index]
                                              ['unit'] ??
                                          "-",
                                      'price': proCtrl.productsList[index]
                                              ['productPrice'] ??
                                          "-",
                                      'img': "Image",
                                      'action': proCtrl.productsList[index]
                                              ['imageFileName'] ??
                                          '-',
                                    }),
                          )
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

/*
  _startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    try {
      uploadInput.onChange.listen((e) {
        // read file content as dataURL
        final files = uploadInput.files;
        if (files.length == 1) {
          final file = files[0];
          FileReader reader = FileReader();

          reader.onLoadEnd.listen((e) {
            setState(() {
              uploadedImage = reader.result;
            });
          });

          reader.onError.listen((fileEvent) {
            setState(() {
              var option1Text = "Some Error occured while reading the file";
              print(option1Text);
            });
          });

          reader.readAsArrayBuffer(file);
        }
      });

      var uploadProfile = <String, dynamic>{
        "image": MultipartFile.fromBytes(
          uploadedImage,
          contentType: MediaType('image', '*'),
          filename: 'image_upload',
        )
      };

      if (uploadProfile != null && uploadedImage != null) {
        var response =
            await API.uploadProfilePictureApi(FormData.fromMap(uploadProfile));

        if (response?.statusCode == 200) {
          print(response?.data);
          print("Image added success");
          // isLoading.value = false;
        } else {
          print("Image added failed");
        }
      }
    } catch (e) {
      print(e);
      print("Error occured ,try again");
    }
  }
*/
}
/*


DataRow(
cells: [
DataCell(
SelectableText(
"${index + 1}",
style: kInterText.copyWith(
fontSize: 10,
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
fontSize: 10,
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
fontSize: 10,
color: theme.unselectedWidgetColor,
fontWeight: FontWeight.w500,
),
),
),
DataCell(
SelectableText(
*/
/* "${proCtrl.productsList[index]['productPhoto']}" */ /*

"-",
style: kInterText.copyWith(
fontSize: 10,
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
confirm: proCtrl.isLoading.value
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
proCtrl.editPro(
proCtrl.productsList[
index]);
} else
return null;
},
buttonTxt: "Save",
buttonColor:
theme.buttonColor,
txtColor: theme
    .primaryColorDark,
txtSize: 10,
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
txtColor:
theme.primaryColorDark,
txtSize: 10,
),
],
content: FormDialog(
count: proCtrl.textFieldCount,
labelText: [
"Enter Product Name",
"Enter Product Description"
].obs,
),
);
},
icon: Icon(Icons.edit),
iconSize: 10,
),
),
SizedBox(
width: 5,
),
IconButton(
tooltip: "Delete Product",
iconSize: 10,
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
ElevatedButton(
style: ButtonStyle(
backgroundColor:
MaterialStateProperty
    .all(theme
    .primaryColor)),
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
fontSize: 10,
fontWeight:
FontWeight.w500,
),
)),
SizedBox(
height: 10,
),
ElevatedButton(
style: ButtonStyle(
backgroundColor:
MaterialStateProperty
    .all(theme
    .primaryColor)),
onPressed: () {
Get.back();
},
child: SelectableText(
'No',
style:
kInterText.copyWith(
color:
theme.hintColor,
fontSize: 10,
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
*/
/* IconButton(
                                          tooltip: "View Product",
                                          onPressed: () {},
                                          icon: Icon(Icons.rate_review))
                                    */ /*

],
),
),
],
);*/
