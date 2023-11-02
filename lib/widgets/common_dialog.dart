import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

void showErrorDialog({required String title, required String message}) {
  Get.dialog(
      CommonErrorDialog(
        title: title,
        message: message,
      ),
      barrierDismissible: false);
}

class CommonErrorDialog extends StatelessWidget {
  final String title;
  final String message;

  const CommonErrorDialog(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              message,
              style:  TextStyle(
                color: AppColors.black,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.lightOrange),
              ),
              child:  Text(
                'OK',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
