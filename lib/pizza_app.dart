import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/constants/app_strings.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/routes.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class PizzaApp extends StatelessWidget {
  const PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
       // smartManagement: SmartManagement.,
        title: AppStrings.appTitle,
        theme: ThemeData(
            primarySwatch: AppColors.primaryColor,
            appBarTheme: AppBarTheme(backgroundColor: AppColors.white),
            scaffoldBackgroundColor: AppColors.white),
        getPages: RouteGenerator.routes,
        initialRoute: RouteNames.initial,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
