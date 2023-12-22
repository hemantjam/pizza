import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget loader(bool loading) {
  return Visibility(
    visible: loading,
    child: const CommonLoading(),
  );
}

showCommonLoading(bool show) {
  return show ? Get.dialog(const CommonLoading()) : null;
}

class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20)),
        child: const Padding(
          padding: EdgeInsets.all(40.0),
          child: CupertinoActivityIndicator(
            color: Colors.orange,
            radius: 30,
          ),
        ),
      ),
    );
  }
}
