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
          bottom: TabBar(
            onTap: (value) {
              value == 0
                  ? userCtrl.loadUser(userCtrl.returnCUser())
                  : value == 1
                      ? userCtrl.loadUser(userCtrl.returnSUser())
                      : value == 2
                          ? userCtrl.loadUser(userCtrl.returnMUser())
                          : value == 3
                              ? userCtrl.loadUser(userCtrl.returnDUser())
                              : null;
            },
            tabs: [
              Tab(
                text: "Client",
              ),
              Tab(
                text: "SalesPerson",
              ),
              Tab(
                text: "Marketing",
              ),
              Tab(
                text: "DeliveryBoy",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Client(),
          SalesPerson(),
          Marketing(),
          DeliveryBoy(),
        ]),
      ),
    );
  }
}
