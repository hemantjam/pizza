import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/route_names.dart';
import 'package:pizza/module/menu/home_page_list/menu_controller.dart';
import 'package:sizer/sizer.dart';

import '../menu_model.dart';

class MenusPage extends GetView<OutletMenuController> {
  const MenusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          elevation: 10,
          child: controller.menuListModel.isEmpty
              ? SizedBox(
                  height: 30.h,
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Loading menus")
                      ],
                    ),
                  ),
                )
              : Wrap(
                  alignment: WrapAlignment.start,
                  children: controller.menuListModel
                      .asMap()
                      .entries
                      .map((e) => GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteNames.pizzaMenuPage,
                                arguments: controller.menuListModel);
                          },
                          child: MenuItem(item: e.value)))
                      .toList(),
                ),
        ));
  }
}

class MenuItem extends StatelessWidget {
  final MenuListModel item;

  const MenuItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return item.webDisplay != null && item.webDisplay!
        ? Container(
            alignment: Alignment.center,
            width: 47.w,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ), // Border style
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item.bigImage != null
                    ? SvgPicture.network(
                        item.bigImage ?? "",
                        fit: BoxFit.contain,
                        height: 35.sp,
                        width: 35.sp,
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  item.name ?? "",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
