import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../constants/assets.dart';

class MenuBannerItem extends StatelessWidget {
  final String title;
  final String image;

  const MenuBannerItem({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: double.infinity,
        height: 100.0, // Adjust the height as needed
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              height: 12.h,
              width: 100.w,
              imageUrl: image,
              placeholder: (context, url) => SizedBox(
                  height: 12.h,
                  width: 100.w,
                  child: const BlurHash(hash: Assets.homeBannerBlur)),
              errorWidget: (context, url, error) => Image.asset(
                Assets.pizzaMenuPlaceHolder,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.network(
                    image ,
                    fit: BoxFit.contain,
                    height: 32.sp,
                    width: 32.sp,
                  ),
                  SizedBox(width: 10.sp),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
