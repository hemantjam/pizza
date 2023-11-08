import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/offers/offer_view_all.dart';

import 'home_page.dart';

class HomeController extends GetxController {
  RxBool showHeader = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PageController indicatorController=PageController();
  CarouselController carouselController=CarouselController();

  final List<Widget> pages = [
    HomePage(),
    OfferList(),
    const Page(text: "half and half page will be here"),
    const Page(text: "quick orders will be here"),
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
