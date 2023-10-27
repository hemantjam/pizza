import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/home/home_page.dart';
import 'package:pizza/module/home/home_provider.dart';
import 'package:pizza/module/login/login_page.dart';
import 'package:pizza/module/login/login_provider.dart';
import 'package:pizza/module/menu/menu_provider.dart';
import 'package:pizza/module/splash/splash_page.dart';
import 'package:provider/provider.dart';

import 'module/initial_services/login_by_ip/login_by_ip_provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.initial:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<LoginByIpProvider>(
            create: (BuildContext context) => LoginByIpProvider(),
            child: const SplashPage(),
          ),
        );

      case RouteNames.homePage:
        return CupertinoPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<HomeProvider>(
                  create: (context) => HomeProvider()),
              /*     ChangeNotifierProvider<LoginByIpProvider>(
                  create: (context) => LoginByIpProvider()),*/
              ChangeNotifierProvider<MenuProvider>(
                  create: (context) => MenuProvider()),
            ],
            child: const HomePage(),
          ),
        );
      case RouteNames.login:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<LoginProvider>(
              create: (context) => LoginProvider(), child: const LogInPage()),
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found!'),
            ),
          ),
        );
    }
  }
}
