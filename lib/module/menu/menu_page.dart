import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pizza/module/menu/menu_controller.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import 'menu_model.dart';

class MenusPage extends GetView<OutletMenuController> {
  const MenusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.start,
          children: controller.menuListModel.isEmpty
              ? [
                  menuFallBack(),
                  menuFallBack(),
                  menuFallBack(),
                  menuFallBack(),
                  menuFallBack()
                ]
              : controller.menuListModel.map((item) {
                  return menuItem(item);
                }).toList(),
        ));
  }

  menuFallBack() {
    return Container(
      alignment: Alignment.center,
      width: 46.w,
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey, width: 0.5), // Border style
      ),
      child: SizedBox(
          height: 48.sp,
          width: 48.sp,
          child: const BlurHash(hash: Assets.homeBannerBlur)),
    );
  }

  Widget menuItem(MenuListModel item) {
    return item.webDisplay != null && item.webDisplay!
        ? Card(
            elevation: 5,
            child: Container(
              alignment: Alignment.center,
              width: 46.w,
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.grey, width: 0.0), // Border style
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  item.bigImage != null
                      ? SvgPicture.network(
                          item.bigImage ?? "",
                          fit: BoxFit.contain,
                          height: 48.sp,
                          width: 48.sp,
                        )
                      : CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 24.sp,
                          width: 24.sp,
                          imageUrl: Assets.homeBanner,
                          placeholder: (context, url) => SizedBox(
                              height: 12.h,
                              width: 100.w,
                              child:
                                  const BlurHash(hash: Assets.homeBannerBlur)),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    item.name ?? "",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
