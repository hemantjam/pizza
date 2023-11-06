import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/widgets/common_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../searchable_list.dart';
import 'delivery_now_controller.dart';

class DeliveryNowPage extends GetView<DeliveryNowController> {
  const DeliveryNowPage({super.key});

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
              children: [
                /// if store is close
                /*Text(
                  "Please Note : Store is closed currently , please select another time",
                  style: TextStyle(color: AppColors.red),
                ),*/
                const SizedBox(
                  height: 15,
                ),
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
                Card( elevation: 0,
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
                  List<SingleGeographyModel> streetList=controller.streetList!
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

                     //   controller.toggleExpand();

                        controller.postCode.value = item.parentGeographyMst
                                ?.parentGeographyMst?.geographyName ??
                            "";
                      }
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
                    /*trailing: Icon(controller.isStreetNameExpand.value
                        ? Icons.arrow_drop_up
                        : Icons.keyboard_arrow_down),*/
                    shape: Border(
                      bottom: BorderSide(color: Colors.grey.shade800),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Obx(() {
                  return Card(
                    child: TextFormField(
                      readOnly: true,
                      controller: controller.postCodeController,
                      focusNode: controller.postCodeFocus,
                      decoration:
                          InputDecoration(hintText: controller.postCode.value),
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
      bottomNavigationBar: GestureDetector(
        onTap: (){
          if(controller.formKey.currentState!.validate()){
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
