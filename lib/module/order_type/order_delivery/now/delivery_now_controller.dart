import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../home/geoghyaphy/all_active_controller.dart';
import '../../../home/geoghyaphy/byType/by_type_model.dart';

class DeliveryNowController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getStreetName();
  }

  final AllActiveController allActiveController =
      Get.find<AllActiveController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<SingleGeoghraphyModel>? streetList = <SingleGeoghraphyModel>[].obs;

  final TextEditingController unitController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  final FocusNode unitFocus = FocusNode();
  final FocusNode streetNumberFocus = FocusNode();
  final FocusNode streetNameFocus = FocusNode();
  final FocusNode postCodeFocus = FocusNode();

  final RxBool rememberAddress = false.obs;
  final RxBool isExpand = false.obs;
  RxString streetName = "Street Name".obs;
  RxString postCode = "Post Code".obs;

  void toggleExpand() {
    isExpand.value = !isExpand.value;
  }

  void rememberAdd(bool value) {
    rememberAddress.value = value;
  }

  getStreetName() {
    streetList = allActiveController.typeModel.value.data;
  }
}
