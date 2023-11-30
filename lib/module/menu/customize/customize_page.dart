import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/assets.dart';
import '../../delivery_order_type/delivery_order_type_optios.dart';
import '../by_group_code/menu_by_group_code_model.dart';
import '../menu_details_list/all_menu_page.dart';
import '../utils/calculate_tax.dart';
import 'customize_controller.dart';

class CustomizePizzaPage extends GetView<CustomizePizzaController> {
  const CustomizePizzaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        title: Obx(() {
          return Text(controller.isBuildYourOwnPizza.value
              ? "Build Your Own Pizza"
              : "Customize Pizza");
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.recipeDetailsModel != null
                ? ItemDetails(
                    value: controller.recipeDetailsModel!,
                    getRecipe: controller.toggleRecipeModel,
                  )
                : SizedBox(),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Obx(
              () => _buildToppingsList(
                  controller.allToppings.where((p0) => p0.isSelected).toList(),
                  onTap: (ToppingsSelection toppings) {
                controller.addTopping(toppings);
              },
                  initialExpand: true,
                  title: "Selected Toppings",
                  subtitle:
                      "you can add upto ${controller.recipeModel.value?.toppingsInfo?.toppings?.maximumQuantity?.toStringAsFixed(0)} toppings"),
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Obx(() => _buildToppingsList(
                    initialExpand: false,
                    controller.allToppings
                        .where((p0) => !p0.isSelected)
                        .toList(), onTap: (ToppingsSelection toppings) {
                  controller.addTopping(toppings);
                },
                    title: "Available Toppings",
                    subtitle: "Please select from Toppings list")),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToppingsList(List<ToppingsSelection>? toppings,
      {required Function(ToppingsSelection) onTap,
      required String title,
      required String subtitle,
      required bool initialExpand}) {
    Map<int, int?> selectedQuantities = {}; // Map to store selected quantities

    return ExpansionTile(
      initiallyExpanded: initialExpand,
      title: Text(
        title,
        style: TextStyle(fontSize: 18.sp, color: Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
      ),
      children: toppings?.asMap().entries.map((e) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ListTile(
                  title: Text(toppings[e.key].toppingName ?? ""),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      int.parse(e.value.maximumQuantity.toStringAsFixed(0)),
                      (index) => Radio(
                        toggleable: true,
                        value: index,
                        groupValue:
                            selectedQuantities[toppings[e.key].toppingId] ??
                                toppings[e.key].selectedQuantity,
                        onChanged: (value) {
                          setState(() {
                            selectedQuantities[toppings[e.key].toppingId!] =
                                value;
                          });
                          controller.addTopping(ToppingsSelection(
                            addCost: toppings[e.key].addCost,
                            maximumQuantity: toppings[e.key].maximumQuantity,
                            isSelected:
                                selectedQuantities[toppings[e.key].toppingId] !=
                                    null,
                            toppingName: toppings[e.key].toppingName,
                            toppingId: toppings[e.key].toppingId,
                            selectedQuantity:
                                selectedQuantities[toppings[e.key].toppingId] ??
                                    toppings[e.key].selectedQuantity,
                          ));
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList() ??
          [],
    );
  }
}

/// menu item details
class ItemDetails extends StatefulWidget {
  final RecipeDetailsModel value;
  final Function(RecipeModel?)? getRecipe;

  const ItemDetails({Key? key, required this.value, required this.getRecipe})
      : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  CustomizePizzaController controller = Get.find<CustomizePizzaController>();
  String? selectedSize;
  String? selectedBase;
  double basePrice = 0;
  double addOn = 0;
  double tax = 0;
  int defaultQuantity = 1;
  int simpleIntInput = 0;

  onTap(int newQuantity) {
    setState(() {
      defaultQuantity = newQuantity;
    });
    log("---->${newQuantity}");
  }

  @override
  void initState() {
    selectedSize = widget.value.recipes?.first.size?.name;
    RecipeModel? recipeModel = widget.value.recipes
        ?.where((element) => element.size?.name == "$selectedSize")
        .first;

    widget.getRecipe!(recipeModel);
    addOn = widget.value.recipes?.first.base?.first.addCost ?? 0;
    basePrice = widget.value.recipes?.first.basePrice ?? 0;
    tax = widget.value.recipes?.first.tax ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25.h,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.value.image ?? "",
                  placeholder: (context, url) => const SizedBox(
                      child: BlurHash(hash: Assets.homeBannerBlur)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 25.h,
                  width: 100.w,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// name , price , base, size
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.value.name ?? "",
                      style: TextStyle(fontSize: 18.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Text("${basePrice.ceil() * defaultQuantity}"),
                  Obx(() {
                    return Text(
                      "\$${(int.parse(calculateTotalPrice(basePrice, addOn, tax)) + controller.allToppings.where((element) => element.isSelected).fold(0, (sum, topping) => sum + topping.addCost.toInt()).ceil()) * defaultQuantity}",
                      style: TextStyle(fontSize: 18.sp, color: Colors.orange),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.value.ingredients ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              widget.value.recipes != null
                  ? Row(
                      mainAxisAlignment: widget.value.recipes != null &&
                              widget.value.recipes?.first.size != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        widget.value.recipes != null &&
                                widget.value.recipes?.first.size != null
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pizza Size", style: titleStyle()),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5, color: Colors.black)),
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(),
                                      elevation: 0,
                                      borderRadius: BorderRadius.zero,
                                      padding: const EdgeInsets.all(5),
                                      isDense: true,
                                      value: selectedSize,
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            selectedSize = newValue;
                                            basePrice = widget.value.recipes!
                                                    .where((element) =>
                                                        element.size?.name ==
                                                        newValue)
                                                    .first
                                                    .basePrice ??
                                                0.0;
                                            addOn = widget.value.recipes!
                                                    .where((element) =>
                                                        element.size?.name ==
                                                        newValue)
                                                    .first
                                                    .base
                                                    ?.first
                                                    .addCost ??
                                                0.0;
                                            selectedBase = null;
                                            widget.getRecipe!(widget
                                                .value.recipes
                                                ?.where((element) =>
                                                    element.size?.name ==
                                                    "$selectedSize")
                                                .first);
                                          });
                                        }
                                      },
                                      items: widget.value.recipes!
                                          .map((e) => DropdownMenuItem<String>(
                                                value: e.size?.name ?? "",
                                                child: SizedBox(
                                                  width: 35.w,
                                                  child: Text(
                                                    e.size?.name ?? "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                        widget.value.recipes != null &&
                                widget.value.recipes?.first.size != null
                            ? BaseSelection(
                                onSelect: (d, item) {
                                  setState(() {
                                    addOn = d;
                                    selectedBase = item;
                                  });
                                },
                                sizes: widget.value.recipes!
                                    .where((element) =>
                                        element.size?.name == selectedSize)
                                    .map((e) => e.base)
                                    .expand<BaseModel?>((bases) => bases ?? [])
                                    .toList(),
                                selectedBase: selectedBase,
                              )
                            : BaseSelection(
                                onSelect: (addon, item) {
                                  setState(() {
                                    addOn = addon;
                                    selectedBase = item;
                                  });
                                },
                                sizes: widget.value.recipes?.first.base ?? [],
                                selectedBase: selectedBase,
                              ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 10),

              /// quantity , add to cart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.isBuildYourOwnPizza.value
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sauce", style: titleStyle()),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.black)),
                              child: DropdownButton<String>(
                                underline: const SizedBox(),
                                elevation: 0,
                                borderRadius: BorderRadius.zero,
                                padding: const EdgeInsets.all(5),
                                isDense: true,
                                value: selectedSize,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedSize = newValue;
                                      basePrice = widget.value.recipes!
                                              .where((element) =>
                                                  element.size?.name ==
                                                  newValue)
                                              .first
                                              .basePrice ??
                                          0.0;
                                      addOn = widget.value.recipes!
                                              .where((element) =>
                                                  element.size?.name ==
                                                  newValue)
                                              .first
                                              .base
                                              ?.first
                                              .addCost ??
                                          0.0;
                                      selectedBase = null;
                                      widget.getRecipe!(widget.value.recipes
                                          ?.where((element) =>
                                              element.size?.name ==
                                              "$selectedSize")
                                          .first);
                                    });
                                  }
                                },
                                items: widget.value.recipes!
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e.size?.name ?? "",
                                          child: SizedBox(
                                            width: 35.w,
                                            child: Text(
                                              e.size?.name ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Quantity", style: titleStyle()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          QuantitySelector(onTap: onTap),

                          /// add to cart
                          controller.isBuildYourOwnPizza.value
                              ? SizedBox.shrink()
                              : Obx(() {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 1,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      foregroundColor: Colors.white,
                                      backgroundColor: !controller.allToppings
                                              .any((element) =>
                                                  element.isSelected)
                                          ? Colors.grey.shade700
                                          : Colors.orange,
                                    ),
                                    onPressed: () {
                                      if (controller.allToppings.any(
                                          (element) => element.isSelected)) {
                                        showModalBottomSheet(
                                            useSafeArea: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                            showDragHandle: true,
                                            context: context,
                                            builder: (context) {
                                              return const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 10),
                                                child: OrderDeliveryTypeOption(
                                                    elevation: 0),
                                              );
                                            });
                                      }
                                    },
                                    child: const Text("Add To Cart"),
                                  );
                                }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              !controller.isBuildYourOwnPizza.value
                  ? SizedBox.shrink()
                  : Obx(() {
                      return SizedBox(
                        width: 100.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            foregroundColor: Colors.white,
                            backgroundColor: !controller.allToppings
                                    .any((element) => element.isSelected)
                                ? Colors.grey.shade700
                                : Colors.orange,
                          ),
                          onPressed: () {
                            if (controller.allToppings
                                .any((element) => element.isSelected)) {
                              showModalBottomSheet(
                                  useSafeArea: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  showDragHandle: true,
                                  context: context,
                                  builder: (context) {
                                    return const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child:
                                          OrderDeliveryTypeOption(elevation: 0),
                                    );
                                  });
                            }
                          },
                          child: const Text("Add To Cart"),
                        ),
                      );
                    })
            ],
          ),
        ),
      ],
    );
  }
}

/// base selection
/*class BaseSelection extends StatelessWidget {
  final List<BaseModel?> sizes;
  final Function(double, String?) onSelect;
  final String? selectedBase;

  const BaseSelection(
      {Key? key,
      required this.sizes,
      required this.onSelect,
      required this.selectedBase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sizes.isNotEmpty
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Base",
                    style: titleStyle(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      String? selectedItem = selectedBase;

                      if (selectedBase == null) {
                        selectedItem = sizes.first!.name!;
                      }
                      if (sizes
                          .any((element) => element!.name == selectedBase)) {
                        selectedItem = selectedBase;
                      } else {
                        selectedItem = sizes.first!.name!;
                      }
                      return Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.5, color: Colors.black)),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          elevation: 0,
                          padding: const EdgeInsets.all(5),
                          isDense: true,
                          value: selectedItem,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedItem = newValue;
                              });
                            }
                            onSelect(
                              sizes
                                      .firstWhere((element) =>
                                          element?.name == selectedItem &&
                                          element?.addCost != null)
                                      ?.addCost ??
                                  0.0,
                              selectedItem,
                            );
                          },
                          items: sizes
                              .map((e) => DropdownMenuItem<String>(
                                    value: e?.name ?? "",
                                    child: SizedBox(
                                        width: 35.w,
                                        child: Text(
                                          e?.name ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )),
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          )
        : const SizedBox();
  }
}*/

//TextStyle titleStyle() => TextStyle(color: Colors.blue.shade900, fontSize: 18);
/*
class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});

  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: decreaseQuantity,
            child: _buildButton(
              "-",
            )),
        _buildText(quantity.toString()),
        GestureDetector(
            onTap: increaseQuantity,
            child: _buildButton(
              "+",
            )),
      ],
    );
  }

  Widget _buildButton(String text) {
    return Container(
      height: 4.h,
      width: 10.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Container(
      alignment: Alignment.center,
      height: 4.h,
      width: 10.w,
      decoration: const BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.black, width: 1)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}*/
