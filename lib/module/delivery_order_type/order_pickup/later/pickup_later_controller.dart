import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickUpLaterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController outletAddController = TextEditingController();

  final RxBool isDataExpand = false.obs;
  final RxBool isTimeExpand = false.obs;
  final RxBool isStreetExpand = false.obs;

  final RxString outletAddress = "Outlet Address".obs;
  final RxString date = "Date".obs;
  final RxString time = "Time".obs;

  void toggleDateExpand() {
    isDataExpand.value = !isDataExpand.value;
  }

  void toggleTimeExpand() {
    isTimeExpand.value = !isTimeExpand.value;
  }
}
