import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:get/get.dart';

import 'home_page.dart';

class HomeController extends GetxController {
  RxBool showHeader = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> pages = [
    HomePage(),
    Page(text: "build your pizza page will be here"),
    Page(text: "half and half page will be here"),
    Page(text: "quick orders will be here"),
  ].obs;

  final RxInt currentIndex = 0.obs;

 openDrawer(){
   scaffoldKey.currentState?.openDrawer();

 }
}

class Page extends StatelessWidget {
  final String text;

  const Page({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(text),
      ),
    );
  }
}
