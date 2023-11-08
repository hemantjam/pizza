import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/order_pick_up_controller.dart';
import 'package:sizer/sizer.dart';

import 'later/pickup_later_page.dart';
import 'now/pickup_now_page.dart';

class OrderPickupOptionsPage extends StatefulWidget {
  const OrderPickupOptionsPage({super.key});

  @override
  State<OrderPickupOptionsPage> createState() => _OrderPickupOptionsPageState();
}

class _OrderPickupOptionsPageState extends State<OrderPickupOptionsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  OrderPickUpController deliveryController = Get.find<OrderPickUpController>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
          title: const Text("Enter Pick-Up Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                child: IntrinsicHeight(
                  child: Card(
                    elevation: 3,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              deliveryController.changeIndex(0);
                            },
                            child: Obx(() {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: deliveryController.index.value == 0
                                      ? AppColors.lightOrange
                                      : AppColors.white, // Change the tab color
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.sp)),
                                ),
                                child: Text(
                                  "NOW",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              deliveryController.changeIndex(1);
                            },
                            child: Obx(() {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: deliveryController.index.value == 1
                                      ? AppColors.lightOrange
                                      : AppColors.white, // Change the tab color
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.sp)),
                                ),
                                child: Text(
                                  "LATER",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  return IndexedStack(
                    index: deliveryController.index.value,
                    children: const [
                      PickUpNowPage(),
                      PickUpLaterPage(),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
