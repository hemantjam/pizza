import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';

class DeliveryNowController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getStreetName();
    getPostCode();
    Future.delayed(Duration(seconds: 2), () {
      filterData();
    });
  }

  filterData() {
   /* List list = [];
    if (streetList == null) {
      return;
    } else {
      for (var streetModel in streetList!) {
        streetModel.geographyMstId==
      }
    }*/
  }

  final AllActiveController allActiveController =
      Get.find<AllActiveController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<SingleGeographyModel>? streetList = <SingleGeographyModel>[].obs;
  List<SingleGeographyModel>? postCodeList = <SingleGeographyModel>[].obs;

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
    streetList = allActiveController.streetNameList.value.data;
  }

  getPostCode() {
    postCodeList = allActiveController.postCodeList.value.data;
  }
}
