import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/module/user/login/login_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/route_names.dart';
import 'drawer/drawer.dart';
import 'home_controller.dart';

class MainPage extends GetView<HomeController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                GetBuilder<LoginController>(
                    init: Get.put(LoginController()),
                    builder: (LoginController loginController) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteNames.login);
                        },
                        child: Center(
                            child: Row(
                          children: [
                           // Text("${controller.userName.value}"),
                            loginController.userName.value.isNotEmpty
                                ? Row(
                                    children: [
                                      const Icon(Icons.person),
                                      Text(loginController.userName.value)
                                    ],
                                  )
                                : const Text("Sign in",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                    )),
                          ],
                        )),
                      );
                    })
              ],
            ),
          ),
          key: controller.scaffoldKey,
          drawer: const AppDrawer(),
          body: Obx(() {
            return IndexedStack(
                index: controller.currentIndex.value,
                children: controller.pages);
          }),
          bottomNavigationBar: const Row(
            children: <Widget>[
              BottomTabBarItem(index: 0, image: Assets.logoPng, label: "Home"),
              BottomTabBarItem(
                  index: 1, image: Assets.bottomOffer, label: 'Offer'),
              BottomTabBarItem(
                  index: 2, image: Assets.bottomQuick, label: 'Quick Orders'),
              BottomTabBarItem(
                  index: 3, image: Assets.bottomCart, label: 'Cart'),
            ],
          )),
    );
  }
}

class BottomTabBarItem extends GetView<HomeController> {
  final int index;
  final String label;
  final String image;

  const BottomTabBarItem({
    super.key,
    required this.index,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GestureDetector(
          onTap: () {
            controller.changeIndex(index);
          },
          child: Container(
            height: 8.h,
            width: 25.w,
            padding: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: controller.currentIndex.value == index
                  ? AppColors.lightOrange
                  : AppColors.white, // Change the tab color
              borderRadius: BorderRadius.all(Radius.circular(3.sp)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                index == 0
                    ? Image.asset(
                        image,
                        height: 24.sp,
                        width: 24.sp,
                      )
                    : SvgPicture.asset(
                        image,
                        height: 24.sp,
                        width: 24.sp,
                      ),
                const SizedBox(height: 5),
                Text(
                  label,
                  style: TextStyle(color: AppColors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
