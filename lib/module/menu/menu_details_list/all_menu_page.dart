import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/assets.dart';
import '../by_group_code/menu_by_group_code_model.dart';
import '../menu_model.dart';
import '../utils/calculate_tax.dart';
import 'menu_details_controller.dart';

class AllMenuPage extends GetView<MenuDetailsController> {
  const AllMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: const MenuList(),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          height: 75,
          decoration: BoxDecoration(color: Color(0xffEEEEEE)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: buildStyleFrom(186, 44),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        "1 item",
                        style: buildButtonTextStyle(),
                      ),
                      const Spacer(),
                      Text(
                        " \$55",
                        style: buildButtonTextStyle(),
                      ),
                    ],
                  )),
              ElevatedButton(
                  style: buildStyleFrom(126, 44),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        "Checkout",
                        style: buildButtonTextStyle(),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle buildButtonTextStyle() => const TextStyle(fontSize: 16);

  ButtonStyle buildStyleFrom(double width, double height) {
    return ElevatedButton.styleFrom(
        fixedSize: Size(width, height), elevation: 1);
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
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              Assets.bottomCart,
              color: Colors.black,
            ),
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
      return DefaultTabController(
        length: controller.menuListModel.where((p0) => p0.webDisplay!).length,
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
            ? const SizedBox(
                child: Center(child: Text("fetching data...")),
              )
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
        return Column(
          children: [
            headerDesign(
              image,
              categorizedRecipes.entries.map((e) => e.key).toList(),
              groupModel.group?.itemGroupCode ?? "",
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
                : Column(
                    children: categorizedRecipes.entries
                        .map((e) => categoryTile(
                            e.key,
                            e.value.map((e) => e).toList(),
                            groupModel.group?.itemGroupCode ?? ""))
                        .toList(),
                  ),
          ],
        );
      }),
    );
  }
}

/// category tile
Widget categoryTile(
    String category, List<RecipeDetailsModel> children, String groupCode) {
  return ExpansionTile(
    maintainState: true,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.keyboard_arrow_down, size: 22.sp),
        const SizedBox(width: 5),
        Text(
          category,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    ),
    trailing: Text(children.length.toString()),
    children: children
        .map((e) => MenuItemDetails(value: e, groupCode: groupCode))
        .toList(),
  );
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
  String? selectedItem;
  double basePrice = 0;
  double addOn = 0;
  double tax = 0;

  @override
  void initState() {
    selectedItem = widget.value.recipes?.first.size?.name;
    addOn = widget.value.recipes?.first.base?.first.addCost ?? 0;
    basePrice = widget.value.recipes?.first.basePrice ?? 0;
    tax = widget.value.recipes?.first.tax ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// image
            SizedBox(
              height: 21.h,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.value.image ?? "",
                    placeholder: (context, url) => const SizedBox(
                        child: BlurHash(hash: Assets.homeBannerBlur)),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: 20.h,
                    width: 100.w,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.groupCode == "G1"
                        ? Container(
                            decoration: BoxDecoration(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// is new flag
                          widget.value.isNew != null && widget.value.isNew!
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: const Text(
                                    "New",
                                    style: TextStyle(color: Colors.white),
                                  ),
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
            const SizedBox(height: 10),

            /// name , price , base, size
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        "\$${calculateTotalPrice(basePrice, addOn, tax)}",
                        style: TextStyle(fontSize: 18.sp, color: Colors.orange),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.value.ingredients ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  widget.value.recipes != null
                      ? SizedBox(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.value.recipes != null &&
                                    widget.value.recipes?.first.size != null
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Pizza Size", style: titleStyle()),
                                      DropdownButton<String>(
                                        value: selectedItem,
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              selectedItem = newValue;
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
                                            });
                                          }
                                        },
                                        items: widget.value.recipes!
                                            .map((e) =>
                                                DropdownMenuItem<String>(
                                                  value: e.size?.name ?? "",
                                                  child:
                                                      Text(e.size?.name ?? ""),
                                                ))
                                            .toList(),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            widget.value.recipes != null &&
                                    widget.value.recipes?.first.size != null
                                ? BaseSelection(
                                    onSelect: (d) {
                                      setState(() {
                                        addOn = d;
                                      });
                                    },
                                    //  name: "Base",
                                    sizes: widget.value.recipes!
                                        .where((element) =>
                                            element.size?.name == selectedItem)
                                        .map((e) => e.base)
                                        .expand<BaseModel?>(
                                            (bases) => bases ?? [])
                                        .toList(),
                                  )
                                : BaseSelection(
                                    onSelect: (d) {
                                      setState(() {
                                        addOn = d;
                                      });
                                    },
                                    sizes:
                                        widget.value.recipes?.first.base ?? [],
                                  ),
                          ],
                        ))
                      : const SizedBox(),
                  Text("Quantity", style: titleStyle()),
                ],
              ),
            ),

            /// quantity , add to cart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Row(
                  children: [
                    QuantityItem(text: "-"),
                    QuantityItem(text: "1"),
                    QuantityItem(text: "+"),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                  ),
                  onPressed: () {},
                  child: const Text("Add To Cart"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// base selection
class BaseSelection extends StatelessWidget {
  final List<BaseModel?> sizes;
  final Function(double) onSelect;

  const BaseSelection({Key? key, required this.sizes, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedItem = "";
    return SizedBox(
      child: sizes.isNotEmpty
          ? Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Base",
                      style: titleStyle(),
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        if (selectedItem == "") {
                          selectedItem = sizes.first!.name!;
                        }
                        return DropdownButton<String>(
                          value: selectedItem,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedItem = newValue;
                              });
                            }
                            onSelect(sizes
                                    .firstWhere((element) =>
                                        element?.name == selectedItem &&
                                        element?.addCost != null)
                                    ?.addCost ??
                                0.0);
                          },
                          items: sizes
                              .map((e) => DropdownMenuItem<String>(
                                    value: e?.name ?? "",
                                    child: Text(e?.name ?? ""),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}

/// quantity
class QuantityItem extends GetView<MenuDetailsController> {
  final String text;

  const QuantityItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      alignment: Alignment.center,
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Text(text),
    );
  }
}

TextStyle titleStyle() => TextStyle(color: Colors.blue.shade900, fontSize: 18);

Widget headerDesign(String image, List<String>? categories, String code) {
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
                            image ?? "",
                            fit: BoxFit.contain,
                            height: 36.sp,
                            width: 36.sp,
                          )
                        : const SizedBox(),
                  ),
                ),
                categories != null && categories.isNotEmpty
                    ? Wrap(
                        children: categories
                            .map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    textBaseline: TextBaseline.alphabetic,
                                    fontSize: 14.sp,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : const SizedBox(),
                code == "G1"
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  Assets.bottomBuildYourPizza,
                                  height: 26.sp,
                                  width: 26.sp,
                                  color: Colors.black,
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
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
