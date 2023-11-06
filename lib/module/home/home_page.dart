import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/module/home/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/header.dart';
import '../delivery_order_type/delivery_order_type_optios.dart';
import '../menu/menu_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              const Header(),
              const Banner(),
              //SizedBox(height: 5.sp),
              const OrderDeliveryTypeOption(),
              SizedBox(height: 10.sp),
               const MenusPage(),
             // SizedBox(height: 10.sp),
           //   SizedBox(height: 10.sp),
             // const MenuBannerItem()
              //  const OfferInfoPage()
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
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        height: 18.h,
        imageUrl: Assets.homeBanner,
        placeholder: (context, url) => SizedBox(
            height: 20.h,
            width: 100.w,
            child: const BlurHash(hash: Assets.homeBannerBlur)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
