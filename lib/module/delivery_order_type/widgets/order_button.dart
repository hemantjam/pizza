import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';

class OrderButton extends StatelessWidget {
  final Function() onTap;
  final bool enable;
  const OrderButton({super.key, required this.onTap,required this.enable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:enable? onTap:null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        alignment: Alignment.center,
        height: 5.h,
        decoration: BoxDecoration(
            color:enable? AppColors.black:AppColors.darkGrey,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Text(
          "Continue with the order",
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
