import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/module/home/home_controller.dart';
import 'package:pizza/utils/log.dart';

class AppDrawer extends GetView<HomeController> {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.grey400.withOpacity(0.5), // Background color
        child: ListView(
          children: [
            Obx(() {
              return UserAccountsDrawerHeader(
                accountName: Text(controller.userName.value),
                accountEmail: Text(controller
                        .loggedInUserModel.data?.customerMST?.primaryEmail ??
                    ""),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                decoration: BoxDecoration(color: AppColors.grey400),
              );
            }),
            ListTile(
              leading: Icon(Icons.home, color: AppColors.black),
              title: Text('Home', style: TextStyle(color: AppColors.black)),
              onTap: () {},
            ),
            Divider(color: AppColors.white), // Divider color
            ListTile(
              leading: Icon(Icons.restaurant_menu, color: AppColors.black),
              title: Text('Menu', style: TextStyle(color: AppColors.black)),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.local_offer, color: AppColors.black),
              title: Text('Offers', style: TextStyle(color: AppColors.black)),
              onTap: () {
                // Handle offers navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_phone, color: AppColors.black),
              title:
                  Text('Contact Us', style: TextStyle(color: AppColors.black)),
              onTap: () {
                // Handle contact navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: AppColors.black),
              title:
                  Text('Share Log', style: TextStyle(color: AppColors.black)),
              onTap: () {
                AppLogs.shareLogFile();
              },
            ),
          ],
        ),
      ),
    );
  }
}
