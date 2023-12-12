import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/cart/cart_page.dart';
import 'package:pizza/module/offers/offer_view_all.dart';
import 'package:pizza/module/user/logged_in_user/logged_in_user_model.dart';

import '../splash/splash_controller.dart';
import 'home_page.dart';

class HomeController extends GetxController {
  RxBool showHeader = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // PageController indicatorController = PageController();
  CarouselController carouselController = CarouselController();

//  LoginController loginController = Get.put(LoginController());
  RxString userName = "".obs;
  SplashController splashController = Get.find<SplashController>();
  LoggedInUserModel loggedInUserModel = Get.find<LoggedInUserModel>();

  @override
  void onInit() {
    super.onInit();
    loggedInUserModel = splashController.loggedInUserModel;
    userName.value = splashController.userName.value;
  }

  final List<Widget> pages = [
    const HomePage(),
    const OfferList(),
    const Page(text: "quick orders will be here"),
    const CartPage()
  ].obs;

  final RxInt currentIndex = 0.obs;
  final RxInt sliderIndex = 0.obs;

  changeSlider(int index) {
    sliderIndex.value = index;
  }

  changeIndex(int index) {
    currentIndex.value = index;
  }

  openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
}

class Page extends StatelessWidget {
  final String text;

  const Page({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
