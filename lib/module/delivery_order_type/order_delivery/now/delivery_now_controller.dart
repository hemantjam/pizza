import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';

class DeliveryNowController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    ever(allActiveController.value.streetNameList,
        (callback) => {getStreetName()});
    ever(allActiveController.value.postCodeList,
        (callback) => {getPostCodeList()});
  }
@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getStreetName();
    getPostCodeList();
  }
  final Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxList<SingleGeographyModel>? streetList = <SingleGeographyModel>[].obs;
  RxList<SingleGeographyModel>? postCodeList = <SingleGeographyModel>[].obs;

  final TextEditingController unitController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  final FocusNode unitFocus = FocusNode();
  final FocusNode streetNumberFocus = FocusNode();
  final FocusNode streetNameFocus = FocusNode();
  final FocusNode postCodeFocus = FocusNode();

  final RxBool rememberAddress = false.obs;
  final RxBool isStreetNameExpand = false.obs;
  RxString streetName = "Street Name".obs;
  RxString postCode = "Post Code".obs;

  void toggleExpand() {
    isStreetNameExpand.value = !isStreetNameExpand.value;
  }

  void rememberAdd(bool value) {
    rememberAddress.value = value;
  }

  void getStreetName() {
    if (allActiveController.value.streetNameList.value.data != null) {
      streetList!.value = allActiveController.value.streetNameList.value.data!
          .where((element) => element.active!)
          .toList();
    }
    update();
  }

  getPostCode(int id) {
    log("id given in method ===>${id}");
    if (postCodeList == null || postCodeList!.isEmpty) {
      return;
    } else {
      log("--->loading start");
      postCodeList?.forEach((element) {
        log("element-->${element.parentGeographyMstId}");
        if (element.parentGeographyMstId == id) {
          log("id mathcing in loop===>${element.parentGeographyMstId}");
          postCode.value = element.geographyName.toString();
          log("--found--${postCode.value}");
        }
      });
      log("--->loading finish");
    }
  }

  void getPostCodeList() {
   // log("method called-->");
    if (allActiveController.value.postCodeList.value.data != null) {
      postCodeList!.value = allActiveController.value.postCodeList.value.data!
          .where((element) => element.active!)
          .toList();
    }
    update();
  }
}
