import 'package:flutter/material.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/splash/splash_page.dart';
import 'package:pizza/routes.dart';
import 'package:sizer/sizer.dart';

import 'module/home/home_page.dart';

class PizzaApp extends StatelessWidget {
  const PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
        initialRoute: RouteNames.initial,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
