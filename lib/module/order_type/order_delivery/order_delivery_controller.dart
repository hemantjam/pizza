import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  RxInt index = 0.obs;

  changeIndex(int index) {
    this.index.value = index;
  }
}
