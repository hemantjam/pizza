import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/cart/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //Get.put(CartController());
  // final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: Get.put(CartController()),
      assignId: true,
      builder: (logic) {
        return SafeArea(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  logic.checkForOfflineData();
                },
              ),
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Text(logic.cartItemsList.length.toString()),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              body: Obx(() {
                return logic.cartItemsList.isNotEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: logic.cartItemsList.entries
                            .map((e) => ListTile(
                                  title: Text(e.key),
                                  trailing: Text(e.value!.id.toString()),
                                ))
                            .toList())
                    : Center(
                        child: Text("Cart is empty"),
                      );
              })

              /* body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.grey.shade900,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "You'll need to add more to your cart. Minimum Delivery is \$18",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.grey,
                    ),
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.blueGrey),
                            child: const Text(
                              'Your Cart has: 0 Items',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            color: Colors.orange,
                            height: 5,
                            width: 100.w,
                          ),
                          const SizedBox(height: 10),
                          const Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  size: 150,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'YOUR CART IS EMPTY',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Please add some items from the menu or offers',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                border: Border.all(color: Colors.black),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(1, 1),
                                      color: Colors.grey,
                                      spreadRadius: 5,
                                      blurRadius: 10)
                                ]),
                            padding: const EdgeInsets.all(10),
                            child: const Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('Delivery Charge'),
                                    Text('\$ 4.00'),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$ 4.00',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Handle Checkout
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      'CHECKOUT',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),*/
              ),
        );
      },
    );
  }
}
