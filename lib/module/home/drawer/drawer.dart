import 'package:flutter/material.dart';
import 'package:pizza/constants/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.grey400.withOpacity(0.5), // Background color
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('johndoe@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              decoration: BoxDecoration(color: AppColors.grey400),
            ),
            ListTile(
              leading: Icon(Icons.home, color: AppColors.black),
              // Icon color
              title: Text('Home', style: TextStyle(color: AppColors.black)),
              // Text color
              onTap: () {
                // Handle home navigation
              },
            ),
            Divider(color: AppColors.white), // Divider color
            ListTile(
              leading: Icon(Icons.restaurant_menu, color: AppColors.black),
              title: Text('Menu', style: TextStyle(color: AppColors.black)),
              onTap: () {
                // Handle menu navigation
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
          ],
        ),
      ),
    );
  }
}
