import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/controller/users_controller.dart';
import 'package:pcm_admin/view/users/client.dart';
import 'package:pcm_admin/view/users/delivery_boy.dart';
import 'package:pcm_admin/view/users/marketing.dart';
import 'package:pcm_admin/view/users/salesperson.dart';

class ManageUsers extends StatelessWidget {
  UserController userCtrl = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: TabBar(
            automaticIndicatorColorAdjustment: true,
            isScrollable: false,
            onTap: (value) {
              if (value == 0) {
                userCtrl.userIndex.value = 0;
              } else if (value == 1) {
                userCtrl.userIndex.value = 1;
              } else if (value == 2) {
                userCtrl.userIndex.value = 2;
              } else {
                userCtrl.userIndex.value = 3;
              }
              value == 0
                  ? userCtrl.loadUser(userCtrl.returnCUser())
                  : value == 1
                      ? userCtrl.loadUser(userCtrl.returnMUser())
                      : value == 2
                          ? userCtrl.loadUser(userCtrl.returnSUser())
                          : userCtrl.loadUser(userCtrl.returnDUser());
            },
            tabs: [
              Tab(
                text: "Client",
              ),
              Tab(
                text: "Marketing",
              ),
              Tab(
                text: "SalesPerson",
              ),
              Tab(
                text: "DeliveryBoy",
              ),
            ],
          ),
        ),
        body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
          Client(),
          Marketing(),
          SalesPerson(),
          DeliveryBoy(),
        ]),
      ),
    );
  }
}
