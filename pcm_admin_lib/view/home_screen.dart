import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/home_screen_controller.dart';
import 'package:pcm_admin/view/feedback_screen.dart';
import 'package:pcm_admin/view/manage_advertisement.dart';
import 'package:pcm_admin/view/manage_orders.dart';
import 'package:pcm_admin/view/manage_products.dart';
import 'package:pcm_admin/view/manage_users.dart';
import 'package:pcm_admin/view/sign_in_screen.dart';
import 'package:pcm_admin/view/support_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreenController userCtrl = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() => Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leadingWidth: 25,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          elevation: 5,
          title: Text(
            "PCM Admin Panel",
            style: kInterText.copyWith(
              fontSize: 25,
              color: theme.accentColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            userCtrl.selectedIndex.value == 1
                ? Container(
                    margin: EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      controller: userCtrl.searchField,
                      onChanged: (value) {
                        print(value);
                      },
                      cursorColor: Colors.white,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.search_sharp,
                            color: theme.accentColor,
                          ),
                        ),
                        hintText: "Search Here",
                        hintStyle: kInterText.copyWith(
                          color: theme.accentColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(SignIn());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.login_outlined,
                            size: 30,
                            semanticLabel: "Logout",
                            color: theme.accentColor,
                          ),
                          Text(
                            "Logout",
                            style: kInterText.copyWith(
                              fontSize: 10,
                              color: theme.accentColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
        body: Row(
          children: [
            NavigationRail(
              extended: false,
              minExtendedWidth: 150,
              onDestinationSelected: (int index) {
                userCtrl.selectedIndex.value = index;
              },
              minWidth: 60,
              groupAlignment: 0,
              backgroundColor: theme.backgroundColor,
              elevation: 10,
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                    icon: Icon(
                      Icons.dashboard_sharp,
                      color: theme.disabledColor,
                    ),
                    label: Text(
                      "Advertisements",
                      style: kInterText.copyWith(
                        fontSize: 12,
                        color: theme.accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    selectedIcon: Icon(
                      Icons.dashboard_sharp,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.supervised_user_circle_sharp,
                      color: theme.disabledColor,
                    ),
                    label: Text(
                      "Products",
                      style: kInterText.copyWith(
                        fontSize: 12,
                        color: theme.accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    selectedIcon: Icon(
                      Icons.supervised_user_circle_sharp,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.disabledColor,
                    ),
                    label: Text(
                      "Orders",
                      style: kInterText.copyWith(
                        fontSize: 12,
                        color: theme.accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    selectedIcon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.disabledColor,
                    ),
                    label: Text(
                      "Users",
                      style: kInterText.copyWith(
                        fontSize: 12,
                        color: theme.accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    selectedIcon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.disabledColor,
                    ),
                    label: Text(
                      "View Feedback",
                      style: kInterText.copyWith(
                        fontSize: 12,
                        color: theme.accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    selectedIcon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.disabledColor,
                    ),
                    label: Text(
                      "Support Details",
                      style: kInterText.copyWith(
                        fontSize: 12,
                        color: theme.accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    selectedIcon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.disabledColor,
                    ),
                    label: Text(
                      "Reports",
                      style: kInterText.copyWith(
                        fontSize: 12,
                        color: theme.accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    selectedIcon: Icon(
                      Icons.contact_page_rounded,
                      color: theme.accentColor,
                    ))
              ],
              selectedIndex: userCtrl.selectedIndex.value,
            ),
            VerticalDivider(thickness: 1, width: 3),
            Expanded(
              child: Container(
                child: userCtrl.selectedIndex() == 0
                    ? ManageAdvertise()
                    : userCtrl.selectedIndex() == 1
                        ? ManageProducts()
                        : userCtrl.selectedIndex() == 2
                            ? ManageOrders()
                            : userCtrl.selectedIndex() == 3
                                ? ManageUsers()
                                : userCtrl.selectedIndex() == 4
                                    ? ViewFeedBack()
                                    : userCtrl.selectedIndex() == 5
                                        ? SupportScreen()
                                        : null,
              ),
            )
          ],
        )));
  }
}
