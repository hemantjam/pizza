import 'dart:developer';

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
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "OFFERS",
                style: TextStyle(fontSize: 18.sp),
              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteNames.offerList);
                },
                child: Text(
                  "View All (${controller.offerInfoModel.value.data?.totalRows})",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.lightOrange,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60.h,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
             itemCount: controller.offerInfoModel.value.data?.offers?.length,
             // itemCount: controller.offerInfoModel.value.offerListModel?.data?.length??0,
              itemBuilder: (context, int index) {
               // SingleOfferModel? offerr=controller.offerInfoModel.value.offerListModel?.data?[index];
              // log(offerr!.id!.toString());
                return OfferItem();
              }),
        ),
      ],
    );
  }
}
