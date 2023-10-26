import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/home/home_page.dart';
import 'package:pizza/module/home/home_provider.dart';
import 'package:pizza/module/login/login_page.dart';
import 'package:pizza/module/login/login_provider.dart';
import 'package:pizza/module/splash/splash_page.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.initial:
        return CupertinoPageRoute(builder: (_) => const SplashPage());

      case RouteNames.homePage:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<HomeProvider>(
              create: (context) => HomeProvider(), child: HomePage()),
        );
      case RouteNames.login:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<LoginProvider>(
              create: (context) => LoginProvider(), child: LogInPage()),
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
