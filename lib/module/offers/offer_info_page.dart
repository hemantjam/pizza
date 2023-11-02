import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/offers/offer_controller.dart';
import 'package:pizza/module/offers/offer_info_model.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import '../../constants/route_names.dart';
import 'offer_item.dart';

class OfferInfoPage extends GetView<OfferController> {
  const OfferInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "OFFERS",
                style: TextStyle(fontSize: 18.sp),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteNames.offerList);
                  },
                  child: Text(
                    "View All (${controller.offerInfoModel.value.totalRows})",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.lightOrange,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => SizedBox(
            height: 30.h,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.offerInfoModel.value.offers?.length,
                itemBuilder: (context, int index) {
                  SingleOfferInfoModel? offer =
                      controller.offerInfoModel.value.offers?[index];
                  return OfferItem(
                    offer: offer,
                  );
                }),
          ),
        )
      ],
    );
  }
}
