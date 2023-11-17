import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza/constants/assets.dart';
import 'package:pizza/module/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return Center(
            child: controller.serverIssue.value
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 50,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Server did not respond , Please try again.",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Center(
                    child: Image.asset(Assets.logoPng, fit: BoxFit.contain),
                  ),
          );
        },
      ),
    );
  }
}
