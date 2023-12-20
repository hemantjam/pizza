import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/cart/cart_controller.dart';
import 'package:pizza/widgets/common_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/assets.dart';
import '../../cart/model/order_master/order_master_create_model.dart';
import '../../cart/widget/cart_details_bottom_bar.dart';
import '../../delivery_order_type/delivery_order_type_options.dart';
import '../by_group_code/menu_by_group_code_model.dart';
import '../menu_model.dart';
import '../utils/add_to_cart.dart';
import '../utils/calculate_tax.dart';
import 'menu_details_controller.dart';

class AllMenuPage extends GetView<MenuDetailsController> {
  AllMenuPage({Key? key}) : super(key: key);
  CartController cartController =
      Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: const MenuList(),
        bottomNavigationBar: cartDetailsBottomBar(
            controller.selectedItemIndex.value ==
                controller.menuListModel.where((p0) => p0.webDisplay!).length -
                    1,
            false,
            () {},
            cartController.cartItemsLength,
            cartController.cartTotal),
      ),
    );
  }

  /// app bar
  AppBar buildAppBar() {
    return AppBar(
      leadingWidth: 30,
      title: const Text("Menu"),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteNames.cartPage);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: GetBuilder<CartController>(
               // init: CartController(),
                builder: (logic) {
                  return Badge(
                    label: Obx(() {
                      return Text(logic.cartItems.length.toString());
                    }),
                    child: SvgPicture.asset(
                      Assets.bottomCart,
                      color: Colors.black,
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}

/// horizontal menu list with details
class MenuList extends GetView<MenuDetailsController> {
  const MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final visibleMenuList =
          controller.menuListModel.where((p0) => p0.webDisplay!).toList();
      return DefaultTabController(
        initialIndex: controller.selectedItemIndex.value,
        length: visibleMenuList.length,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTabBar(),
            Expanded(
              child: buildTabBarView(),
            )
          ],
        ),
      );
    });
  }

  TabBar buildTabBar() {
    return TabBar(
      onTap: (index) {
        controller.selectedItemIndex.value = index;
      },
      labelPadding: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(0),
      indicatorColor: Colors.transparent,
      isScrollable: true,
      tabs: controller.menuListModel
          .asMap()
          .entries
          .where((element) => element.value.webDisplay!)
          .map((e) => CustomTabBar(
                index: e.key,
                menuListModel: e.value,
              ))
          .toList(),
    );
  }

  TabBarView buildTabBarView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: controller.menuListModel
          .asMap()
          .entries
          .where((element) => element.value.webDisplay!)
          .map((e) {
        return controller.groupModelList.values.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.orange,
              ))
            : MenuDetails(
                image: controller.menuListModel[e.key].bigImage ?? "",
                groupModel: controller.groupModelList.entries
                    .firstWhere((element) => element.key == e.value.code)
                    .value,
              );
      }).toList(),
    );
  }
}

/// tab bar
class CustomTabBar extends GetView<MenuDetailsController> {
  const CustomTabBar({
    Key? key,
    required this.index,
    required this.menuListModel,
  }) : super(key: key);

  final int index;
  final MenuListModel menuListModel;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        elevation: 0,
        color: controller.selectedItemIndex.value == index
            ? Colors.orange.shade400
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          child: Row(
            children: [
              menuListModel.bigImage != null
                  ? SvgPicture.network(
                      menuListModel.bigImage ?? "",
                      fit: BoxFit.contain,
                      height: 24.sp,
                      width: 24.sp,
                    )
                  : const SizedBox(),
              const SizedBox(width: 5),
              Text(
                menuListModel.name ?? "",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      );
    });
  }
}

/// menu details
class MenuDetails extends GetView<MenuDetailsController> {
  final GroupModel groupModel;
  final String image;

  const MenuDetails({Key? key, required this.image, required this.groupModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<MenuDetailsController>(builder: (logic) {
        Map<String, List<RecipeDetailsModel>> categorizedRecipes =
            controller.fetchCategories(groupModel);
        if (categorizedRecipes.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 10), () {
            controller.toggleCateExpName(
                true, categorizedRecipes.entries.first.key);
          });
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return headerDesign(
                  image,
                  categorizedRecipes.entries.map((e) => e.key).toList(),
                  groupModel.group?.itemGroupCode ?? "",
                  controller.buildYourPizzaModel.value.data?.entries.first.value
                      .items?.values.first,
                  controller.expandedCateName.value, (value) {
                controller.toggleCateExpName(
                    controller.expandedCateName.value != value, value);
              });
            }),
            const SizedBox(
              height: 20,
            ),
            categorizedRecipes.isEmpty
                ? Column(
                    children: groupModel.items != null
                        ? groupModel.items!.entries
                            .map((e) => MenuItemDetails(
                                value: e.value,
                                groupCode:
                                    groupModel.group?.itemGroupCode ?? ""))
                            .toList()
                        : [const SizedBox()],
                  )
                : Obx(() {
                    return Column(
                      children: categorizedRecipes.entries
                          .map((e) => CustomCateTile(
                                isExpand:
                                    e.key == controller.expandedCateName.value,
                                category: e.key,
                                children: e.value.map((e) => e).toList(),
                                groupCode:
                                    groupModel.group?.itemGroupCode ?? "",
                                onExpand: controller.toggleCateExpName,
                              ))
                          .toList(),
                    );
                  }),
          ],
        );
      }),
    );
  }
}

class CustomCateTile extends StatelessWidget {
  final List<RecipeDetailsModel> children;
  final String groupCode;
  final Function(bool, String) onExpand;
  final String category;
  final bool isExpand;

  const CustomCateTile({
    super.key,
    required this.isExpand,
    required this.children,
    required this.groupCode,
    required this.onExpand,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onExpand(!isExpand, category),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(category,
                  style: TextStyle(
                    fontSize: 14.sp,
                  )),
            ],
          ),
        ),
        Visibility(
          maintainAnimation: true,
          maintainState: true,
          visible: isExpand,
          child: Column(
            children: children
                .map((e) => MenuItemDetails(value: e, groupCode: groupCode))
                .toList(),
          ),
        )
      ],
    );
  }
}

/// menu item details
class MenuItemDetails extends StatefulWidget {
  final String groupCode;
  final RecipeDetailsModel value;

  const MenuItemDetails(
      {Key? key, required this.groupCode, required this.value})
      : super(key: key);

  @override
  State<MenuItemDetails> createState() => _MenuItemDetailsState();
}

class _MenuItemDetailsState extends State<MenuItemDetails> {
  final MenuDetailsController controller = Get.find<MenuDetailsController>();
  String? selectedSize;
  String? selectedBase;
  double basePrice = 0;
  double addOn = 0;
  double tax = 0;
  int simpleIntInput = 0;
  int defaultQuantity = 1;

  onTap(int quantity) {
    defaultQuantity = quantity;
    setState(() {});
  }

  // CartController cartController = Get.put(CartController());

  @override
  void initState() {
    selectedSize = widget.value.recipes?.first.size?.name;
    selectedBase = widget.value.recipes?.first.base?.first.name;
    addOn = widget.value.recipes?.first.base?.first.addCost ?? 0;
    basePrice = widget.value.recipes?.first.basePrice ?? 0;
    tax = widget.value.recipes?.first.tax ?? 0;
    /* RecipeModel? recipeModel = widget.value?.recipes
        ?.where((element) => element.size?.name == "$selectedSize")
        ?.first;
//
    controller.toggleRecipeModel(recipeModel);*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          SizedBox(
            height: 21.h,
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: 20.h,
                    width: 100.w,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Map<String, dynamic> arguments = {
                      "model": widget.value,
                      "isBuildYourOwn": false,
                    };
                    Get.toNamed(RouteNames.customizePizza,
                        arguments: arguments);
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.groupCode == "G1"
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: const Text(
                              "Customize",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// is new flag
                        widget.value.isNew != null && widget.value.isNew!
                            ? const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 35,
                              )
                            : const SizedBox(),

                        /// spicy flag
                        widget.value.dietary != null
                            ? Image.network(
                                widget.value.dietary?.symbol ?? "",
                                height: 35.sp,
                                width: 35.sp,
                              )
                            : const SizedBox(),
                      ],
                    ),
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
                    Text(
                      "\$${((calculateTotalPrice(basePrice, tax) + addOn) * defaultQuantity).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 18.sp, color: Colors.orange),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                                              controller.toggleRecipeModel(
                                                  widget.value.recipes
                                                      ?.where((element) =>
                                                          element.size?.name ==
                                                          "$selectedSize")
                                                      .first);
                                            });
                                          }
                                        },
                                        items: widget.value.recipes!
                                            .map(
                                                (e) => DropdownMenuItem<String>(
                                                      value: e.size?.name ?? "",
                                                      child: SizedBox(
                                                        width: 35.w,
                                                        child: Text(
                                                          e.size?.name ?? "",
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                      .expand<BaseModel?>(
                                          (bases) => bases ?? [])
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

                Text("Quantity", style: titleStyle()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuantitySelector(onTap: onTap),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                      ),
                      onPressed: () async {
                        await showModalBottomSheet(
                            useSafeArea: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            showDragHandle: true,
                            context: context,
                            builder: (context) {
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: OrderDeliveryTypeOption(
                                  navigationBack: true,
                                  elevation: 0,
                                ),
                              );
                            });
                        OrderMasterCreateModel? orderMasterCreateModel =
                            GetInstance().isRegistered<OrderMasterCreateModel>(
                                    tag: "orderMasterCreateModel")
                                ? Get.find<OrderMasterCreateModel>(
                                    tag: "orderMasterCreateModel")
                                : null;
                        RecipeDetailsModel model = widget.value;
                        log("=====${orderMasterCreateModel?.data?.id.toString()}");
                        if (orderMasterCreateModel?.data?.id! != null) {
                          await orderDetailsCreate(
                              model,
                              defaultQuantity,
                              selectedBase,
                              selectedSize,
                              orderMasterCreateModel?.data?.id,
                              //  cartController,
                              ((calculateTotalPrice(basePrice, tax) + addOn) *
                                      defaultQuantity)
                                  .ceil(),
                              null);
                          /* if (success) {
                            */ /*await controller.addToLocalDb(
                                recipeValue: model.recipes
                                    ?.where((element) =>
                                        element.size?.name == selectedSize)
                                    .first,
                                name: model.name ?? "",
                                quantity: defaultQuantity,
                                recipeDetailsModel: jsonEncode(model.toJson()),
                                addon: addOn.toInt(),
                                total: ((calculateTotalPrice(basePrice, tax) +
                                            addOn) *
                                        defaultQuantity)
                                    .ceil(),
                                selectedBase: selectedBase ?? "",
                                selectedSize: selectedSize ?? "");*/ /*
                          }*/
                        } else {
                          showCoomonErrorDialog(
                              title: "Error", message: "Something went wrong");
                        }
                      },
                      child: const Text("Add To Cart"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// base selection
class BaseSelection extends StatelessWidget {
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
}

TextStyle titleStyle() => TextStyle(color: Colors.blue.shade900, fontSize: 18);

Widget headerDesign(
    String image,
    List<String>? categories,
    String code,
    RecipeDetailsModel? recipeDetailsModel,
    String selectedCate,
    Function(String) onTap) {
  return Container(
    height: 12.h,
    color: Colors.white,
    child: Stack(
      children: [
        Center(
          child: Container(height: 5, color: Colors.orange),
        ),
        Center(
          child: SizedBox(
            height: 12.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.orange, width: 5)),
                    child: image.isNotEmpty
                        ? SvgPicture.network(
                            image,
                            fit: BoxFit.contain,
                            height: 36.sp,
                            width: 36.sp,
                          )
                        : const SizedBox(),
                  ),
                ),
                if (categories != null && categories.isNotEmpty)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories
                            .map(
                              (e) => GestureDetector(
                                onTap: () => onTap(e),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 14.sp,
                                      color: e == selectedCate
                                          ? Colors.orangeAccent
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                if (code == "G1")
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Map<String, dynamic> arguments = {
                                "model": recipeDetailsModel,
                                "isBuildYourOwn": true,
                              };
                              recipeDetailsModel != null
                                  ? Get.toNamed(RouteNames.customizePizza,
                                      arguments: arguments)
                                  : null;
                            },
                            child: SvgPicture.asset(
                              Assets.bottomBuildYourPizza,
                              height: 26.sp,
                              width: 26.sp,
                              color: Colors.black,
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.bottomHalfHalf,
                            height: 26.sp,
                            width: 26.sp,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key, required this.onTap});

  final Function(int value) onTap;

  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

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
        border: Border.all(color: Colors.black, width: 0.5),
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
            horizontal: BorderSide(color: Colors.black, width: 0.5)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
