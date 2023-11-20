import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';
import '../constants/assets.dart';
import '../module/home/home_controller.dart';

class Header extends GetView<HomeController> {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.sp,
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.sp),
              height: 30.sp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                color: AppColors.black,
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
