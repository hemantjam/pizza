import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';
import 'later/delivery_later_page.dart';
import 'now/delivery_now_page.dart';
import 'order_delivery_controller.dart';

class OrderDeliveryOptionsPage extends StatefulWidget {
  const OrderDeliveryOptionsPage({super.key});

  @override
  State<OrderDeliveryOptionsPage> createState() =>
      _OrderDeliveryOptionsPageState();
}

class _OrderDeliveryOptionsPageState extends State<OrderDeliveryOptionsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  OrderDeliveryController deliveryController =
      Get.find<OrderDeliveryController>();

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
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_sharp),
                onPressed: () {
                  Get.back();
                },
              ),
              elevation: 0,
              title: const Text("Enter Delivery Details"),
            ),
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
                    DeliveryNowPage(),
                    DeliveryLaterPage(),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
