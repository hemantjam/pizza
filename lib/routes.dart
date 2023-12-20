import 'package:get/get.dart';
import 'package:pizza/module/cart/cart_binding.dart';
import 'package:pizza/module/cart/cart_page.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/later/pickup_later_binding.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/now/pickup_now_binding.dart';
import 'package:pizza/module/delivery_order_type/order_pickup/order_pick_up_binding.dart';
import 'package:pizza/module/home/home_binding.dart';
import 'package:pizza/module/menu/customize/customize_page.dart';
import 'package:pizza/module/menu/home_page_list/menu_binding.dart';
import 'package:pizza/module/offers/offer_binding.dart';
import 'package:pizza/module/offers/offer_view_all.dart';
import 'package:pizza/module/splash/splash_binding.dart';
import 'package:pizza/module/user/forgot_password/forgot_pass_binding.dart';
import 'package:pizza/module/user/login/login_binding.dart';
import 'package:pizza/module/user/login/login_page.dart';

import 'constants/route_names.dart';
import 'module/delivery_order_type/order_delivery/later/delivery_later_binding.dart';
import 'module/delivery_order_type/order_delivery/now/delivery_now_binding.dart';
import 'module/delivery_order_type/order_delivery/order_delivery_binding.dart';
import 'module/delivery_order_type/order_delivery/order_delivery_options_page.dart';
import 'module/delivery_order_type/order_pickup/order_pickup_options_page.dart';
import 'module/geography/all_active_binding.dart';
import 'module/home/main_page.dart';
import 'module/menu/customize/customize_binding.dart';
import 'module/menu/menu_details_list/all_menu_page.dart';
import 'module/menu/menu_details_list/menu_details_binding.dart';
import 'module/outlet_details/outlet/outlet_binding.dart';
import 'module/outlet_details/shift/outlet_shift_details_binding.dart';
import 'module/splash/splash_page.dart';
import 'module/user/forgot_password/forgot_password_page.dart';
import 'module/user/register/register.dart';
import 'module/user/register/register_binding.dart';

class RouteGenerator {
  static List<GetPage> routes = [
    /// splash
    GetPage(
      name: RouteNames.initial,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),

    /// OrderDeliveryOptionsPage
    GetPage(
      name: RouteNames.orderDeliveryOptions,
      page: () => const OrderDeliveryOptionsPage(),
      bindings: [
        OrderDeliveryBinding(),
        DeliveryLaterBinding(),
        DeliveryNowBinding()
      ],
    ),

    /// OrderPickupOptionsPage
    GetPage(
      name: RouteNames.orderPickUpOptions,
      page: () => const OrderPickupOptionsPage(),
      bindings: [
        OrderPickUpBinding(),
        PickUpLaterBinding(),
        PickUpNowBinding()
      ],
    ),

    /// OfferList
    GetPage(
      name: RouteNames.offerList,
      page: () => const OfferList(),
      binding: OfferBinding(),
    ),

    /// sign in
    GetPage(
      name: RouteNames.login,
      page: () => const LogInPage(),
      binding: LoginBinding(),
    ),

    /// forgot password
    GetPage(
      name: RouteNames.forgotPass,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPassBinding(),
    ),

    /// register
    GetPage(
      name: RouteNames.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),

    /// customize pizza
    GetPage(
        name: RouteNames.customizePizza,
        page: () => const CustomizePizzaPage(),
        binding: CustomizePizzaBinding(),
        arguments: Get.arguments),

    /// cart
    GetPage(
      name: RouteNames.cartPage,
      page: () => CartPage(),
      binding: CartBinding(),
    ),

    /// MainPage
    GetPage(
      name: RouteNames.homePage,
      page: () => const MainPage(),
      bindings: [

        HomePageBinding(),
        MenuBiding(),
        OfferBinding(),
        OutletShiftDetailsBinding(),
        AllActiveBinding(),
        OutletBinding(), CartBinding(),
      ],
    ),

    /// pizza menu page
    GetPage(
        name: RouteNames.pizzaMenuPage,
        page: () => AllMenuPage(),
        binding: MenuDetailsBinding(),
        arguments: Get.arguments)
  ];
}
