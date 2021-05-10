import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcm_admin/app_config.dart';
import 'package:pcm_admin/controller/users_controller.dart';

class SalesPerson extends StatelessWidget {
  UserController userCtrl = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        button(
            buttonColor: theme.buttonColor,
            txtSize: 15,
            txtColor: theme.primaryColorDark,
            buttonTxt: "Add New",
            onTap: () {}),
        SizedBox(
          height: 50,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => (userCtrl.distriInfo()?.isNotEmpty ?? false)
                  ? DataTable(
                      sortAscending: true,
                      columns: [
                        DataColumn(
                          label: Expanded(
                            child: SelectableText(
                              "Sr No.",
                              style: kInterText.copyWith(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: SelectableText(
                              "Full Name",
                              style: kInterText.copyWith(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: SelectableText(
                              "Role",
                              style: kInterText.copyWith(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SelectableText(
                            "Address",
                            style: kInterText.copyWith(
                              fontSize: 15,
                              color: theme.accentColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: SelectableText(
                              "Document",
                              maxLines: 1,
                              style: kInterText.copyWith(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: SelectableText(
                              "Mobile Number",
                              style: kInterText.copyWith(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: SelectableText(
                              "Shop Name",
                              style: kInterText.copyWith(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: SelectableText(
                              "Shop Location",
                              style: kInterText.copyWith(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: SelectableText(
                              "Shop Photo",
                              style: kInterText.copyWith(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: SelectableText(
                              "isActive",
                              maxLines: 1,
                              style: kInterText.copyWith(
                                fontSize: 15,
                                color: theme.accentColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SelectableText(
                            "Actions",
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
                                style: kInterText.copyWith(
                                  fontSize: 12,
                                  color: theme.unselectedWidgetColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(
                              SelectableText(
                                "Divya Mehta",
                                style: kInterText.copyWith(
                                  fontSize: 12,
                                  color: theme.unselectedWidgetColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(
                              SelectableText(
                                "Distributor",
                                style: kInterText.copyWith(
                                  fontSize: 12,
                                  color: theme.unselectedWidgetColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(
                              SelectableText(
                                "604 Sutariya town,ghod dod road, surat,gujarat",
                                style: kInterText.copyWith(
                                  fontSize: 12,
                                  color: theme.unselectedWidgetColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(
                              SelectableText(
                                "Document",
                                style: kInterText.copyWith(
                                  fontSize: 12,
                                  color: theme.unselectedWidgetColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(
                              SelectableText(
                                "7990126071",
                                style: kInterText.copyWith(
                                  fontSize: 12,
                                  color: theme.unselectedWidgetColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(
                              SelectableText(
                                "Vitrag book centre",
                                style: kInterText.copyWith(
                                  fontSize: 12,
                                  color: theme.unselectedWidgetColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(
                              SelectableText(
                                "lat,long,",
                                style: kInterText.copyWith(
                                  fontSize: 12,
                                  color: theme.unselectedWidgetColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(
                              SelectableText(
                                "Shop Photo",
                                style: kInterText.copyWith(
                                  fontSize: 12,
                                  color: theme.unselectedWidgetColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataCell(CupertinoSwitch(
                              value: userCtrl.isActive.value,
                              onChanged: (value) {
                                userCtrl.isActive.value = value;
                              },
                              activeColor: theme.accentColor,
                            )),
                            DataCell(
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                        tooltip: "Edit user",
                                        onPressed: () {},
                                        icon: Icon(Icons.edit_outlined)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                      tooltip: "View User",
                                      onPressed: () {},
                                      icon: Icon(Icons.rate_review))
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: SelectableText(
                      "No data to display",
                      style: kInterText.copyWith(
                          fontSize: 25, color: theme.accentColor),
                    )),
            ))
      ],
    );
  }
}
