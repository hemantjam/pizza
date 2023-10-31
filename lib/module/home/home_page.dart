import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
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
import '../menu/menu_page.dart';
import '../offers/offer_item.dart';
import '../order_type/order_type.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  OfferController offerController = Get.find<OfferController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              Header(),
              /* Visibility(
                      visible: controller.showHeader.value,
                      child: const HeaderOptions()),*/
              const Banner(),
              SizedBox(height: 10.sp),
              const MenusPage(),
              SizedBox(height: 10.sp),
              SizedBox(height: 10.sp),
              OfferInfoPage()
            ],
          )),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.h,
      child: Stack(
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            height: 18.h,
            imageUrl: Assets.homeBanner,
            placeholder: (context, url) => SizedBox(
                height: 20.h,
                width: 100.w,
                child: const BlurHash(hash: Assets.homeBannerBlur)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const OrderTYpe()
        ],
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
