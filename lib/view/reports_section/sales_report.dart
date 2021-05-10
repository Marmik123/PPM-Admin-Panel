import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/reports_controller/client_report.dart';
import 'package:pcm_admin/controller/reports_controller/sales_report.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:responsive_table/responsive_table.dart';

class SalesReport extends StatelessWidget {
  ReportController reportC = Get.put(ReportController());
  SalesReportController sCtrl = Get.put(SalesReportController());
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
          text: "Sales Person Name",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: " Mobile Number",
          value: "number",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
        text: "Clients Registered ",
        value: "clients",
        show: true,
        sortable: true,
        textAlign: TextAlign.center,
      ),
/*      DatatableHeader(
          text: "Actions",
          value: "action",
          show: true,
          flex: 2,
          sortable: true,
          sourceBuilder: (value, row) => IconButton(
                tooltip: "Delete Client",
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
                              reportC.deleteFeedBack(row['object']);
                              reportC.clients.removeAt(row['index']);
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
          textAlign: TextAlign.center),*/
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Person Report"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_sharp),
            color: Colors.cyan,
            onPressed: () {
              sCtrl.loadSalesReport();
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Obx(
              () =>
                  /* reportC.isLoading.value
                  ? Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      child: buildLoader(),
                    )
                  :*/
                  sCtrl.isLoading.value
                      ? buildLoader()
                      : (sCtrl.salesReport()?.isNotEmpty ?? false)
                          ? Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  ResponsiveDatatable(
                                    headers: header,
                                    autoHeight: true,
                                    isLoading: sCtrl.isLoading.value,
                                    title: Text("Manage Reports",
                                        style: kInterText.copyWith(
                                          color: theme.accentColor,
                                          fontSize: 25,
                                        )),
                                    source: List.generate(
                                        sCtrl.salesReport.isNotEmpty
                                            ? sCtrl.salesReport?.length
                                            : null,
                                        (index) => {
                                              'id': index + 1,
                                              'index': index,
                                              'object':
                                                  sCtrl.salesReport[index],
                                              'name': sCtrl.salesReport()[index]
                                                      ['salesPName'] ??
                                                  "-",
                                              'number':
                                                  sCtrl.salesReport()[index]
                                                          ['number'] ??
                                                      "-",
                                              'clients': sCtrl
                                                          .salesReport()[index]
                                                      ['clientsRegistered'] ??
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
      ),
    );
  }
}
