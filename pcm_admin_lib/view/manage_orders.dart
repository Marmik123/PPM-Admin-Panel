import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcm_admin/app_config.dart';

class ManageOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
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
        body: TabBarView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    sortAscending: true,
                    columns: [
                      DataColumn(
                        label: SelectableText(
                          "Sr No.",
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                          style: kInterText.copyWith(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SelectableText(
                          "Order Description",
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                          style: kInterText.copyWith(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SelectableText(
                          " Assign Delivery boy",
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                          style: kInterText.copyWith(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SelectableText(
                          "Select Ad",
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                          style: kInterText.copyWith(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            SelectableText(
                              "1",
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false),
                              style: kInterText.copyWith(
                                fontSize: 12,
                                color: theme.unselectedWidgetColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataCell(
                            SelectableText(
                              " Description about order",
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false),
                              style: kInterText.copyWith(
                                fontSize: 12,
                                color: theme.unselectedWidgetColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataCell(IconButton(
                            onPressed: () {},
                            color: theme.unselectedWidgetColor,
                            icon: Icon(Icons.add),
                          )),
                          DataCell(IconButton(
                            onPressed: () {},
                            color: theme.unselectedWidgetColor,
                            icon: Icon(Icons.add),
                          )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    sortAscending: true,
                    columns: [
                      DataColumn(
                        label: SelectableText(
                          "Sr No.",
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                          style: kInterText.copyWith(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SelectableText(
                          "Order Description",
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                          style: kInterText.copyWith(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SelectableText(
                          " Assigned Delivery boy",
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                          style: kInterText.copyWith(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SelectableText(
                          "Selected Ad",
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                              cut: false,
                              paste: false),
                          style: kInterText.copyWith(
                            fontSize: 15,
                            color: theme.accentColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            SelectableText(
                              "1",
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false),
                              style: kInterText.copyWith(
                                fontSize: 12,
                                color: theme.unselectedWidgetColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataCell(
                            SelectableText(
                              " Description about order",
                              toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false),
                              style: kInterText.copyWith(
                                fontSize: 12,
                                color: theme.unselectedWidgetColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataCell(SelectableText(
                            "Delivery boy name",
                            toolbarOptions: ToolbarOptions(
                                copy: true,
                                selectAll: true,
                                cut: false,
                                paste: false),
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.unselectedWidgetColor,
                            ),
                          )),
                          DataCell(SelectableText(
                            " Ad name",
                            toolbarOptions: ToolbarOptions(
                                copy: true,
                                selectAll: true,
                                cut: false,
                                paste: false),
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.unselectedWidgetColor,
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
