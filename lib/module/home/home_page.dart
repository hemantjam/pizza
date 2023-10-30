import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/home/home_controller.dart';
import 'package:pizza/module/offers/offer_controller.dart';
import 'package:pizza/module/offers/offer_info_page.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/header.dart';
import '../menu/menu.dart';
import '../offers/offer_item.dart';

class HomePage extends GetView<HomeController> {
   HomePage({super.key});
OfferController offerController=Get.find<OfferController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SingleChildScrollView(
          primary: true,
          child: Obx(() => Column(
                children: [
                  Header(controller: controller),
                  Visibility(
                      visible: controller.showHeader.value,
                      child: const HeaderOptions()),
                  const Banner(),
                  SizedBox(height: 10.sp),
                  const Menus(),
                  SizedBox(height: 10.sp),

                  SizedBox(height: 10.sp),
                  OfferInfoPage()

                ],
              ))),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16.h,
      child: Stack(
        children: [
          Image.network(
            "https://tomcat.harvices.com/pizza_portal_v2_demo/static/media/banner.7c1966eb.jpg",
            fit: BoxFit.cover,
            height: 12.h,
          ),
          const DeliveryOptions()
        ],
      ),
    );
  }
}

class DeliveryOptions extends StatelessWidget {
  const DeliveryOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),

        child: IntrinsicHeight(
          child: Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            Assets.orderDeliveryPng,
                            height: 24.sp,
                            width: 24.sp,
                          ),
                          SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "ORDER",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "DELIVERY",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(color: Colors.black, width: 1),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.sp),
                          bottomRight: Radius.circular(8.sp),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            Assets.orderPickupPng,
                            height: 24.sp,
                            width: 24.sp,
                          ),
                          SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "ORDER",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "PICK-UP",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderOptions extends StatelessWidget {
  const HeaderOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("HOME"),
        const Text("MENU"),
        const Text("OFFERS"),
        const Text("CONTACT US"),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.login);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sign-In"),
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
