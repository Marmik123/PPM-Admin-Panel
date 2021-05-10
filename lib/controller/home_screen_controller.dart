import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/controller/advertise_controller.dart';
import 'package:pcm_admin/controller/dashboard_controller.dart';
import 'package:pcm_admin/controller/feedback_controller.dart';
import 'package:pcm_admin/controller/order_controller.dart';
import 'package:pcm_admin/controller/products_controller.dart';
import 'package:pcm_admin/controller/reports_controller/client_report.dart';
import 'package:pcm_admin/controller/reports_controller/delivery_report.dart';
import 'package:pcm_admin/controller/reports_controller/marketing_report.dart';
import 'package:pcm_admin/controller/reports_controller/sales_report.dart';
import 'package:pcm_admin/controller/support_details_controller.dart';
import 'package:pcm_admin/controller/users_controller.dart';

class HomeScreenController extends GetxController {
  ManageAdvertiseController adCtrl = Get.put(ManageAdvertiseController());
  UserController userCtrl = Get.put(UserController());
  FeedBackController fbCtrl = Get.put(FeedBackController());
  ProductsController proCtrl = Get.put(ProductsController());
  SupportDetailsController sCtrl = Get.put(SupportDetailsController());
  OrderController oCtrl = Get.put(OrderController());
  ReportController report = Get.put(ReportController());
  DelReportController del = Get.put(DelReportController());
  SalesReportController sales = Get.put(SalesReportController());
  MReportController mCtrl = Get.put(MReportController());
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  TextEditingController searchField = TextEditingController();
  DashController dashC = Get.put(DashController());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    adCtrl.loadAdData();
    fbCtrl.loadFeedBack();
    userCtrl.loadUser(userCtrl.returnCUser());
    proCtrl.loadPro();
    sCtrl.loadData();
    oCtrl.loadData();
    oCtrl.loadPastData();
    report.loadClientsReport();
    del.loadCDelReport();
    sales.loadSalesReport();
    mCtrl.loadMarketingReport();
    dashC.updateClientCount();
    dashC.updateDelCount();
    dashC.updateMarkCount();
    dashC.updateSalesCount();
    dashC.updateAdCount();
    dashC.updateFeedbackCount();
    dashC.updateProCount();
    dashC.updateOrdersCount();
  }
}
