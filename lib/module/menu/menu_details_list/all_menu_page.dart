// Import statements...
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
        /*floatingActionButton: FloatingActionButton(
          onPressed: controller.checkForOfflineData,
        ),*/
        appBar: buildAppBar(),
        body: const MenuList(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
        ),
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
                groupModel: controller.groupModelList.entries
                    .firstWhere((element) => element.key == e.value.code)
                    .value,
              );
      }).toList(),
    );
  }
}

class MenuDetails extends GetView<MenuDetailsController> {
  final GroupModel groupModel;

  const MenuDetails({Key? key, required this.groupModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<MenuDetailsController>(builder: (logic) {
        Map<String, List<RecipeDetailsModel>> categorizedRecipes =
            controller.fetchCategories(groupModel);
        return categorizedRecipes.isEmpty
            ? Column(
                children: groupModel.items != null
                    ? groupModel.items!.entries
                        .map((e) => MenuItemDetails(value: e.value))
                        .toList()
                    : [const SizedBox()],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: Column(
                      children: categorizedRecipes.entries
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

class MenuItemDetails extends StatelessWidget {
  final RecipeDetailsModel value;

  const MenuItemDetails({Key? key, required this.value}) : super(key: key);

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
            /// image
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: const Text(
                        "Customize",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            /// name , price , base, size
            DetailsWidget(value: value),

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

class DetailsWidget extends StatefulWidget {
  final RecipeDetailsModel? value;

  const DetailsWidget({Key? key, required this.value}) : super(key: key);

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  String price = "0.0";

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
                  widget.value?.name ?? "",
                  style: TextStyle(fontSize: 18.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Text(price.toString()),
              Text(
                "\$${calculateTotalPrice(widget.value?.recipes?.first.basePrice ?? 0, widget.value?.recipes?.first.tax ?? 0)}",
                style: TextStyle(fontSize: 18.sp, color: Colors.orange),
                maxLines: 1,
              ),
            ],
          ),
          Text(
            widget.value?.ingredients ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          widget.value != null && widget.value!.recipes != null
              ? SizeSelection(
                  name: "Pizza Size",
                  model: widget.value!.recipes!,
                  onSelect: (d) {},
                )
              : const SizedBox(),
          const Text("Quantity"),
        ],
      ),
    );
  }
}

class SizeSelection extends StatefulWidget {
  final String name;
  final List<RecipeModel> model;
  final Function(String) onSelect;

  const SizeSelection({
    Key? key,
    required this.name,
    required this.model,
    required this.onSelect,
  }) : super(key: key);

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
        child: Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.model.first.size != null
                ? Text(widget.name)
                : const SizedBox(),
            widget.model.first.size != null
                ? DropdownButton<String>(
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
                        .toList(),
                  )
                : const SizedBox(),
          ],
        ),
        widget.model.first.size != null
            ? BaseSelection(
                onSelect: widget.onSelect,
                name: "Base",
                sizes: widget.model
                    .where((element) => element.size?.name == selectedItem)
                    .map((e) => e.base)
                    .expand<BaseModel?>((bases) => bases ?? [])
                    .toList(),
              )
            : BaseSelection(
                onSelect: widget.onSelect,
                name: "Base",
                sizes: widget.model.first.base ?? [],
              ),
      ],
    ));
  }
}

class BaseSelection extends StatelessWidget {
  final String name;
  final List<BaseModel?> sizes;
  final Function(String) onSelect;

  BaseSelection({
    Key? key,
    required this.name,
    required this.sizes,
    required this.onSelect,
  }) : super(key: key);

  String? selectedItem = "";

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
                            }
                            // calculateTotalPrice(price, taxPercentage)
                            onSelect(sizes
                                    .firstWhere((element) =>
                                        element?.name == selectedItem &&
                                        element?.addCost != null)
                                    ?.addCost
                                    .toString() ??
                                "0.0");
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
        ),
      ],
    ),
    trailing: Text(children.length.toString()),
    children: children.map((e) => MenuItemDetails(value: e)).toList(),
  );
}
