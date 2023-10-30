import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/module/offers/offer_controller.dart';
import 'package:pizza/module/offers/offer_info_model.dart';
import 'package:sizer/sizer.dart';
/*class OfferPage extends GetView<OfferController> {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OfferItem();
  }
}*/

/*
class OffersItem extends StatefulWidget {
  const OffersItem({super.key});

  @override
  State<OffersItem> createState() => _OffersItemState();
}

class _OffersItemState extends State<OffersItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const
        OfferItem(),
      ],
    );
  }
}*/

class OfferItem extends StatelessWidget {

  const OfferItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 261.sp,
      height: 190.sp,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              offer,
              fit: BoxFit.cover,
              height: 118.sp,
              width: 100.w,
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "OFFER 1",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(
                    r'34$',
                    style: TextStyle(fontSize: 16.sp,color: AppColors.lightOrange),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                "description in form of long text as wellllllllllllll",
                style:
                    TextStyle(fontSize: 12.sp, overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String offer =
    "https://apis.pineapplepizza.com.au/POSLocalAPI/uploads/images/ahaTc_offer1.jpg";
