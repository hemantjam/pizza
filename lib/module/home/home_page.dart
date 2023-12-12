import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/module/home/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/route_names.dart';
import '../../widgets/header.dart';
import '../delivery_order_type/delivery_order_type_options.dart';
import '../menu/home_page_list/menu_page.dart';
import 'drawer/drawer.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: const AppDrawer(),
      //key: controller.scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: controller.openDrawer,
              child: Center(
                child: SvgPicture.asset(
                  Assets.menu,
                  height: 24.sp,
                  width: 24.sp,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.userName.value != ""
                    ? controller.scaffoldKey.currentState?.openDrawer()
                    : Get.toNamed(RouteNames.login);
              },
              child: Center(
                  child: Row(
                children: [
                  controller.userName.value.isNotEmpty
                      ? Row(
                          children: [
                            const Icon(Icons.person),
                            Text(controller.userName.value)
                          ],
                        )
                      : const Text("Sign in",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                          )),
                ],
              )),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            primary: true,
            child: Column(
              children: [
                const Header(),
                const CustomSlider(),
                const OrderDeliveryTypeOption(),
                SizedBox(height: 10.sp),
                const MenusPage(),
              ],
            )),
      ),
    );
  }
}

class CustomSlider extends GetView<HomeController> {
  const CustomSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      width: 100.w,
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: controller.carouselController,
            options: CarouselOptions(
              onPageChanged: (int index, value) {
                controller.changeSlider(index);
              },
              autoPlayInterval: const Duration(seconds: 5),
              autoPlay: false,
              height: 25.h,
              aspectRatio: 1,
              viewportFraction: 1,
            ),
            items: [1, 2, 3, 4].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: Assets.homeBanner,
                          placeholder: (context, url) => const SizedBox(
                              child: BlurHash(hash: Assets.homeBannerBlur)),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          /*Obx(() {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: AnimatedSmoothIndicator(
                  activeIndex: controller.sliderIndex.value,
                  count: 4,
                  effect: WormEffect(
                    dotColor: Colors.grey.shade100,
                    activeDotColor: Colors.black,
                  ),
                ),
              ),
            );
          })*/
        ],
      ),
    );
  }
}

/*class Banner extends StatelessWidget {
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
}*/
