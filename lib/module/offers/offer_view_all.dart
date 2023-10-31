import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/module/offers/offer_controller.dart';
import 'package:pizza/module/offers/offer_info_model.dart';
import 'package:sizer/sizer.dart';

import 'offer_item.dart';

class OfferList extends GetView<OfferController> {
  const OfferList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          //  height: 190.sp,
          //  width: 261.sp,
          child: ListView.builder(
              shrinkWrap: true,
              // scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, int index) {
                SingleOfferInfoModel offer=SingleOfferInfoModel();
                return OfferItem(offer: offer,);
              }),
        ));
  }
}
