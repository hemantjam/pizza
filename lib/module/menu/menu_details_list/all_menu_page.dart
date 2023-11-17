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
import '../utils/calculate_tax.dart';

class AllMenuPage extends GetView<MenuDetailsController> {
  const AllMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: controller.getMenu,
        ),
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
          length: controller.menuListModel
              .where((p0) => p0.webDisplay!)
              .length,
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
                    .map((e) =>
                    CustomTabBar(
                      index: e.key,
                      menuListModel: e.value,
                    ))
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                    children: controller.menuListModel
                        .asMap()
                        .entries
                        .where((element) => element.value.webDisplay!)
                        .map((e) => MenuDetails())
                        .toList()),
              )
            ],
          ));
    });
  }
}

class MenuDetails extends GetView<MenuDetailsController> {
  const MenuDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children:

          /* controller.model.value.data?.items?.first
            .map((e) => ListTile(
            //trailing: Text(controller.model.value.data.entries.),
            title: Text(e.toString(),maxLines: 2,)))
            .toList()?*/

          controller.model.value.data?.entries.first.value.items?.entries
              .map((e) =>
              MenuItemDetails(
                value: e.value,
              ))
              .toList() ??
              [
                SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ]
          /* Container(
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
                                border:
                                    Border.all(color: Colors.orange, width: 5)),
                            child: Image.asset(Assets.logoPng, height: 50.sp),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Classic",
                              style: TextStyle(
                                textBaseline: TextBaseline.alphabetic,
                                fontSize: 14.sp,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Signature",
                              style: TextStyle(fontSize: 14.sp),
                            )
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SvgPicture.asset(
                                    Assets.bottomBuildYourPizza,
                                    height: 26.sp,
                                    width: 26.sp,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 20),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            maintainState: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.keyboard_arrow_down, size: 22.sp),
                const SizedBox(width: 5),
                Text(
                  "Classic",
                  style: TextStyle(fontSize: 16.sp),
                )
              ],
            ),
            trailing: const SizedBox(),
            children: [1, 2, 3].map((e) => const MenuItemDetails()).toList(),
          ),
          ExpansionTile(
            maintainState: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.keyboard_arrow_down, size: 22.sp),
                const SizedBox(width: 5),
                Text(
                  "Signature",
                  style: TextStyle(fontSize: 16.sp),
                )
              ],
            ),
            trailing: const SizedBox(),
            children: [1, 2, 3].map((e) => const MenuItemDetails()).toList(),
          ),*/
          ,
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
              height: 20.5.h,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: value.image ?? "",
                    placeholder: (context, url) =>
                    const SizedBox(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value.shortName ?? "",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Obx(() {
                    return Text(controller.totalPrice +
                        "\$${value.recipes?.first.basePrice?.toStringAsFixed(2)
                            .toString()}",
                      style: TextStyle(fontSize: 18.sp),
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "${value.ingredients ?? ""}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* selectionItem(
                      "Pizza base",value.availableSizes
                      .where((element) => element.), "Crust"),*/
                  selectionItem(
                      "Pizza base", ['Crust', 'Thin', 'Soft'], "Crust"),
                  selectionItem(
                      "Pizza size", ['Large', 'Medium', 'Regular'], "Large"),
                ],
              ),
            ),
            const Text("Quantity"),
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

class QuantityItem extends StatelessWidget {
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

selectionItem(String name, List<String> items, String selectedItem) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(name),
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        selectedItem = items.first;
        return DropdownButton<String>(
          value: selectedItem,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedItem = newValue;
              });
            }
          },
          items: items.map((String base) {
            return DropdownMenuItem<String>(
              value: base,
              child: Text(base),
            );
          }).toList(),
        );
      })
    ],
  );
}
