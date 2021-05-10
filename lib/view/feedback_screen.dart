import 'package:flutter/material.dart';
import 'package:get/get.dart' hide length;
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/feedback_controller.dart';
import 'package:responsive_table/responsive_table.dart';

class ViewFeedBack extends StatelessWidget {
  FeedBackController fbCtrl = Get.put(FeedBackController());

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
          text: "User Name",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Feedback Subject",
          value: "fbs",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Feedback Description",
          value: "fbd",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Actions",
          value: "action",
          show: true,
          flex: 2,
          sortable: true,
          sourceBuilder: (value, row) => IconButton(
                tooltip: "Delete Feedback",
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
                              fbCtrl.deleteFeedBack(row['object']);
                              fbCtrl.fbList.removeAt(row['index']);
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
          textAlign: TextAlign.center),
    ];
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Obx(
            () =>
                /* fbCtrl.isLoading.value
                ? Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    child: buildLoader(),
                  )
                :*/
                (fbCtrl.fbList()?.isNotEmpty ?? false)
                    ? Expanded(
                        child: ListView(
                          shrinkWrap: true,
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
                                              icon: fbCtrl.fbPageNo.value == 0
                                                  ? Icon(
                                                      Icons
                                                          .arrow_back_ios_sharp,
                                                      color: Colors.grey,
                                                    )
                                                  : Icon(Icons
                                                      .arrow_back_ios_sharp),
                                              onPressed:
                                                  fbCtrl.fbPageNo.value == 0
                                                      ? () {}
                                                      : () {
                                                          /* if (fbCtrl
                                          .startIndex
                                          .value >
                                          0) {
                                        fbCtrl
                                            .startIndex
                                            .value = fbCtrl
                                            .startIndex
                                            .value -
                                            10;
                                      }*/
                                                          fbCtrl
                                                              .fbPageNo.value--;
                                                          fbCtrl.loadFeedBack();
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
                                                "${fbCtrl.fbPageNo.value + 1}",
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
                                              icon: fbCtrl.fbList.length != 10
                                                  ? Icon(
                                                      Icons
                                                          .arrow_forward_ios_sharp,
                                                      color: Colors.grey,
                                                    )
                                                  : Icon(Icons
                                                      .arrow_forward_ios_sharp),
                                              onPressed: fbCtrl.fbList.length !=
                                                      10
                                                  ? () {}
                                                  : () {
                                                      /* fbCtrl.showPaginatedList
                                                                .value = true;*/

                                                      fbCtrl.fbPageNo.value++;
                                                      fbCtrl.loadFeedBack();
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
                              isLoading: fbCtrl.isLoading.value,
                              title: Text("Manage Feedbacks",
                                  style: kInterText.copyWith(
                                    color: theme.accentColor,
                                    fontSize: 25,
                                  )),
                              source: List.generate(
                                  fbCtrl.fbList.isNotEmpty
                                      ? fbCtrl.fbList?.length
                                      : null,
                                  (index) => {
                                        'id': index + 1,
                                        'index': index,
                                        'object': fbCtrl.fbList[index],
                                        'name': fbCtrl.fbList()[index]
                                                ['username'] ??
                                            "-",
                                        'fbs': fbCtrl.fbList()[index]
                                                ['subject'] ??
                                            "-",
                                        'fbd': fbCtrl.fbList()[index]
                                                ['message'] ??
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
                      )),
          )
        ],
      ),
    );
  }
}
