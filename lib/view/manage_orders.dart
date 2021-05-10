import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/advertise_controller.dart';
import 'package:pcm_admin/controller/order_controller.dart';
import 'package:pcm_admin/controller/users_controller.dart';
import 'package:pcm_admin/widgets/circular_loader.dart';
import 'package:responsive_table/responsive_table.dart';

class ManageOrders extends StatefulWidget {
  @override
  _ManageOrdersState createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
  OrderController oCtrl = Get.put(OrderController());
  UserController userCtrl = Get.put(UserController());
  ManageAdvertiseController adCtrl = Get.put(ManageAdvertiseController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<DatatableHeader> headerPast = [
      DatatableHeader(
          text: "Sr No.",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Order Description",
          value: "desc",
          show: true,
          flex: 2,
          sortable: true,
          sourceBuilder: (value, row) => Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: row['order_details'].length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Text("${index + 1}"),
                    title: Text("Name:${row['order_details'][index]['name']}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price:${row['order_details'][index]['price']}"),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Size:${row['order_details'][index]['size']}" ??
                            "Not mentioned")
                      ],
                    ),
                    trailing: Text(
                        "Quantity:${row['order_details'][index]['quantity']}"),
                  ),
                ),
              ),
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Order Date",
          value: "date",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Payment Option",
          value: "payment",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Order Total",
          value: "order_total",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Assigned Delivery Boy",
          value: "delivery",
          show: true,
          sourceBuilder: (value, row) => Text(
                oCtrl.pastOrders[row['index']]['deliveryBoyName'] ?? "-",
                textAlign: TextAlign.center,
              ),
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Select Ad",
          value: "ad",
          show: true,
          sortable: true,
          sourceBuilder: (value, row) => ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: row['order_details'].length,
              itemBuilder: (context, orderItem) {
                return Column(
                  children: [
                    Text(
                      row['order_details'][orderItem]['adName'] ?? "-",
                      textAlign: TextAlign.center,
                    ),
                    row['order_details'].length == 1
                        ? SizedBox.shrink()
                        : SizedBox(
                            height: 65,
                          )
                  ],
                );
              }),
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Delivery Address",
          value: "address",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
    ];
    List<DatatableHeader> headerOngoing = [
      DatatableHeader(
          text: "Sr No.",
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Order Description",
          value: "desc",
          show: true,
          flex: 3,
          sortable: true,
          sourceBuilder: (value, row) => Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: row['order_details'].length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Text("${index + 1}"),
                    title: Text("Name:${row['order_details'][index]['name']}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price:${row['order_details'][index]['price']}"),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Quantity:${row['order_details'][index]['quantity']} ${row['order_details'][index]['unit'] ?? "Unit"} "),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Size:${row['order_details'][index]['size']}" ??
                            "Not mentioned")
                      ],
                    ),
                  ),
                ),
              ),
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Order Date",
          value: "date",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Payment Option",
          value: "payment",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Order Total",
          value: "order_total",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Assign Delivery Boy",
          value: "delivery",
          show: true,
          flex: 2,
          sourceBuilder: (value, row) {
            return oCtrl.orderList[row['index']]['deliveryBoyName'] == null
                ? IconButton(
                    iconSize: 15,
                    onPressed: () {
                      oCtrl.isBoyAssigned[row['index']] =
                          oCtrl.boyAssigned.value;
                      print(oCtrl.isBoyAssigned);
                      userCtrl.loadUser(userCtrl.returnDUser());
                      Get.defaultDialog(
                          title: "List of Available Delivery Boys",
                          content: Obx(() => userCtrl.isLoading.value
                              ? buildLoader()
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                userCtrl.distriInfo.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: Text(
                                                  userCtrl.distriInfo[index]
                                                      ['name'],
                                                  style: kInterText.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                title: Text(
                                                  "( Pincode : ${userCtrl.distriInfo[index]['pincode']} )" ??
                                                      "-",
                                                  style: kInterText.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  "( Area : ${userCtrl.distriInfo[index]['address1']} )" ??
                                                      "-",
                                                  style: kInterText.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                /* trailing: Radio(
                                          autofocus: true,
                                          value: index,
                                          groupValue: oCtrl.assignDelBoy.value,
                                          onChanged: (value) {
                                            oCtrl.assignDelBoy.value = value;
                                          },
                                          activeColor: Colors.cyan,
                                          toggleable: true,
                                        ),*/
                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        oCtrl.assignBoy(
                                                            userCtrl.distriInfo[
                                                                index]['name'],
                                                            userCtrl.distriInfo[
                                                                    index]
                                                                ['number'],
                                                            oCtrl.orderList[
                                                                row['index']]);
                                                      },
                                                      style: ButtonStyle(
                                                        elevation:
                                                            MaterialStateProperty
                                                                .all(10),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(theme
                                                                    .primaryColor),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5,
                                                                vertical: 5),
                                                        child: Text(
                                                          "Assign",
                                                          style: kInterText
                                                              .copyWith(
                                                            fontSize: 15,
                                                            color: Colors.cyan,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ), /* Checkbox(
                                            value: oCtrl.assignDelBoy.value,
                                            onChanged: (value) {
                                              oCtrl.assignDelBoy.value = value;
                                            },
                                          ),*/
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                )));
                    },
                    color: theme.unselectedWidgetColor,
                    icon: Icon(Icons.add),
                  )
                : GestureDetector(
                    onTap: () {
                      oCtrl.isBoyAssigned[row['index']] =
                          oCtrl.boyAssigned.value;
                      print(oCtrl.isBoyAssigned);
                      userCtrl.loadUser(userCtrl.returnDUser());
                      Get.defaultDialog(
                          title: "List of Available Delivery Boys",
                          content: Obx(() => userCtrl.isLoading.value
                              ? buildLoader()
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                userCtrl.distriInfo.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: Text(
                                                  userCtrl.distriInfo[index]
                                                      ['name'],
                                                  style: kInterText.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                title: Text(
                                                  "( Pincode : ${userCtrl.distriInfo[index]['pincode']} )" ??
                                                      "-",
                                                  style: kInterText.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  "( Area : ${userCtrl.distriInfo[index]['address1']} )" ??
                                                      "-",
                                                  style: kInterText.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        oCtrl.assignBoy(
                                                            userCtrl.distriInfo[
                                                                index]['name'],
                                                            userCtrl.distriInfo[
                                                                    index]
                                                                ['number'],
                                                            oCtrl.paginatedList[
                                                                row['index']]);
                                                      },
                                                      style: ButtonStyle(
                                                        elevation:
                                                            MaterialStateProperty
                                                                .all(10),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(theme
                                                                    .primaryColor),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5,
                                                                vertical: 5),
                                                        child: Text(
                                                          "Assign",
                                                          style: kInterText
                                                              .copyWith(
                                                            fontSize: 15,
                                                            color: Colors.cyan,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ), /* Checkbox(
                                            value: oCtrl.assignDelBoy.value,
                                            onChanged: (value) {
                                              oCtrl.assignDelBoy.value = value;
                                            },
                                          ),*/
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                )));
                    },
                    child: Text(
                      oCtrl.orderList[row['index']]['deliveryBoyName'] ?? "-",
                      textAlign: TextAlign.center,
                    ),
                  );
          },
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Select Ad",
          value: "ad",
          show: true,
          flex: 2,
          sourceBuilder: (value, row) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: row['order_details'].length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, orderItemIndex) {
                return row['order_details'][orderItemIndex]['adName'] == null
                    ? Column(
                        children: [
                          IconButton(
                            iconSize: 15,
                            onPressed: () {
                              oCtrl.isBoyAssigned[row['index']] =
                                  oCtrl.boyAssigned.value;
                              print(oCtrl.isBoyAssigned);
                              adCtrl.loadActiveAdData();
                              Get.defaultDialog(
                                  title: "List of Available Ads",
                                  content: Obx(() => adCtrl.isLoading.value
                                      ? buildLoader()
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: adCtrl
                                                        .activeAdData?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        title: Text(
                                                          " Ad Id : ${adCtrl.activeAdData[index]['objectId']} " ??
                                                              "-",
                                                          style: kInterText
                                                              .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          "( Ad Name :  ${adCtrl.activeAdData[index]['adName']} )" ??
                                                              "-",
                                                          style: kInterText
                                                              .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        trailing: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                oCtrl.assignAd(
                                                                    adCtrl.activeAdData[index][
                                                                        'adName'],
                                                                    adCtrl.activeAdData[
                                                                            index]
                                                                        [
                                                                        'objectId'],
                                                                    row[
                                                                        'index'],
                                                                    orderItemIndex,
                                                                    row['order_details']
                                                                        [
                                                                        orderItemIndex],
                                                                    row['order_details'],
                                                                    row['objectId']);
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            10),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        theme
                                                                            .primaryColor),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        5),
                                                                child: Text(
                                                                  "Assign",
                                                                  style: kInterText
                                                                      .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .cyan,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ), /* Checkbox(
                                                value: oCtrl.assignDelBoy.value,
                                                onChanged: (value) {
                                                  oCtrl.assignDelBoy.value = value;
                                                },
                                              ),*/
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        )));
                            },
                            color: theme.unselectedWidgetColor,
                            icon: Icon(Icons.add),
                          ),
                          row['order_details'].length == 1
                              ? SizedBox.shrink()
                              : SizedBox(
                                  height: 65,
                                )
                        ],
                      )
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              oCtrl.isBoyAssigned[row['index']] =
                                  oCtrl.boyAssigned.value;
                              print(oCtrl.isBoyAssigned);
                              adCtrl.activeAdData();
                              Get.defaultDialog(
                                  title: "List of Available Ads",
                                  content: Obx(() => adCtrl.isLoading.value
                                      ? buildLoader()
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: adCtrl
                                                        .activeAdData?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        title: Text(
                                                          " Ad Id : ${adCtrl.activeAdData[index]['objectId']} " ??
                                                              "-",
                                                          style: kInterText
                                                              .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          "( Ad Name :  ${adCtrl.activeAdData[index]['adName']} )" ??
                                                              "-",
                                                          style: kInterText
                                                              .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        trailing: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                oCtrl.assignAd(
                                                                    adCtrl.activeAdData[index][
                                                                        'adName'],
                                                                    adCtrl.activeAdData[
                                                                            index]
                                                                        [
                                                                        'objectId'],
                                                                    row[
                                                                        'index'],
                                                                    orderItemIndex,
                                                                    row['order_details']
                                                                        [
                                                                        orderItemIndex],
                                                                    row['order_details'],
                                                                    row['objectId']);
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            10),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        theme
                                                                            .primaryColor),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        5),
                                                                child: Text(
                                                                  "Assign",
                                                                  style: kInterText
                                                                      .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .cyan,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ), /* Checkbox(
                                                value: oCtrl.assignDelBoy.value,
                                                onChanged: (value) {
                                                  oCtrl.assignDelBoy.value = value;
                                                },
                                              ),*/
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        )));
                            },
                            child: Text(
                              row['order_details'][orderItemIndex]['adName'] ??
                                  "-",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          row['order_details'].length == 1
                              ? SizedBox.shrink()
                              : SizedBox(
                                  height: 65,
                                )
                        ],
                      );
              },
            );
          },
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Delivery Address",
          value: "address",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Actions",
          value: "action",
          show: true,
          flex: 1,
          sortable: true,
          sourceBuilder: (value, row) => ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: row['order_details'].length,
                itemBuilder: (context, orderItemIndex) => Column(
                  children: [
                    IconButton(
                      tooltip: "Delete Product",
                      onPressed: () {
                        Get.defaultDialog(
                          radius: 25,
                          title:
                              "Are you sure you want to delete this product?",
                          titleStyle: kInterText.copyWith(
                            color: theme.accentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          content: Column(
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              theme.primaryColor)),
                                  onPressed: () {
                                    oCtrl.deleteOngoingOrder(
                                        orderItemIndex,
                                        row['order_details'][orderItemIndex],
                                        row['order_details'],
                                        row['objectId']);
                                    /* oCtrl.orderList.removeAt(row['index']
                                        ['order_details'][orderItemIndex]);*/
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
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
                    row['order_details'].length == 1
                        ? SizedBox.shrink()
                        : SizedBox(
                            height: 25,
                          )
                  ],
                ),
              ),
          textAlign: TextAlign.center)
    ];
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: TabBar(
              isScrollable: false,
              onTap: (index) {
                index == 0 ? oCtrl.loadData() : oCtrl.loadPastData();
              },
              tabs: [
                Tab(
                  text: "Ongoing Orders",
                ),
                Tab(
                  text: "Past Orders",
                ),
              ],
            ),
          ),
          body: Obx(
            () => TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      (oCtrl.orderList()?.isNotEmpty ?? false)
                          ? Expanded(
                              child: ListView(
                                children: [
                                  oCtrl.ongoingO.value
                                      ? buildLoader()
                                      : ResponsiveDatatable(
                                          footers: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15,
                                                  right: 25,
                                                  bottom: 15),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    8,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    16,
                                                decoration: BoxDecoration(
                                                  color: Colors.cyan,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 5),
                                                          icon: oCtrl.pageNo
                                                                      .value ==
                                                                  0
                                                              ? Icon(
                                                                  Icons
                                                                      .arrow_back_ios_sharp,
                                                                  color: Colors
                                                                      .grey,
                                                                )
                                                              : Icon(Icons
                                                                  .arrow_back_ios_sharp),
                                                          onPressed: oCtrl
                                                                      .pageNo
                                                                      .value ==
                                                                  0
                                                              ? () {}
                                                              : () {
                                                                  if (oCtrl
                                                                          .startIndex
                                                                          .value >
                                                                      0) {
                                                                    oCtrl
                                                                        .startIndex
                                                                        .value = oCtrl
                                                                            .startIndex
                                                                            .value -
                                                                        10;
                                                                  }
                                                                  oCtrl.pageNo
                                                                      .value--;
                                                                  oCtrl
                                                                      .loadData();
                                                                  oCtrl.orderList(oCtrl
                                                                      .orderList
                                                                      .getRange(
                                                                          oCtrl
                                                                              .startIndex
                                                                              .value,
                                                                          oCtrl.startIndex.value +
                                                                              10));
                                                                  oCtrl.paginatedList(oCtrl
                                                                      .orderList
                                                                      .sublist(
                                                                          oCtrl
                                                                              .startIndex
                                                                              .value,
                                                                          oCtrl.startIndex.value +
                                                                              10));
                                                                },
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.white,
                                                          ),
                                                          child: Text(
                                                            "${oCtrl.pageNo.value + 1}",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 5),
                                                          icon: oCtrl.orderList
                                                                      .length !=
                                                                  10
                                                              ? Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_sharp,
                                                                  color: Colors
                                                                      .grey,
                                                                )
                                                              : Icon(Icons
                                                                  .arrow_forward_ios_sharp),
                                                          onPressed: oCtrl
                                                                      .orderList
                                                                      .length !=
                                                                  10
                                                              ? () {}
                                                              : () {
                                                                  /* oCtrl.showPaginatedList
                                                                .value = true;*/

                                                                  oCtrl.pageNo
                                                                      .value++;
                                                                  oCtrl
                                                                      .loadData();
                                                                  // oCtrl.loadPaginatedData();
                                                                  /* oCtrl.startIndex.value =
                                                                oCtrl.startIndex.value +
                                                                    10;*/
                                                                  /*oCtrl.paginatedList(
                                                                oCtrl.orderList.sublist(
                                                                    oCtrl.startIndex
                                                                        .value,
                                                                    oCtrl.startIndex
                                                                            .value +
                                                                        10));*/
                                                                },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                          headers: headerOngoing,
                                          //isLoading: oCtrl.isLoading.value,
                                          title: Text("Manage Orders",
                                              style: kInterText.copyWith(
                                                color: theme.accentColor,
                                                fontSize: 25,
                                              )),
                                          source: List.generate(
                                              oCtrl.orderList.isNotEmpty
                                                  ? oCtrl.orderList?.length
                                                  : null, (index) {
                                            var date = DateFormat('yMMMMd')
                                                .format(oCtrl.orderList[index]
                                                    ['date_time']);
                                            oCtrl.orderDetails(
                                                oCtrl.orderList[index]
                                                    ['order_details']);
                                            print(oCtrl.orderDetails);
                                            print("hhhhhhhh");
                                            print(oCtrl.orderDetails.length);
                                            return {
                                              'id': index + 1,
                                              //'object': proCtrl.productsList[index],
                                              'index': index,
                                              /* 'desc': oCtrl.orderList[index]
                                            ['order_details'] ??
                                        "-",*/
                                              'date': date ?? '-',
                                              'payment': oCtrl.orderList[index]
                                                      ['payment_option'] ??
                                                  "-",
                                              'order_total':
                                                  oCtrl.orderList[index]
                                                          ['total_price'] ??
                                                      "-",
                                              'address': oCtrl.orderList[index]
                                                      ['customerAddress'] ??
                                                  "-",
                                              'order_details':
                                                  oCtrl.orderDetails(
                                                      oCtrl.orderList[index]
                                                          ['order_details']),
                                              'order_details_index': oCtrl
                                                  .orderDetails(
                                                      oCtrl.orderList[index]
                                                          ['order_details'])
                                                  .length,
                                              'objectId': oCtrl.orderList[index]
                                                      ['objectId'] ??
                                                  "-",
                                            };
                                          }),
                                        )
                                ],
                              ),
                            )
                          : Center(
                              child: SelectableText(
                              "No data to display",
                              style: kInterText.copyWith(
                                  fontSize: 25, color: theme.accentColor),
                            )),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: oCtrl.pastO.value
                              ? buildLoader()
                              : ResponsiveDatatable(
                                  footers: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, right: 25, bottom: 15),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                16,
                                        decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
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
                                                icon: oCtrl.pastOPageNo.value ==
                                                        0
                                                    ? Icon(
                                                        Icons
                                                            .arrow_back_ios_sharp,
                                                        color: Colors.grey,
                                                      )
                                                    : Icon(Icons
                                                        .arrow_back_ios_sharp),
                                                onPressed:
                                                    oCtrl.pastOPageNo.value == 0
                                                        ? () {}
                                                        : () {
                                                            if (oCtrl.startIndex
                                                                    .value >
                                                                0) {
                                                              oCtrl.startIndex
                                                                  .value = oCtrl
                                                                      .startIndex
                                                                      .value -
                                                                  10;
                                                            }
                                                            oCtrl.pastOPageNo
                                                                .value--;
                                                            oCtrl.loadData();
                                                            oCtrl.orderList(oCtrl
                                                                .orderList
                                                                .getRange(
                                                                    oCtrl
                                                                        .startIndex
                                                                        .value,
                                                                    oCtrl.startIndex
                                                                            .value +
                                                                        10));
                                                            oCtrl.paginatedList(oCtrl
                                                                .orderList
                                                                .sublist(
                                                                    oCtrl
                                                                        .startIndex
                                                                        .value,
                                                                    oCtrl.startIndex
                                                                            .value +
                                                                        10));
                                                          },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Text(
                                                  "${oCtrl.pastOPageNo.value + 1}",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              IconButton(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                icon: oCtrl.pastOrders.length !=
                                                        10
                                                    ? Icon(
                                                        Icons
                                                            .arrow_forward_ios_sharp,
                                                        color: Colors.grey,
                                                      )
                                                    : Icon(Icons
                                                        .arrow_forward_ios_sharp),
                                                onPressed: oCtrl.pastOrders
                                                            .length !=
                                                        10
                                                    ? () {}
                                                    : () {
                                                        /* oCtrl.showPaginatedList
                                                              .value = true;*/

                                                        oCtrl.pastOPageNo
                                                            .value++;
                                                        oCtrl.loadPastData();
                                                        // oCtrl.loadPaginatedData();
                                                        /* oCtrl.startIndex.value =
                                                              oCtrl.startIndex.value +
                                                                  10;*/
                                                        /*oCtrl.paginatedList(
                                                              oCtrl.orderList.sublist(
                                                                  oCtrl.startIndex
                                                                      .value,
                                                                  oCtrl.startIndex
                                                                          .value +
                                                                      10));*/
                                                      },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                  headers: headerPast,
                                  //isLoading: oCtrl.isLoading.value,
                                  title: Text("Manage Orders",
                                      style: kInterText.copyWith(
                                        color: theme.accentColor,
                                        fontSize: 25,
                                      )),
                                  source: List.generate(
                                      oCtrl.pastOrders.isNotEmpty
                                          ? oCtrl.pastOrders?.length
                                          : null, (index) {
                                    var date = DateFormat('yMMMMd').format(
                                        oCtrl.pastOrders[index]['date_time']);
                                    oCtrl.pastOrderDetails(oCtrl
                                        .pastOrders[index]['order_details']);
                                    print(oCtrl.pastOrderDetails);
                                    print("hhhhhhhh");
                                    print(oCtrl.pastOrderDetails.length);
                                    return {
                                      'id': index + 1,
                                      //'object': proCtrl.productsList[index],
                                      'index': index,
                                      /* 'desc': oCtrl.orderList[index]
                                            ['order_details'] ??
                                        "-",*/
                                      'date': date ?? "-",
                                      'payment': oCtrl.pastOrders[index]
                                              ['payment_option'] ??
                                          "-",
                                      'address': oCtrl.pastOrders[index]
                                              ['customerAddress'] ??
                                          "-",
                                      'ad': oCtrl.pastOrders[index]['adName'] ??
                                          "-",
                                      'order_total': oCtrl.pastOrders[index]
                                              ['total_price'] ??
                                          "-",
                                      'object_id': oCtrl.pastOrders[index]
                                              ['objectId'] ??
                                          "-",
                                      'order_details': oCtrl.pastOrderDetails(
                                          oCtrl.pastOrders[index]
                                              ['order_details']),
                                      'order_details_index': oCtrl
                                          .pastOrderDetails(
                                              oCtrl.pastOrders[index]
                                                  ['order_details'])
                                          .length,
                                    };
                                  }),
                                ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
