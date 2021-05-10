import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/controller/advertise_controller.dart';
import 'package:pcm_admin/controller/feedback_controller.dart';
import 'package:pcm_admin/controller/products_controller.dart';
import 'package:pcm_admin/controller/support_details_controller.dart';
import 'package:pcm_admin/controller/users_controller.dart';

class HomeScreenController extends GetxController {
  ManageAdvertiseController adCtrl = Get.put(ManageAdvertiseController());
  UserController userCtrl = Get.put(UserController());
  FeedBackController fbCtrl = Get.put(FeedBackController());
  ProductsController proCtrl = Get.put(ProductsController());
  SupportDetailsController sCtrl = Get.put(SupportDetailsController());

  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  TextEditingController searchField = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    adCtrl.loadAdData();
    fbCtrl.loadFeedBack();
    userCtrl.loadUser(userCtrl.returnMUser());
    proCtrl.loadPro();
    sCtrl.loadData();
  }
}
