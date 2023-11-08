import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/now/pickup_now_controller.dart';
import 'package:pizza/module/delivery_order_type/widgets/order_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/common_dialog.dart';

class PickUpNowPage extends GetView<PickUpNowController> {
  const PickUpNowPage({super.key});

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
                Obx(() {
                  return controller.storeOff.value
                      ? Text(
                          "Please Note : Store is closed currently , please select another time",
                          style: TextStyle(color: AppColors.red),
                        )
                      : const SizedBox();
                }),
                const SizedBox(height: 15),
                Text(
                  "Outlet Address",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
                            hintText: controller.outletAddress.value),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => controller
                      .launchMapWithAddress(controller.outletAddress.value),
                  child: Image.asset(
                    Assets.mapPlaceHolder,
                    height: 50.h,
                    width: 100.w,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return OrderButton(
          enable: !controller.storeOff.value,
          onTap: () {
            showErrorDialog(title: "Success", message: "Order Successful");
          },
        );
      }),
    );
  }
}
