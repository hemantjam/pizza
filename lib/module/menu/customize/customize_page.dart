import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pizza/widgets/common_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/assets.dart';
import '../../cart/model/order_master/order_master_create_model.dart';
import '../by_group_code/menu_by_group_code_model.dart';
import '../menu_details_list/all_menu_page.dart';
import '../utils/calculate_tax.dart';
import 'customize_controller.dart';
import 'local_toppings_module.dart';

class CustomizePizzaPage extends GetView<CustomizePizzaController> {
  const CustomizePizzaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.calculateToppingsPrice();
        },
      ),*/
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
                ? const ItemDetails()
                : const SizedBox(),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Obx(
              () => _buildToppingsList(
                selected: controller.filledSlots,
                controller.allToppings.where((p0) => p0.isSelected!).toList(),
                isSelectedList: true,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Obx(() => _buildToppingsList(
                  selected: controller.filledSlots,
                  isSelectedList: false,
                  controller.allToppings
                      .where((p0) => !p0.isSelected!)
                      .toList(),
                )),
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
      {required bool isSelectedList, required int selected}) {
    return ExpansionTile(
      initiallyExpanded: isSelectedList,
      title: Text(
        isSelectedList
            ? "Selected Toppings (${controller.filledSlots})"
            : "Available Toppings",
        style: TextStyle(fontSize: 18.sp, color: Colors.black),
      ),
      subtitle: Text(
        isSelectedList
            ? "you can add up to ${controller.maxSlots} toppings. "
            : "Please select from Toppings list",
        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
      ),
      children: toppings?.asMap().entries.map((e) {
            ToppingsSelection topping = toppings[e.key];
            return ListTile(
                title: Text(topping.toppingName!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(topping.maximumQuantity!, (index) {
                    return Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      value: topping.values![index],
                      onChanged: (value) {
                        int currentIn =
                            topping.values!.where((value) => value!).length;
                        int totalFilledSlots =
                            (controller.filledSlots - currentIn) + (index + 1);
                        if (totalFilledSlots > controller.maxSlots) {
                          showCoomonErrorDialog(
                              title: "Toopings Alert",
                              message: "Max toppings reached");
                          return;
                        } else {
                          topping.defaultQuantity =
                              topping.values!.where((value) => value!).length;
                          topping.values = List.generate(
                            topping.maximumQuantity!.ceil(),
                            (oldIndex) => oldIndex < (index + 1).toInt(),
                          );
                          if (isSelectedList) {
                            if (topping.canRemove! &&
                                index == 0 &&
                                (topping.values![0]! &&
                                    !topping.values![1]! &&
                                    !topping.values![2]!)) {
                              topping.isSelected = false;
                              topping.values = topping.values!
                                  .map((element) => false)
                                  .toList();
                            }
                            topping.canRemove = index == 0;
                            controller.addTopping(topping);
                          } else if (!isSelectedList) {
                            topping.isSelected = true;
                            controller.addTopping(topping);
                            topping.canRemove = false;
                          }
                        }
                      },
                    );
                  }),
                ));
          }).toList() ??
          [],
    );
  }
}

/// menu item details
class ItemDetails extends StatefulWidget {
  const ItemDetails({
    Key? key,
  }) : super(key: key);

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
  String? selectedSauce;

  onTap(int newQuantity) {
    setState(() {
      defaultQuantity = newQuantity;
    });
  }

  @override
  void initState() {
    selectedSize = controller.recipeDetailsModel?.recipes?.first.size?.name;
    selectedSauce =
        controller.recipeDetailsModel?.recipes?.first.sauce?.first.name;
    RecipeModel? recipeModel = controller.recipeDetailsModel?.recipes
        ?.where((element) => element.size?.name == "$selectedSize")
        .first;

    controller.toggleRecipeModel(recipeModel);
    addOn =
        controller.recipeDetailsModel?.recipes?.first.base?.first.addCost ?? 0;
    basePrice = controller.recipeDetailsModel?.recipes?.first.basePrice ?? 0;
    tax = controller.recipeDetailsModel?.recipes?.first.tax ?? 0;
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
                  imageUrl: controller.recipeDetailsModel?.image ?? "",
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
                      controller.recipeDetailsModel?.name ?? "",
                      style: TextStyle(fontSize: 18.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Obx(() {
                    return Text(
                      "\$${(((calculateTotalPrice(basePrice, tax) + addOn) + controller.calculateToppingsPrice()) * defaultQuantity).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 18.sp, color: Colors.orange),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                controller.recipeDetailsModel?.ingredients ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xff999999)),
              ),
              const SizedBox(height: 10),
              controller.recipeDetailsModel?.recipes != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.recipeDetailsModel?.recipes != null &&
                                controller.recipeDetailsModel?.recipes?.first
                                        .size !=
                                    null
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
                                            basePrice = controller
                                                    .recipeDetailsModel
                                                    ?.recipes!
                                                    .where((element) =>
                                                        element.size?.name ==
                                                        newValue)
                                                    .first
                                                    .basePrice ??
                                                0.0;
                                            addOn = controller
                                                    .recipeDetailsModel
                                                    ?.recipes!
                                                    .where((element) =>
                                                        element.size?.name ==
                                                        newValue)
                                                    .first
                                                    .base
                                                    ?.first
                                                    .addCost ??
                                                0.0;
                                            selectedBase = null;
                                            controller.toggleRecipeModel(
                                                controller
                                                    .recipeDetailsModel?.recipes
                                                    ?.where((element) =>
                                                        element.size?.name ==
                                                        "$selectedSize")
                                                    .first);
                                          });
                                        }
                                      },
                                      items: controller
                                          .recipeDetailsModel?.recipes!
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
                        controller.recipeDetailsModel?.recipes != null &&
                                controller.recipeDetailsModel?.recipes?.first
                                        .size !=
                                    null
                            ? BaseSelection(
                                onSelect: (d, item) {
                                  setState(() {
                                    addOn = d;
                                    selectedBase = item;
                                  });
                                },
                                sizes: controller.recipeDetailsModel!.recipes!
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
                                sizes: controller.recipeDetailsModel?.recipes
                                        ?.first.base ??
                                    [],
                                selectedBase: selectedBase,
                              ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 5),
              Text(!controller.isBuildYourOwnPizza.value ? "Quantity" : "",
                  style: titleStyle()),

              /// quantity , add to cart
              SizedBox(height: controller.isBuildYourOwnPizza.value ? 10 : 0),
              /* controller.isBuildYourOwnPizza.value
                  ?*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sauce", style: titleStyle()),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.5, color: Colors.black)),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          elevation: 0,
                          borderRadius: BorderRadius.zero,
                          padding: const EdgeInsets.all(5),
                          isDense: true,
                          value: selectedSauce,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedSauce = newValue;
                                selectedBase = null;
                                controller.toggleRecipeModel(controller
                                    .recipeDetailsModel?.recipes
                                    ?.where((element) =>
                                        element.size?.name == "$selectedSize")
                                    .first);
                              });
                            }
                          },
                          items: controller
                              .recipeDetailsModel?.recipes?.first.sauce!
                              .map((e) => DropdownMenuItem<String>(
                                    value: e.name ?? "",
                                    child: SizedBox(
                                      width: 35.w,
                                      child: Text(
                                        e.name ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 45.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity", style: titleStyle()),
                        const SizedBox(
                          height: 5,
                        ),
                        QuantitySelector(onTap: onTap),
                        /*  Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [


                                  /// add to cart
                               */ /*   controller.isBuildYourOwnPizza.value
                                      ? const SizedBox.shrink()
                                      : Obx(() {
                                          return buildElevatedButton(
                                              context,
                                              0,
                                              controller.recipeDetailsModel
                                                      ?.name ??
                                                  "",
                                              defaultQuantity);
                                        }),*/ /*
                                ],
                              ),*/
                      ],
                    ),
                  ),
                ],
              ),
              /* : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuantitySelector(onTap: onTap),

                        /// add to cart
                        Obx(() {
                          return buildElevatedButton(
                              context,
                              55.w,
                              controller.recipeDetailsModel?.name ?? "",
                              defaultQuantity);
                        }),
                      ],
                    ),*/
              const SizedBox(height: 5),
              /* !controller.isBuildYourOwnPizza.value
                  ? const SizedBox.shrink()
                  :*/
              Obx(() {
                return SizedBox(
                  // width: 100.w,
                  child: buildElevatedButton(
                      context,
                      100.w,
                      controller.recipeDetailsModel?.name ?? "",
                      defaultQuantity),
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  ElevatedButton buildElevatedButton(
      BuildContext context, double width, String name, int quantity) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, 0),
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        foregroundColor: Colors.white,
        backgroundColor:
            !controller.allToppings.any((element) => element.isSelected!)
                ? Colors.grey.shade700
                : Colors.orange,
      ),
      onPressed: () async {
        if (controller.allToppings.any((element) => element.isSelected!)) {
          RecipeDetailsModel recipeModel = controller.recipeDetailsModel!;

          OrderMasterCreateModel? orderMasterCreateModel =
              GetInstance().isRegistered<OrderMasterCreateModel>()
                  ? Get.find<OrderMasterCreateModel>()
                  : null;
          bool success = await controller.orderDetailsCreate(
              recipeModel,
              defaultQuantity,
              selectedBase,
              selectedSize,
              orderMasterCreateModel?.data?.id);
          success
              ? controller.addToLocalDb(
                  cartItemData: jsonEncode(recipeModel.toJson()),
                  name: name ?? "",
                  quantity: defaultQuantity,
                  addon: addOn.ceil(),
                  total: ((calculateTotalPrice(basePrice, tax) + addOn) *
                          defaultQuantity)
                      .ceil(),
                  selectedBase: selectedBase ?? "",
                  selectedSize: selectedSize ?? "",
                )
              : null;
          /* showCoomonErrorDialog(
              title: "Success", message: "Successfully added in cart");*/
          /* showModalBottomSheet(
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
                  child: OrderDeliveryTypeOption(elevation: 0),
                );
              });*/
        }
      },
      child: const Text("Add To Cart"),
    );
  }
}
