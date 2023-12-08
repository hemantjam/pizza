import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/cart/cart_controller.dart';
import 'package:sizer/sizer.dart';

import '../menu/by_group_code/menu_by_group_code_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: Get.put(CartController()),
      assignId: true,
      builder: (logic) {
        logic.checkForOfflineData();
        return SafeArea(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.refresh),
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
                    icon: Text(logic.cartItems.length.toString()),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              body: Obx(() {
                return logic.cartItems.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                            children: logic.cartItems.asMap().entries.map((e) {
                          RecipeDetailsModel? model =
                              logic.cartItemsList[e.key];
                          return CartItemDetails(
                            image: model?.image ?? "",
                            selectedSize: e.value.selectedSize,
                            selectedBase: e.value.selectedBase,
                            total: e.value.total,
                            quantity: e.value.itemQuantity,
                            name: e.value.itemName,
                          );
                        }).toList()),
                      )
                    : const Center(
                        child: Text("Cart is empty"),
                      );
              })),
        );
      },
    );
  }
}

class CartItemDetails extends StatefulWidget {
  final String image;
  final String selectedBase;
  final String selectedSize;
  final String name;
  final int quantity;
  final int total;

  const CartItemDetails(
      {super.key,
      required this.image,
      required this.selectedSize,
      required this.selectedBase,
      required this.total,
      required this.quantity,
      required this.name});

  @override
  State<CartItemDetails> createState() => _CartItemDetailsState();
}

class _CartItemDetailsState extends State<CartItemDetails> {
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 12.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.image, scale: 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.selectedSize} | ${widget.selectedBase}",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QuantitySelector(
                                onTap: (quantity) {
                                  log("$quantity");
                                },
                                defaultQuantity: widget.quantity,
                              ),
                            ),
                            Text("\$${widget.total}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  visibility = !visibility;
                });
              },
              child: Row(
                children: [
                  Icon(visibility
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_down),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    "Toppings (4)",
                    style: TextStyle(fontSize: 14.sp),
                  )),
                  const Text("00.00")
                ],
              ),
            ),
            Visibility(
                visible: !visibility,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text("ham"),
                      trailing: QuantitySelector(
                        defaultQuantity: 1,
                        onTap: (quantity) {},
                      ),
                    ),
                    ListTile(
                      title: const Text("ham"),
                      trailing: QuantitySelector(
                        defaultQuantity: 1,
                        onTap: (quantity) {},
                      ),
                    ),
                    ListTile(
                      title: const Text("ham"),
                      trailing: QuantitySelector(
                        defaultQuantity: 1,
                        onTap: (quantity) {},
                      ),
                    ),
                    ListTile(
                      title: const Text("ham"),
                      trailing: QuantitySelector(
                        defaultQuantity: 1,
                        onTap: (quantity) {},
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class QuantitySelector extends StatefulWidget {
  const QuantitySelector(
      {super.key, required this.onTap, required this.defaultQuantity});

  final Function(int value) onTap;
  final int defaultQuantity;

  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;

  void increaseQuantity() {
    setState(() {
      quantity++;
      widget.onTap(quantity);
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget.onTap(quantity);
      });
    }
  }

  @override
  void initState() {
    quantity = widget.defaultQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: decreaseQuantity,
          child: Icon(Icons.delete_outline, size: 18.sp, color: Colors.red),
        ),
        const SizedBox(width: 5),
        Text(
          quantity.toString(),
          style: TextStyle(fontSize: 14.sp),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: increaseQuantity,
          child: Icon(Icons.add, size: 18.sp, color: Colors.green),
        ),
      ],
    );
  }
}
