import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/assets.dart';
import '../module/home/home_controller.dart';

class Header extends GetView<HomeController> {
  const Header({
    super.key,
   // required this.controller,
  });

  //final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.sp,
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.sp),
              height: 30.sp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: controller.openDrawer,
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.menu,
                        height: 24.sp,
                        width: 24.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.cart,
                        height: 24.sp,
                        width: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
              child: Image.asset(Assets.logoPng, height: 60.sp, width: 57.sp))
        ],
      ),
    );
  }
}
