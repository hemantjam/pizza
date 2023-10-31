import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/module/home/drawer/drawer.dart';
import 'package:pizza/widgets/common_dialog.dart';
import 'package:sizer/sizer.dart';

import 'home_controller.dart';

class MainPage extends GetView<HomeController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        drawer: AppDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showErrorDialog(title: "testing", message: "testing");
          },
        ),
        body: Obx(() => controller.pages[controller.currentIndex.value]),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              //backgroundColor: Colors.red,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              showUnselectedLabels: true,
              selectedItemColor: AppColors.lightOrange,
              unselectedItemColor: Colors.grey,
              currentIndex: controller.currentIndex.value,
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      Assets.logoPng,
                      height: 24.sp,
                      width: 24.sp,
                    ),
                    label: "Pippo's\n pizza"),
                buildBottomNavigationBarItem(
                    Assets.bottomBuildYourPizza, 'Build your\n own'),
                buildBottomNavigationBarItem(
                    Assets.bottomHalfHalf, 'Half &\n Half'),
                buildBottomNavigationBarItem(
                    Assets.bottomQuick, 'Quick\n Orders'),
              ],
              onTap: (index) => controller.currentIndex.value = index,
            )),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      String image, String label) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(image, height: 24.sp, width: 24.sp),
        label: label);
  }
}
