import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/home_screen_controller.dart';
import 'package:pcm_admin/controller/sign_in_controller.dart';
import 'package:pcm_admin/controller/users_controller.dart';
import 'package:pcm_admin/view/dashboard_screen.dart';
import 'package:pcm_admin/view/feedback_screen.dart';
import 'package:pcm_admin/view/manage_advertisement.dart';
import 'package:pcm_admin/view/manage_orders.dart';
import 'package:pcm_admin/view/manage_products.dart';
import 'package:pcm_admin/view/manage_users.dart';
import 'package:pcm_admin/view/reports_section/report_screen.dart';
import 'package:pcm_admin/view/support_details.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController userCtrl = Get.put(HomeScreenController());

  UserController ctrl = Get.put(UserController());

  SignInController loginCtrl = Get.put(SignInController());

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
            "PPM Admin Panel",
            style: kInterText.copyWith(
              fontSize: 25,
              color: theme.accentColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            /*Container(
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
*/
            Container(
              margin: EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.security_rounded),
                iconSize: 30,
                onPressed: () {
                  setState(() {});
                  Get.defaultDialog(
                      barrierDismissible: false,
                      cancel: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          Get.back();
                          loginCtrl.newPassword.clear();
                          loginCtrl.confirmPassword.clear();
                        },
                      ),
                      title: "Reset Password",
                      content: Obx(() => Form(
                            key: loginCtrl.fPFormKey,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: loginCtrl.newPassword,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter a new password";
                                          } else
                                            return null;
                                        },
                                        obscureText:
                                            loginCtrl.hidePassword.value,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              loginCtrl.hidePassword.value =
                                                  !loginCtrl.hidePassword.value;
                                            },
                                            child: loginCtrl.hidePassword.value
                                                ? Icon(
                                                    Icons.visibility_off,
                                                  )
                                                : Icon(
                                                    Icons.remove_red_eye_sharp,
                                                  ),
                                          ),
                                          hintText: "Enter Your New password",
                                          hintStyle: kInterText.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: loginCtrl.confirmPassword,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter a password";
                                          } else if (loginCtrl
                                                  .confirmPassword.text !=
                                              loginCtrl.newPassword.text)
                                            return "Password do not match";
                                        },
                                        obscureText:
                                            loginCtrl.hideConfirmPassword.value,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              loginCtrl.hideConfirmPassword
                                                      .value =
                                                  !loginCtrl.hideConfirmPassword
                                                      .value;
                                            },
                                            child: loginCtrl
                                                    .hideConfirmPassword.value
                                                ? Icon(
                                                    Icons.visibility_off,
                                                  )
                                                : Icon(
                                                    Icons.remove_red_eye_sharp,
                                                  ),
                                          ),
                                          hintText: "Confirm Your password",
                                          hintStyle: kInterText.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    loginCtrl.isLoading.value
                                        ? buildLoader()
                                        : button(
                                            buttonColor: theme.buttonColor,
                                            txtSize: 15,
                                            txtColor: theme.primaryColorDark,
                                            buttonTxt: "Reset",
                                            onTap: () {
                                              if (loginCtrl
                                                  .fPFormKey.currentState
                                                  .validate()) {
                                                loginCtrl.changePassword(
                                                    loginCtrl.username.text
                                                        .toString(),
                                                    loginCtrl
                                                        .confirmPassword.text
                                                        .toString());
                                              }
                                            })
                                  ],
                                ),
                              ),
                            ),
                          )));
                },
                tooltip: "Reset Password",
                color: theme.accentColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.login_outlined),
                iconSize: 30,
                onPressed: () {
                  Get.back();
                  loginCtrl.password.clear();
                  loginCtrl.username.clear();
                },
                tooltip: "Logout",
                color: theme.accentColor,
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
                print('###index${index}');
                ctrl.loadUser(ctrl.returnCUser());
              },
              minWidth: 60,
              groupAlignment: 0,
              backgroundColor: theme.backgroundColor,
              elevation: 10,
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                    icon: Icon(
                      Icons.dashboard_customize,
                      color: theme.disabledColor,
                    ),
                    label: Text(
                      "DashBoard",
                      style: kInterText.copyWith(
                        fontSize: 12,
                        color: theme.accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    selectedIcon: Icon(
                      Icons.dashboard_customize,
                      color: theme.accentColor,
                    )),
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
                      Icons.category_rounded,
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
                      Icons.category_rounded,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.upload_file,
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
                      Icons.upload_file,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.supervised_user_circle_sharp,
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
                      Icons.supervised_user_circle_sharp,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.feedback_rounded,
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
                      Icons.feedback_rounded,
                      color: theme.accentColor,
                    )),
                NavigationRailDestination(
                    icon: Icon(
                      Icons.support_agent_outlined,
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
                      Icons.support_agent_outlined,
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
                    )),
              ],
              selectedIndex: userCtrl.selectedIndex.value,
            ),
            VerticalDivider(thickness: 1, width: 3),
            Expanded(
              child: Container(
                  child: userCtrl.selectedIndex() == 0
                      ? DashBoardScreen()
                      : userCtrl.selectedIndex() == 1
                          ? ManageAdvertise()
                          : userCtrl.selectedIndex() == 2
                              ? ManageProducts()
                              : userCtrl.selectedIndex() == 3
                                  ? ManageOrders()
                                  : userCtrl.selectedIndex() == 4
                                      ? ManageUsers()
                                      : userCtrl.selectedIndex() == 5
                                          ? ViewFeedBack()
                                          : userCtrl.selectedIndex() == 6
                                              ? SupportScreen()
                                              : ReportScreen()),
            )
          ],
        )));
  }
}
