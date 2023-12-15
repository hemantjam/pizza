import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/cart/cart_controller.dart';

Container cartDetailsBottomBar(
    CartController cartController, bool index, bool inCart, Function() onTap) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 2),
    height: 75,
    decoration: const BoxDecoration(color: Color(0xffEEEEEE)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: buildStyleFrom(186, 44),
            onPressed: () {
              inCart ? null : Get.toNamed(RouteNames.cartPage);
            },
            child: Row(
              children: [
                Obx(() {
                  return Text(
                    "${cartController.cartItems.length.toString()} items",
                    style: buildButtonTextStyle(),
                  );
                }),
                const Spacer(),
                Text(
                  " \$${cartController.cartItems.fold(0, (previousValue, element) => previousValue + element.total)}",
                  style: buildButtonTextStyle(),
                ),
              ],
            )),
        ElevatedButton(
            style: buildStyleFrom(126, 44),
            onPressed: () {
              onTap();
            },
            child: Row(
              children: [
                Text(
                  index ? "Checkout" : "next",
                  style: buildButtonTextStyle(),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward)
              ],
            )),
      ],
    ),
  );
}

TextStyle buildButtonTextStyle() => const TextStyle(fontSize: 16);

ButtonStyle buildStyleFrom(double width, double height) {
  return ElevatedButton.styleFrom(fixedSize: Size(width, height), elevation: 1);
}
