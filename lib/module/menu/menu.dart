import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pizza/module/menu/menu_controller.dart';
import 'package:sizer/sizer.dart';

import 'menu_model.dart';

class Menus extends GetView<OutletMenuController> {
  const Menus({super.key});


  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.start,
            children: controller.menuListModel.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              if (index % 5 == 0 && index != 0) {
                // Start a new row every 5 items
                return SizedBox(width: 0, height: 0); // Empty SizedBox to create a line break
              } else {
                // Create your item here (e.g., an Item widget)
                return menuItem(item);
              }
            }).toList(),
          ),


        /*Wrap(
          spacing: 10.0, // Horizontal spacing between items
          runSpacing: 10.0, // Vertical spacing between rows
          children: List.generate(items.length, (index) {
            if (index % 5 == 0 && index != 0) {
              // Start a new row every 5 items
              return SizedBox(width: 0, height: 0); // Empty SizedBox to create a line break
            } else {
              // Create your item here (e.g., an Item widget)
              return Item(
                text: 'Item $index',
                // Add other properties like image or content
              );
            }
          }),
        )*/
        ));
  }

  Widget menuItem(MenuListModel item) {
    return item.webDisplay != null && item.webDisplay!
        ? Container(
            alignment: Alignment.center,
            width: 49.w,
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.grey, width: 0.5), // Border style
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                item.bigImage != null
                    ? SvgPicture.network(
                        item.bigImage ?? "",
                        fit: BoxFit.contain,
                        height: 24.sp,
                        width: 24.sp,
                      )
                    : const SizedBox(),
                SizedBox(
                  width: 10.sp,
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
}
