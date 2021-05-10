import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/reports_controller/advertisement_report.dart';
import 'package:pcm_admin/controller/reports_controller/client_report.dart';
import 'package:pcm_admin/controller/reports_controller/delivery_report.dart';
import 'package:pcm_admin/controller/reports_controller/products_report.dart';
import 'package:pcm_admin/controller/reports_controller/sales_report.dart';
import 'package:pcm_admin/view/reports_section/advertisement_report.dart';
import 'package:pcm_admin/view/reports_section/client_report.dart';
import 'package:pcm_admin/view/reports_section/delivery_report.dart';
import 'package:pcm_admin/view/reports_section/marketing_report.dart';
import 'package:pcm_admin/view/reports_section/products_report.dart';
import 'package:pcm_admin/view/reports_section/sales_report.dart';

class ReportScreen extends StatelessWidget {
  AdReportC adR = Get.put(AdReportC());
  ProdReportC proC = Get.put(ProdReportC());
  SalesReportController report = Get.put(SalesReportController());
  DelReportController delR = Get.put(DelReportController());
  ReportController clientR = Get.put(ReportController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GridView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              GestureDetector(
                onTap: () {
                  clientR.loadClientsReport();
                },
                child: Card(
                  elevation: 25,
                  // color: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      child: Text(
                        'Client Report',
                        style: kInterText,
                      ),
                      onPressed: () {
                        Get.to(() => Report());
                      },
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  delR.loadCDelReport();
                },
                child: Card(
                  elevation: 25,
                  // color: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      child: Text(
                        'Delivery Report',
                        style: kInterText,
                      ),
                      onPressed: () {
                        Get.to(() => DelReport());
                      },
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  report.loadSalesReport();
                },
                child: Card(
                  elevation: 25,
                  // color: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      child: Text(
                        'Sales Person Report',
                        style: kInterText,
                      ),
                      onPressed: () {
                        Get.to(() => SalesReport());
                      },
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  report.loadSalesReport();
                },
                child: Card(
                  elevation: 25,
                  // color: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      child: Text(
                        'Marketing Person Report',
                        style: kInterText,
                      ),
                      onPressed: () {
                        Get.to(() => MarketingReport());
                      },
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  adR.loadAdReport();
                },
                child: Card(
                  elevation: 25,
                  // color: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      child: Text(
                        'Advertisement Report',
                        style: kInterText,
                      ),
                      onPressed: () {
                        adR.loadAdReport();
                        Get.to(() => AdReport());
                      },
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  proC.loadProdReport();
                },
                child: Card(
                  elevation: 25,
                  // color: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      child: Text(
                        'Products Report',
                        style: kInterText,
                      ),
                      onPressed: () {
                        proC.loadProdReport();
                        Get.to(() => ProductReport());
                      },
                    ),
                  ),
                ),
              )
            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              childAspectRatio: 2 / 0.5,
            )),
      ],
    );
  }
}
