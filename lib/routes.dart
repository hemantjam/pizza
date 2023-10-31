import 'package:get/get.dart';
import 'package:pizza/module/home/home_binding.dart';
import 'package:pizza/module/menu/menu_binding.dart';
import 'package:pizza/module/offers/offer_binding.dart';
import 'package:pizza/module/offers/offer_view_all.dart';
import 'package:pizza/module/splash/splash_binding.dart';

import 'constants/route_names.dart';
import 'module/home/home_page.dart';
import 'module/home/main_page.dart';
import 'module/order_type/order_delivery/later/order_delivery_later_binding.dart';
import 'module/order_type/order_delivery/now/order_delivery_now_binding.dart';
import 'module/order_type/order_delivery/order_delivery_page.dart';
import 'module/order_type/order_delivery/order_delivery_binding.dart';
import 'module/splash/splash_page.dart';

class RouteGenerator {
  static List<GetPage> routes = [
    GetPage(
      name: RouteNames.initial,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteNames.deliveryType,
      page: () => DeliveryDetails(),
      bindings: [
        DeliveryBinding(),
        OrderDeliveryLaterBinding(),
        OrderDeliveryNowBinding()
      ],
    ),
    GetPage(
      name: RouteNames.offerList,
      page: () => const OfferList(),
      binding: OfferBinding(),
    ),
    GetPage(
      name: RouteNames.homePage,
      page: () => const MainPage(),
      bindings: [HomePageBinding(), MenuBiding(), OfferBinding()],
    ),
  ];
}
