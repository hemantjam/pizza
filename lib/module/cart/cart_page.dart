import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/local_storage/entity/cart_items_entity.dart';
import 'package:pizza/module/cart/cart_controller.dart';
import 'package:pizza/module/cart/model/order_master/order_master_create_model.dart';
import 'package:pizza/module/cart/utils/handle_checkout.dart';
import 'package:pizza/module/cart/widget/cart_details_bottom_bar.dart';
import 'package:pizza/module/menu/customize/local_toppings_module.dart';
import 'package:pizza/widgets/common_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../constants/route_names.dart';
import '../menu/by_group_code/menu_by_group_code_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: Get.put(CartController()),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
                bottomNavigationBar: cartDetailsBottomBar(true, true, () {
                  final orderMasterCreateModel =
                      Get.find<OrderMasterCreateModel>(
                          tag: "orderMasterCreateModel");
                  CheckOut.cartUpdate(orderMasterCreateModel);
                }, controller.cartItemsLength, controller.cartTotal),
                appBar: AppBar(
                  elevation: 0,
                  title: const Text(
                    'Cart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: Obx(() {
                  return controller.cartItems.isNotEmpty
                      ? SingleChildScrollView(
                          key: UniqueKey(),
                          child: Column(
                              children:
                                  controller.cartItems.asMap().entries.map((e) {
                            String toppingsJsonString = e.value.toppings;
                            List<dynamic> toppingsJsonList =
                                jsonDecode(toppingsJsonString);
                            List<ToppingsSelection> selectedToppingsList =
                                toppingsJsonList
                                    .map((toppingJson) =>
                                        ToppingsSelection.fromJson(toppingJson))
                                    .toList();
                            /*TestRecipeDetailsModel? model =
                              TestRecipeDetailsModel.fromJson(
                                  jsonDecode(e.value.itemModel));*/
                            RecipeDetailsModel? modell =
                                RecipeDetailsModel.fromJson(
                                    jsonDecode(e.value.itemModel));
                            return modell != null
                                ? CartItemDetails(
                                    entity: e.value,
                                    recipeDetailsModel: modell,
                                    toppings: selectedToppingsList,
                                    image: modell.image ?? "",
                                    selectedSize: e.value.selectedSize,
                                    selectedBase: e.value.selectedBase,
                                    total: e.value.total,
                                    quantity: e.value.itemQuantity,
                                    name: e.value.itemName,
                                    onDelete: (value) {
                                      value
                                          ? controller.deleteData(e.value)
                                          : null;
                                    })
                                : const SizedBox();
                          }).toList()),
                        )
                      : const Center(
                          child: Text("Cart is empty"),
                        );
                })),
          );
        });
  }
}

class CartItemDetails extends StatefulWidget {
  final CartItemsEntity entity;
  final RecipeDetailsModel? recipeDetailsModel;
  final String image;
  final String selectedBase;
  final String selectedSize;
  final String name;
  final int quantity;
  final int total;
  final List<ToppingsSelection> toppings;
  final Function(bool) onDelete;

  const CartItemDetails({
    super.key,
    required this.entity,
    required this.recipeDetailsModel,
    required this.onDelete,
    required this.toppings,
    required this.image,
    required this.selectedSize,
    required this.selectedBase,
    required this.total,
    required this.quantity,
    required this.name,
  });

  @override
  State<CartItemDetails> createState() => _CartItemDetailsState();
}

class _CartItemDetailsState extends State<CartItemDetails> {
  bool visibility = true;
  double toppingsTotal = 0;
  List<ToppingsModel>? toppingList = [];

  CartController cartController = Get.find<CartController>();
  late int defaultQuantity;

  double? get toppingsT {
    return toppingList
        ?.where((element) => element.itemQuantity! >= 1)
        .fold<double?>(
      0,
      (previousValue, element) {
        final itemQuantity = element.itemQuantity?.ceil() ?? 0;
        final addCost = element.addCost?.ceil() ?? 0;
        final defaultQuantity = element.defaultQuantity?.ceil() ?? 0;

        if (defaultQuantity > 0) {
          // Subtract defaultQuantity from itemQuantity before multiplying with addCost
          return (previousValue ?? 0) +
              (addCost * (itemQuantity - defaultQuantity));
        } else {
          // If defaultQuantity is zero, use itemQuantity * addCost directly
          return (previousValue ?? 0) + (addCost * itemQuantity);
        }
      },
    );
  }

  getToppings() {
    toppingList = widget.selectedSize.isNotEmpty
        ? widget.recipeDetailsModel?.recipes
                ?.where((element) => element.size?.name == widget.selectedSize)
                .firstOrNull
                ?.toppings ??
            []
        : widget.recipeDetailsModel?.recipes?.firstOrNull?.toppings ?? [];
  }

  @override
  void initState() {
    super.initState();
    toppingsTotal = widget.toppings
        .fold(0.0, (sum, topping) => sum + (topping.addCost ?? 0.0));
    defaultQuantity = widget.quantity;
    getToppings();
  }

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
                        widget.selectedSize.isNotEmpty
                            ? Text(
                                "${widget.selectedSize} | ${widget.selectedBase}",
                                style: TextStyle(fontSize: 14.sp),
                              )
                            : const SizedBox(),
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
                                  if (quantity == 0) {
                                    widget.onDelete(true);
                                  }
                                  setState(() {
                                    cartController.updateTotal(
                                        widget.entity.id!, quantity);
                                    //cartController.cartItems.where((p0) => p0.id==).first.total=
                                    //log("------${cartController.cartItems.where((p0) => p0.id==widget.entity.id).first.total}");
                                    defaultQuantity = quantity;
                                  });
                                },
                                defaultQuantity: widget.quantity,
                              ),
                            ),
                            Text(
                                "\$${(widget.total + (toppingsT?.ceil() ?? 0)) * defaultQuantity}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            widget.toppings.isNotEmpty
                ? GestureDetector(
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
                          "Toppings (${widget.toppings.length})",
                          style: TextStyle(fontSize: 14.sp),
                        )),
                        Text(toppingsT.toString())
                      ],
                    ),
                  )
                : const SizedBox(),
            Visibility(
                visible: !visibility,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: toppingList != null && toppingList!.isNotEmpty
                      ? toppingList!
                          .asMap()
                          .entries
                          .map(
                            (e) => e.value.itemQuantity != null &&
                                    e.value.itemQuantity!.ceil() > 0
                                ? ListTile(
                                    title: Text(e.value.name ?? ""),
                                    trailing: QuantitySelector(
                                      maxQuantity:
                                          e.value.maximumQuantity?.ceil(),
                                      defaultQuantity:
                                          e.value.itemQuantity?.ceil() ?? 0,
                                      onTap: (quantity) {
                                        setState(() {
                                          if (quantity == 0 &&
                                              toppingList![e.key]
                                                      .defaultQuantity! >
                                                  0.0) {
                                            showCoomonErrorDialog(
                                                title: "Toppings",
                                                message:
                                                    "Can not delete default toppings");
                                          } else if (toppingList!
                                                  .where((element) =>
                                                      element.itemQuantity! >=
                                                      1)
                                                  .length ==
                                              1) {
                                            showCoomonErrorDialog(
                                                title: "Toppings",
                                                message:
                                                    "Can not delete all toppings");
                                          } else {
                                            toppingList![e.key].itemQuantity =
                                                quantity.toDouble();
                                          }
                                        });
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                          )
                          .toList()
                      : [const SizedBox()],
                )),
            /* Visibility(
                visible: !visibility,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.toppings.isNotEmpty
                      ? widget.toppings
                          .asMap()
                          .entries
                          .map(
                            (e) => ListTile(
                              title: Text(e.value.toppingName ?? ""),
                              trailing: QuantitySelector(
                                maxQuantity: e.value.maximumQuantity,
                                defaultQuantity: e.value.values
                                        ?.where((element) => element!)
                                        .length ??
                                    0,
                                onTap: (quantity) {},
                              ),
                            ),
                          )
                          .toList()
                      : [const SizedBox()],
                )),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  widget.toppings.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            Map<String, dynamic> arguments = {
                              "model": widget.recipeDetailsModel,
                              "isBuildYourOwn": false,
                            };
                            Get.toNamed(RouteNames.customizePizza,
                                arguments: arguments);
                          },
                          child: SvgPicture.asset(
                            Assets.customize,
                            height: 20.sp,
                            width: 20.sp,
                          ))
                      : const SizedBox(),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        widget.onDelete(true);
                      },
                      child: SvgPicture.asset(
                        Assets.delete,
                        height: 20.sp,
                        width: 20.sp,
                      )),
                  //IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  //IconButton(onPressed: () {}, icon: Icon(Icons.delete_outline)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({
    super.key,
    required this.onTap,
    required this.defaultQuantity,
    this.maxQuantity,
  });

  final Function(int value) onTap;
  final int defaultQuantity;
  final int? maxQuantity;

  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;

  void increaseQuantity() {
    if (widget.maxQuantity != null) {
      if (quantity < widget.maxQuantity!) {
        setState(() {
          quantity++;
          widget.onTap(quantity);
        });
      }
    } else {
      setState(() {
        quantity++;

        widget.onTap(quantity);
      });
    }
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget.onTap(quantity);
      });
    } else {
      widget.onTap(0);
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
          child: GestureDetector(
              child: SvgPicture.asset(
            Assets.delete,
            height: 20.sp,
            width: 20.sp,
            color: Colors.red,
          )),
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
