import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/menu/menu_banner_item.dart';
import 'package:pizza/module/menu/menu_controller.dart';

class MenusPage extends GetView<OutletMenuController> {
  const MenusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: controller.menuListModel
              .where((p0) => p0.webDisplay!)
              .map((element) {
            return MenuBannerItem(
              title: element.name ?? "",
              image: element.bigImage ?? "",
            );
          }).toList(),
        ));
  }
}
