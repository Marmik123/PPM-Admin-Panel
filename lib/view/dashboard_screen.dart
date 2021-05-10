import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/dashboard_controller.dart';
import 'package:pcm_admin/controller/reports_controller/client_report.dart';
import 'package:pcm_admin/controller/reports_controller/delivery_report.dart';
import 'package:pcm_admin/controller/reports_controller/sales_report.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';

class DashBoardScreen extends StatelessWidget {
  SalesReportController report = Get.put(SalesReportController());
  DelReportController delR = Get.put(DelReportController());
  ReportController clientR = Get.put(ReportController());
  DashController dashC = Get.put(DashController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            alignment: Alignment.bottomLeft,
            icon: Icon(Icons.refresh),
            iconSize: 25,
            color: Colors.cyan,
            onPressed: () {
              dashC.updateClientCount();
              dashC.updateDelCount();
              dashC.updateMarkCount();
              dashC.updateSalesCount();
              dashC.updateAdCount();
              dashC.updateFeedbackCount();
              dashC.updateProCount();
              dashC.updateOrdersCount();
            },
          ),
        ),
        Obx(
          () => GridView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    child: ListTile(
                      title: Text(
                        ' Total Number of Client Registered ',
                        style: kInterText,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 8),
                        child: dashC.isLoading.value
                            ? buildLoaderDash()
                            : Text(
                                '${dashC.clientCount}',
                                style: kInterText.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xffeecda3), Color(0xffef629f)])),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    child: ListTile(
                      title: Text(
                        ' Total Number of Delivery Boy',
                        style: kInterText,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 8),
                        child: dashC.isLoading.value
                            ? buildLoaderDash()
                            : Text(
                                '${dashC.delCount}',
                                style: kInterText.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xffeecda3), Color(0xffef629f)])),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    child: ListTile(
                      title: Text(
                        'Total Number of Sales Person ',
                        style: kInterText,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 8),
                        child: dashC.isLoading.value
                            ? buildLoaderDash()
                            : Text(
                                '${dashC.salesCount}',
                                style: kInterText.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    child: ListTile(
                      title: Text(
                        'Total Number of Marketing Person ',
                        style: kInterText,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 8),
                        child: dashC.isLoading.value
                            ? buildLoaderDash()
                            : Text(
                                '${dashC.markCount}',
                                style: kInterText.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    child: ListTile(
                      title: Text(
                        'Total Number of Products',
                        style: kInterText,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 8),
                        child: dashC.isLoading.value
                            ? buildLoaderDash()
                            : Text(
                                '${dashC.productCount}',
                                style: kInterText.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xffeecda3), Color(0xffef629f)])),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    child: ListTile(
                      title: Text(
                        'Total Number of Ads',
                        style: kInterText,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 8),
                        child: dashC.isLoading.value
                            ? buildLoaderDash()
                            : Text(
                                '${dashC.adCount}',
                                style: kInterText.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xffeecda3), Color(0xffef629f)])),
                    child: ListTile(
                      title: Text(
                        'Total Number of Feedback',
                        style: kInterText,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 8),
                        child: dashC.isLoading.value
                            ? buildLoaderDash()
                            : Text(
                                '${dashC.fbCount}',
                                style: kInterText.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [Color(0xff02aab0), Color(0xff00cdac)])),
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 5,
                    child: ListTile(
                      title: Text(
                        'Total Number of Orders Placed',
                        style: kInterText,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 8),
                        child: dashC.isLoading.value
                            ? buildLoaderDash()
                            : Text(
                                '${dashC.ordersCount}',
                                style: kInterText.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                      ),
                    ),
                  ),
                )
              ],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                childAspectRatio: 3 / 0.5,
              )),
        )
      ],
    );
  }
}
