import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pizza/local_storage/shared_pref.dart';
import 'package:pizza/module/delivery_order_type/utils/date_model.dart';
import 'package:pizza/module/delivery_order_type/widgets/order_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/common_dialog.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../utils/get_week_list.dart';
import '../../widgets/date_time_searchable_list.dart';
import '../../widgets/searchable_list.dart';
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

                Card(
                  elevation: 0,
                  child: TextFormField(
                    onTap: () async {
                      List<DateModel> dateList =
                          getNext15DaysWithWeekdays();
                      List<String> dateFormattedList = dateList
                          .map((e) => DateFormat('d MMMM yyyy, EEEE')
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
                const SizedBox(height: 15),

                /// time
                Text(
                  "Time",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
                Card(
                  elevation: 0,
                  child: TextFormField(
                    onTap: () async {
                      List<SingleGeographyModel> streetList = controller
                          .streetList!
                          .where((ele) =>
                              ele.parentGeographyMst?.geographyTypeMst
                                  ?.geographyTypeCode ==
                              "GT5")
                          .toList();
                      SingleGeographyModel? item = await Get.dialog(
                        SearchableStringListDialog(
                          title: "Street Name",
                          streetList: streetList,
                        ),
                      );
                      if (item != null) {
                        controller.streetNameController.text =
                            "${item.geographyName ?? ""} - ${item.parentGeographyMst != null ? item.parentGeographyMst!.geographyName : ""}";

                        controller.postCodeController.text = item
                                .parentGeographyMst
                                ?.parentGeographyMst
                                ?.geographyName ??
                            "";
                      }
                    },
                    readOnly: true,
                    controller: controller.streetNameController,
                    decoration: const InputDecoration(hintText: "Street Name"),
                    validator: (streetName) {
                      return streetName!.isEmpty ? "*Required" : null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  child: TextFormField(
                    controller: controller.postCodeController,
                   // focusNode: controller.postCodeFocus,
                    decoration: const InputDecoration(
                      hintText: "Post Code",
                    ),
                    validator: (postCode) {
                      return postCode!.isEmpty ? "*Required" : null;
                    },
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: OrderButton(
        onTap: () {
          if (controller.formKey.currentState!.validate()) {
            if (controller.rememberAddress.value) {
              List<String> address = [
                controller.unitController.text,
                controller.streetNumberController.text,
                controller.streetNameController.text,
                controller.postCodeController.text,
              ];
              SharedPref.saveAddress("later",address);
            } else if (!controller.rememberAddress.value) {
              SharedPref.deleteAddress("later");
            }
            showErrorDialog(title: "Success", message: "Order Successful");
            controller.formKey.currentState?.reset();
          }
        },

      ),
    );
  }
}
