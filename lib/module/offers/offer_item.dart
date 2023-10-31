import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/app_colors.dart';
import 'package:pizza/constants/assets.dart';
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
  final SingleOfferInfoModel? offer;

  const OfferItem({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 261.sp,
      height: 190.sp,
      child: Card(
        color: Colors.grey.shade400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              height: 118.sp,
              width: 100.w,
              imageUrl: offer?.image ?? Assets.offerImagePlaceHolder,
              placeholder: (context, url) => SizedBox(
                  height: 118.sp,
                  width: 100.w,
                  child: const BlurHash(hash: Assets.offerImageBlurHash)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    offer?.offerName ?? "",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(
                    "\$${offer?.price?.toStringAsFixed(2) ?? '0.00'}",
                    style: TextStyle(
                        fontSize: 16.sp, color: AppColors.lightOrange),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                offer?.description ?? "",
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
