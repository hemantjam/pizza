import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../geography/byType/street_name_model.dart';
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
                        trailing: Icon(controller.isDateExpand.value
                            ? Icons.arrow_drop_up
                            : Icons.keyboard_arrow_down),
                        shape: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.isDateExpand.value,
                        child: Card(
                          child: SizedBox(
                            height: 200,
                            child: ListView(
                              children: controller
                                  .getNext15DaysWithWeekdays()
                                  .map((dateModel) {
                                String formattedDate =
                                    DateFormat('d MMMM yyyy, EEEE')
                                        .format(dateModel.dateTime);
                                return GestureDetector(
                                  onTap: () {
                                    controller.date.value = formattedDate;
                                    controller.weekDay.value =
                                        dateModel.weekday;
                                    controller
                                        .getTimerInterval(dateModel.dateTime);
                                    controller.toggleDateExpand();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(formattedDate),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            /*ListView.builder(
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
                            ),*/
                          ),
                        ),
                      ),
                    ],
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

                                    /*controller
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
                                  .toList(),*/
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
                        trailing: Icon(controller.isDateExpand.value
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
                            child: controller.streetList == null ||
                                    controller.streetList!.isEmpty
                                ? const Center(child: Text("No Data Found !"))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    itemBuilder: (context, int index) {
                                      SingleGeographyModel item =
                                          controller.streetList![index];
                                      return ListTile(
                                        onTap: () {
                                          controller.streetName.value =
                                              item.geographyName.toString();
                                          controller.toggleStreet();
                                          controller.getPostCode(
                                              item.geographyName ?? "");
                                        },
                                        title: Text(item.geographyName ?? ""),
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
      bottomNavigationBar: Container(
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
    );
  }
}
