import 'package:get/get.dart';
import 'package:pizza/module/home/home_binding.dart';
import 'package:pizza/module/menu/menu_binding.dart';
import 'package:pizza/module/offers/offer_binding.dart';
import 'package:pizza/module/offers/offer_view_all.dart';
import 'package:pizza/module/splash/splash_binding.dart';

import 'constants/route_names.dart';
import 'module/home/home_page.dart';
import 'module/home/main_page.dart';
import 'module/splash/splash_page.dart';

class RouteGenerator {
  static List<GetPage> routes = [
    GetPage(
      name: RouteNames.initial,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteNames.offerList,
      page: () => OfferList(),
      binding:  OfferBinding(),
    ),
    GetPage(
      name: RouteNames.homePage,
      page: () => MainPage(),
      bindings: [
        HomePageBinding(),
        MenuBiding(),
        OfferBinding()
      ],
    ),


    /* GetPage(
      name: RouteNames.homePage,
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),*/
    /*  GetPage(
      name: RouteNames.login,
      page: () => LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),*/
  ];
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/home/home_page.dart';
import 'package:pizza/module/home/home_controller.dart';
import 'package:pizza/module/login/login_page.dart';
import 'package:pizza/module/login/login_provider.dart';
import 'package:pizza/module/menu/menu_controller.dart';
import 'package:pizza/module/splash/splash_page.dart';
import 'package:provider/provider.dart';

import 'module/initial_services/login_by_ip/login_by_ip_provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.initial:
        return CupertinoPageRoute(
          builder: (_) => GetPage(name: RouteNames.initial, page: SplashPage())
        );

      case RouteNames.homePage:
        return CupertinoPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<HomeController>(
                  create: (context) => HomeController()),
              */
/*     ChangeNotifierProvider<LoginByIpProvider>(
                  create: (context) => LoginByIpProvider()),*/ /*

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
*/
