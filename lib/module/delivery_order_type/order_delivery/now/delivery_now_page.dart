import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/local_storage/shared_pref.dart';
import 'package:pizza/widgets/common_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../widgets/order_button.dart';
import '../../widgets/searchable_list.dart';
import 'delivery_now_controller.dart';

class DeliveryNowPage extends GetView<DeliveryNowController> {
  const DeliveryNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => controller.storeOff.value
                      ? Text(
                          "Please Note : Store is currently closed. Please select next available time.",
                          style: TextStyle(color: AppColors.red),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: 15),
                Text(
                  "Enter Full Address",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
                    validator: (unitNumber) {
                      return unitNumber!.isEmpty ? "*Required" : null;
                    },
                    onFieldSubmitted: (value) {
                      controller.streetNumberFocus.unfocus();
                    },
                    textInputAction: TextInputAction.next,
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
                  return Card(
                    elevation: 0,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
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
                      controller: controller.streetNameController,
                      decoration:
                          const InputDecoration(hintText: "Street Name"),
                      validator: (street) {
                        return street!.isEmpty ? "*Required" : null;
                      },
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  child: TextFormField(
                    validator: (postCode) {
                      return postCode!.isEmpty ? "*Required" : null;
                    },
                    readOnly: true,
                    controller: controller.postCodeController,
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
                        },
                      );
                    }),
                    const SizedBox(width: 5),
                    const Text("Remember Delivery Details"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return OrderButton(
          enable: !controller.storeOff.value,
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              if (controller.rememberAddress.value) {
                List<String> address = [
                  controller.unitController.text,
                  controller.streetNumberController.text,
                  controller.streetNameController.text,
                  controller.postCodeController.text,
                ];
                SharedPref.saveStringList("now", address);
              } else if (!controller.rememberAddress.value) {
                SharedPref.deleteData("now");
              }
              showCoomonErrorDialog(title: "Success", message: "Order Successful");
              controller.formKey.currentState?.reset();
            }
          },
        );
      }),
    );
  }
}
