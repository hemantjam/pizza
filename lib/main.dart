import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pizza/module/cart/cart_controller.dart';
import 'package:pizza/pizza_app.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 /* Get.put<CartController>(CartController(),
      tag: "cartController", permanent: true);*/
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const PizzaApp());
}
