import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
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
                          child: SizedBox(
                            height: 200,
                            child: /*controller.getTime(controller
                                  .shiftListDetailsModel!
                                  .values
                                  .last!
                                  .regular!
                                  .first!)*/

                                ListView.builder(
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
                      ),
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          controller.toggleStreet();
                        },
                        contentPadding: const EdgeInsets.only(bottom: 4.0),
                        title: Text(
                          controller.streetName.value,
                          style: TextStyle(
                              color:
                                  controller.streetName.value == "Street Name"
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
                        visible: controller.isStreetExpand.value,
                        child: Card(
                          child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, int index) {
                                return ListTile(
                                  onTap: () {
                                    controller.streetName.value =
                                        index.toString();
                                    controller.toggleStreet();
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
                const SizedBox(height: 10),
                Card(
                  child: TextFormField(
                    controller: controller.postCodeController,
                    focusNode: controller.postCodeFocus,
                    decoration: const InputDecoration(hintText: "Post Code"),
                  ),
                ),
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
                /* Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Continue with the order",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        alignment: Alignment.center,
        height: 5.h,
        decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
          "Continue with the order",
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
