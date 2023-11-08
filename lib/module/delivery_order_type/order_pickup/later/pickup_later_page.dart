import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/later/pickup_later_controller.dart';
import 'package:pizza/module/delivery_order_type/widgets/order_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/common_dialog.dart';
import '../../utils/date_model.dart';
import '../../utils/get_week_list.dart';
import '../../widgets/date_time_searchable_list.dart';

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
                  return controller.isStoreOff.value
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
                      // List<DateModel> dateList = getNext15DaysWithWeekdays();
                      /*List<String> dateFormattedList = controller.dateList
                          .map((e) => DateFormat('d MMMM yyyy, EEEE')
                              .format(e))
                          .toList();*/
                      String date = await Get.dialog(CommonSearchableList(
                        title: "Date",
                        streetList: controller.dateList,
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
      bottomNavigationBar: Obx(() {
        return OrderButton(
          enable: !controller.isStoreOff.value,
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              showErrorDialog(title: "Success", message: "Order Successful");
              controller.formKey.currentState?.reset();
            }
          },
        );
      }),
    );
  }
}
