import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/later/pickup_later_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';

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
                Text(
                  "Date",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          controller.toggleDateExpand();
                        },
                        contentPadding: const EdgeInsets.only(bottom: 4.0),
                        title: Text(
                          controller.date.value,
                          style: TextStyle(
                              color: controller.date.value == "Date"
                                  ? Colors.grey.shade600
                                  : AppColors.black),
                        ),
                        trailing: Icon(controller.isDataExpand.value
                            ? Icons.arrow_drop_up
                            : Icons.keyboard_arrow_down),
                        shape: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.isDataExpand.value,
                        child: Card(
                          child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, int index) {
                                return ListTile(
                                  onTap: () {
                                    controller.date.value = index.toString();
                                    controller.toggleDateExpand();
                                  },
                                  title: Text("index->$index"),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
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
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          controller.toggleTimeExpand();
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
                        trailing: Icon(
                          controller.isTimeExpand.value
                              ? Icons.arrow_drop_up
                              : Icons.keyboard_arrow_down,
                        ),
                        shape: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.isTimeExpand.value,
                        child: Card(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, int index) {
                              return ListTile(
                                onTap: () {
                                  controller.time.value = index.toString();
                                  controller.toggleTimeExpand();
                                },
                                title: Text("index->$index"),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
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
                Card(
                  child: TextFormField(
                    controller: controller.outletAddController,
                    decoration:
                        const InputDecoration(hintText: "Outlet Address"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        alignment: Alignment.center,
        height: 5.h,
        decoration:  BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child:  Text(
          "Continue with the order",
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
