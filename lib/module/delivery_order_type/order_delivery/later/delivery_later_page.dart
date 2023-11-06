import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pizza/module/delivery_order_type/date_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/common_dialog.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../date_time_searchable_list.dart';
import '../../searchable_list.dart';
import 'delivery_later_controller.dart';

class DeliveryLaterPage extends GetView<DeliveryLaterController> {
  const DeliveryLaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Obx(() => controller.isStoreOff.value
                    ? Text(
                        "Store is close please select another date",
                        style: TextStyle(color: AppColors.red),
                      )
                    : const SizedBox()),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Date",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),

                /// date
                Obx(() {
                  List<DateModel> dateList =
                      controller.getNext15DaysWithWeekdays();
                  List<String> dateFormattedList = dateList
                      .map((e) =>
                          DateFormat('d MMMM yyyy, EEEE').format(e.dateTime))
                      .toList();
                  return ListTile(
                    onTap: () async {
                      String date = await Get.dialog(CommonSearchableList(
                        title: "Date",
                        streetList: dateFormattedList,
                      ));
                      if (date.isNotEmpty) {
                        controller.date.value = date;
                        DateFormat inputFormat =
                            DateFormat('d MMMM yyyy, EEEE');
                        DateTime dateTime = inputFormat.parse(date);
                        controller.searchDateInList(dateTime);
                      }
                    },
                    contentPadding: const EdgeInsets.only(bottom: 4.0),
                    title: Text(
                      controller.date.value,
                      style: TextStyle(
                          color: controller.date.value == "Date"
                              ? Colors.grey.shade600
                              : AppColors.black),
                    ),
                    shape: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade800,
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 15,
                ),

                /// time
                Text(
                  "Time",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () async {
                          if (controller.date.value == "Date") {
                            showErrorDialog(
                              title: "Date Select",
                              message: "Please select date first",
                            );
                          } else {
                            String? time = await Get.dialog(
                              CommonSearchableList(
                                title: "Time",
                                streetList: controller.timeIntervalList,
                              ),
                            );
                            if (time != null) {
                              controller.time.value = time;
                            }
                          }
                        },
                        contentPadding: const EdgeInsets.only(bottom: 4.0),
                        title: Text(
                          controller.time.value,
                          style: TextStyle(
                            color: controller.time.value == "Time"
                                ? Colors.grey.shade600
                                : AppColors.black,
                          ),
                        ),
                        /* trailing: Icon(
                          controller.isTimeExpand.value
                              ? Icons.arrow_drop_up
                              : Icons.keyboard_arrow_down,
                        ),*/
                        shape: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      /*    Visibility(
                        visible: controller.isTimeExpand.value,
                        child: Card(
                          child: SizedBox(
                            height: 200,
                            child: controller.timeIntervalList.isEmpty
                                ? const Center(child: Text("no data found !"))
                                : ListView(
                                    children: controller.timeIntervalList
                                        .map((time) => GestureDetector(
                                              onTap: () {
                                                controller.time.value = time;
                                                controller.toggleTimeExpand();
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(time),
                                                ),
                                              ),
                                            ))
                                        .toList()

                                    */ /*controller
                                  .getTime(controller.outletShiftDetailsModel
                                      .value.data!.regular![0]!)
                                  .map((time) => GestureDetector(
                                        onTap: () {
                                          controller.time.value = time;
                                          controller.toggleTimeExpand();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(time),
                                          ),
                                        ),
                                      ))
                                  .toList(),*/ /*
                                    ),
                          ),
                        ),
                      ),*/
                    ],
                  );
                }),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Enter Full Address",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Card(
                  elevation: 0,
                  child: TextFormField(
                    controller: controller.unitController,
                    focusNode: controller.unitFocus,
                    decoration:
                        const InputDecoration(hintText: "Enter Unit Number"),
                    validator: (unitNumber) {
                      return unitNumber!.isEmpty ? "*Required" : null;
                    },
                    onFieldSubmitted: (value) {
                      controller.streetNumberFocus.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  child: TextFormField(
                    controller: controller.streetNumberController,
                    focusNode: controller.streetNumberFocus,
                    decoration:
                        const InputDecoration(hintText: "Enter Street Number"),
                    validator: (streetNumber) {
                      return streetNumber!.isEmpty ? "*Required" : null;
                    },
                    onFieldSubmitted: (value) {
                      controller.streetNumberFocus.unfocus();
                    },
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  List<SingleGeographyModel> streetList = controller.streetList!
                      .where((ele) =>
                          ele.parentGeographyMst?.geographyTypeMst
                              ?.geographyTypeCode ==
                          "GT5")
                      .toList();
                  return ListTile(
                    onTap: () async {
                      SingleGeographyModel? item = await Get.dialog(
                        SearchableStringListDialog(
                          title: "Street Name",
                          streetList: streetList,
                        ),
                      );
                      if (item != null) {
                        controller.streetName.value =
                            "${item.geographyName ?? ""} - ${item.parentGeographyMst != null ? item.parentGeographyMst!.geographyName : ""}";

                        controller.postCode.value = item.parentGeographyMst
                                ?.parentGeographyMst?.geographyName ??
                            "";
                      }
                    },
                    contentPadding: const EdgeInsets.only(bottom: 4.0),
                    title: Text(
                      controller.streetName.value,
                      style: TextStyle(
                          color: controller.streetName.value == "Street Name"
                              ? Colors.grey.shade600
                              : AppColors.black),
                    ),
                    shape: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade800,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Obx(() {
                  return Card(
                    child: TextFormField(
                      controller: controller.postCodeController,
                      focusNode: controller.postCodeFocus,
                      decoration: InputDecoration(
                        hintText: controller.postCode.value,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      return Checkbox(
                          value: controller.rememberAddress.value,
                          onChanged: (value) {
                            controller.rememberAdd(value!);
                          });
                    }),
                    const SizedBox(width: 5),
                    const Text("Remember Delivery Details")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (controller.formKey.currentState!.validate()) {
            showErrorDialog(title: "Success", message: "Order Successful");
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          alignment: Alignment.center,
          height: 5.h,
          decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Text(
            "Continue with the order",
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
