import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pizza/module/menu/menu_controller.dart';
import 'package:sizer/sizer.dart';

import 'menu_model.dart';

class MenusPage extends GetView<OutletMenuController> {
  const MenusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          elevation: 10,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: controller.menuListModel
                .asMap()
                .entries
                .map((e) => menuItem(e.value))
                .toList(),
          ),
        ));
  }
}

Widget menuItem(MenuListModel item) {
  return item.webDisplay != null && item.webDisplay!
      ? Container(
          alignment: Alignment.center,
          width: 47.w,
          padding: EdgeInsets.all(6.0),
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
      : SizedBox();
}
