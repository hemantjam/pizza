import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/now/pickup_now_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';

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
                 Text(
                  "Please Note : Store is closed currently , please select another time",
                  style: TextStyle(color: AppColors.red),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Outlet Address",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Card(
                  child: TextFormField(
                    controller: controller.outletAddController,
                    decoration: const InputDecoration(hintText: "Outlet Address"),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap:()=> controller.launchMapWithLocation(),
                  child: Image.asset(
                    Assets.mapPlaceHolder,
                    height: 40.h,
                    width: 100.w,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
              /*  Row(
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
