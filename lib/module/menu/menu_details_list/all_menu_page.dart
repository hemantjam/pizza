import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/module/menu/menu_details_list/menu_details_controller.dart';
import 'package:sizer/sizer.dart';

import '../by_group_code/menu_by_group_code_model.dart';
import '../menu_model.dart';

class AllMenuPage extends GetView<MenuDetailsController> {
  const AllMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
            FloatingActionButton(onPressed: controller.checkForOfflineData),
        appBar: AppBar(
          leadingWidth: 30,
          title: const Text("Menu"),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              )),
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
        ),
        body: const MenuList(),
      ),
    );
  }
}

class MenuList extends GetView<MenuDetailsController> {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DefaultTabController(
          length: controller.menuListModel.where((p0) => p0.webDisplay!).length,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
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
              ),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: controller.menuListModel
                        .asMap()
                        .entries
                        .where((element) => element.value.webDisplay!)
                        .map((e) => e.key == 0
                            ? const MenuDetails()
                            : SizedBox(
                                child: Center(
                                  child: Text(
                                      "${e.value.name ?? ""} will be here!"),
                                ),
                              ))
                        .toList()),
              )
            ],
          ));
    });
  }
}

class MenuDetails extends GetView<MenuDetailsController> {
  const MenuDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return controller.categorizedRecipes.isEmpty
            ? Center(child: Text("wait..."))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: Column(
                      children: controller.categorizedRecipes.entries
                          .map((e) => categoryTile(
                              e.key, e.value.map((e) => e).toList()))
                          .toList(),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}

class CustomTabBar extends GetView<MenuDetailsController> {
  const CustomTabBar({
    super.key,
    required this.index,
    required this.menuListModel,
  });

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

class MenuItemDetails extends GetView<MenuDetailsController> {
  final RecipeDetailsModel value;

  const MenuItemDetails({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 21.h,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: value.image ?? "",
                    placeholder: (context, url) => const SizedBox(
                        child: BlurHash(hash: Assets.homeBannerBlur)),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: 20.h,
                    width: 100.w,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: const Text(
                            "Customize",
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ),
            const SizedBox(height: 10),
            DetailsWidget(
              value: value,
            ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50), // Adjust the padding as needed
                    ),
                    onPressed: () {},
                    child: const Text("Add To Cart"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsWidget extends StatefulWidget {
  final RecipeDetailsModel value;

  const DetailsWidget({super.key, required this.value});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  double price = 0.0;

  countPrice(double cost) {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        price = cost;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Text(price.toString()),
              Text(
                "\$${widget.value.recipes?.first.basePrice?.toStringAsFixed(2).toString()}",
                style: TextStyle(fontSize: 18.sp, color: Colors.orange),
                maxLines: 1,
              ),
            ],
          ),
          Text(
            widget.value.ingredients ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          SizeSelection(
            name: "Pizza Size",
            model: widget.value.recipes!,
            onSelect: countPrice,
          ),
          const Text("Quantity"),
        ],
      ),
    );
  }
}

class QuantityItem extends GetView<MenuDetailsController> {
  final String text;

  const QuantityItem({super.key, required this.text});

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
        child: Text(text));
  }
}

class SizeSelection extends StatefulWidget {
  final String name;
  final List<RecipeModel> model;
  final Function(double) onSelect;

  const SizeSelection(
      {super.key,
      required this.name,
      required this.model,
      required this.onSelect});

  @override
  State<SizeSelection> createState() => _SizeSelectionState();
}

class _SizeSelectionState extends State<SizeSelection> {
  String selectedItem = "";

  @override
  void initState() {
    selectedItem = widget.model.first.size?.name ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedItem == ""
        ? selectedItem = widget.model.first.size?.name ?? ""
        : null;
    return SizedBox(
      child: widget.model.first.size != null
          ? Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name),
                    DropdownButton<String>(
                        value: selectedItem,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedItem = newValue;
                            });
                          }
                        },
                        items: widget.model
                            .map((e) => DropdownMenuItem<String>(
                                  value: e.size?.name ?? "",
                                  child: Text(e.size?.name ?? ""),
                                ))
                            .toList()),
                  ],
                ),
                BaseSelection(
                    onSelect: widget.onSelect,
                    name: "Base",
                    sizes: widget.model
                        .where((element) => element.size?.name == selectedItem)
                        .map((e) => e.base)
                        .expand<BaseModel?>((bases) => bases ?? [])
                        .toList())
              ],
            )
          : const SizedBox(),
    );
  }
}

class BaseSelection extends StatelessWidget {
  final String name;
  final List<BaseModel?> sizes;
  final Function(double) onSelect;

  BaseSelection({
    super.key,
    required this.name,
    required this.sizes,
    required this.onSelect,
  });

  String selectedItem = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: sizes.isNotEmpty
          ? Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
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
                              /*onSelect(sizes
                                      .firstWhere((element) =>
                                          element?.name == selectedItem &&
                                          element?.addCost != null)
                                      ?.addCost ??
                                  0.0);*/
                            }
                          },
                          items: sizes
                              .map((e) => DropdownMenuItem<String>(
                                    value: e?.name ?? "",
                                    child: Text(e?.name ?? ""),
                                  ))
                              .toList());
                    })
                  ],
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}

Widget categoryTile(String category, List<RecipeDetailsModel> children) {
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
        )
      ],
    ),
    trailing: Text(children.length.toString()),
    children: children.map((e) => MenuItemDetails(value: e)).toList(),
  );
}
