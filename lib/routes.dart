import 'package:get/get.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/later/pickup_later_binding.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/now/pickup_now_binding.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/order_pick_up_binding.dart';
import 'package:pizza/module/home/home_binding.dart';
import 'package:pizza/module/menu/menu_binding.dart';
import 'package:pizza/module/offers/offer_binding.dart';
import 'package:pizza/module/offers/offer_view_all.dart';
import 'package:pizza/module/splash/splash_binding.dart';

import 'constants/route_names.dart';
import 'module/delivery_order_type/order_delivery/later/delivery_later_binding.dart';
import 'module/delivery_order_type/order_delivery/now/delivery_now_binding.dart';
import 'module/delivery_order_type/order_delivery/order_delivery_binding.dart';
import 'module/delivery_order_type/order_delivery/order_delivery_options_page.dart';
import 'module/delivery_order_type/order_pickup/order_pickup_options_page.dart';
import 'module/geography/all_active_binding.dart';
import 'module/home/main_page.dart';
import 'module/outlet_details/outlet_shift_details_binding.dart';
import 'module/splash/splash_page.dart';

class RouteGenerator {
  static List<GetPage> routes = [
    GetPage(
      name: RouteNames.initial,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteNames.orderDeliveryOptions,
      page: () => const OrderDeliveryOptionsPage(),
      bindings: [
        OrderDeliveryBinding(),
        DeliveryLaterBinding(),
        DeliveryNowBinding()
      ],
    ),
    GetPage(
      name: RouteNames.orderPickUpOptions,
      page: () => const OrderPickupOptionsPage(),
      bindings: [
        OrderPickUpBinding(),
        PickUpLaterBinding(),
        PickUpNowBinding()
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
      bindings: [
        HomePageBinding(),
        MenuBiding(),
        OfferBinding(),
        OutletShiftDetailsBinding(),
        AllActiveBinding()
      ],
    ),
  ];
}
