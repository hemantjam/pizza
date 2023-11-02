import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/module/home/drawer/drawer.dart';
import 'package:sizer/sizer.dart';

import 'home_controller.dart';

class MainPage extends GetView<HomeController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: controller.scaffoldKey,
          drawer: const AppDrawer(),
          body: Obx(() {
            return IndexedStack(
                index: controller.currentIndex.value,
                children: controller.pages);
          }),
          bottomNavigationBar: const Row(
            children: <Widget>[
              BottomTabBarItem(
                  index: 0, image: Assets.logoPng, label: "Pippo's\n Pizza"),
              BottomTabBarItem(
                  index: 1,
                  image: Assets.bottomBuildYourPizza,
                  label: 'Build your\n own'),
              BottomTabBarItem(
                  index: 2,
                  image: Assets.bottomHalfHalf,
                  label: 'Half &\n Half'),
              BottomTabBarItem(
                  index: 3, image: Assets.bottomQuick, label: 'Quick\n Orders'),
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
    return Obx(() {
      return GestureDetector(
          onTap: () {
            controller.changeIndex(index);
          },
          child: Container(
            height: 10.h,
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
                Text(
                  label,
                  style: TextStyle(
                    color: controller.currentIndex.value == index
                        ? AppColors.white
                        : AppColors.black,
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
