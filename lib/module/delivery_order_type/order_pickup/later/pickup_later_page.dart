import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/later/pickup_later_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/common_dialog.dart';
import '../../date_model.dart';
import '../../date_time_searchable_list.dart';

class PickUpLaterPage extends GetView<PickUpLaterController> {
  const PickUpLaterPage({super.key});

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
                Obx(() {
                  return controller.storeOff.value
                      ? Text(
                    "Please Note : Store is closed currently , please select another time",
                    style: TextStyle(color: AppColors.red),
                  )
                      : const SizedBox();
                }),
                Text(
                  "Date",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Card(
                  elevation: 0,
                  child: TextFormField(
                    onTap: () async {
                      List<DateModel> dateList =
                      controller.getNext15DaysWithWeekdays();
                      List<String> dateFormattedList = dateList
                          .map((e) =>
                          DateFormat('d MMMM yyyy, EEEE')
                              .format(e.dateTime))
                          .toList();
                      String date = await Get.dialog(CommonSearchableList(
                        title: "Date",
                        streetList: dateFormattedList,
                      ));
                      if (date.isNotEmpty) {
                        controller.timeController.clear();
                        controller.dateController.text = date;
                        DateFormat inputFormat =
                        DateFormat('d MMMM yyyy, EEEE');
                        DateTime dateTime = inputFormat.parse(date);
                        controller.searchDateInList(dateTime);
                      }
                    },
                    readOnly: true,
                    controller: controller.dateController,
                    decoration: const InputDecoration(hintText: "Date"),
                    validator: (date) {
                      return date!.isEmpty ? "*Required" : null;
                    },
                  ),
                ),
                /* Obx(() {
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
                }),*/
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Time",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Card(
                  elevation: 0,
                  child: TextFormField(
                    onTap: () async {
                      if (controller.dateController.text.isEmpty) {
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
                          controller.timeController.text = time;
                        }
                      }
                    },
                    readOnly: true,
                    controller: controller.timeController,
                    decoration: const InputDecoration(hintText: "Time"),
                    validator: (time) {
                      return time!.isEmpty ? "*Required" : null;
                    },
                  ),
                ),
                /* Obx(() {
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
                        shape: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  );
                }),*/
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Outlet Address",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  return Card(
                    elevation: 0,
                    child: IgnorePointer(
                      ignoring: true,
                      child: TextFormField(
                        readOnly: true,
                        controller: controller.outletAddController,
                        decoration: InputDecoration(
                          hintText: controller.outletAddress.value,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (controller.formKey.currentState!.validate()) {
            showErrorDialog(title: "Success", message: "Order Successful");
            controller.formKey.currentState?.reset();
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
