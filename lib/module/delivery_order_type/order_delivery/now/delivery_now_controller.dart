import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../local_storage/shared_pref.dart';
import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';

class DeliveryNowController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStreetName();
    ever(allActiveController.value.streetNameList,
        (callback) => {getStreetName()});
    getSavedAddress();
    /* ever(allActiveController.value.postCodeList,
        (callback) => {getPostCodeList()});*/
  }

  @override
  void onReady() {
    super.onReady();
    //
    // getPostCodeList();
  }

  getSavedAddress() async {
    List<String>? address = await SharedPref.getAddress("now");
    if (address != null) {
      unitController.text = address[0];
      streetNumberController.text = address[1];
      streetNameController.text = address[2];
      postCodeController.text = address[3];
    }
    update();
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

  final RxBool rememberAddress = true.obs;

  // final RxBool isStreetNameExpand = false.obs;
  RxString streetName = "Street Name".obs;
  RxString postCode = "Post Code".obs;
  RxBool storeOff = false.obs;

/*  void toggleExpand() {
    isStreetNameExpand.value = !isStreetNameExpand.value;
  }*/

  void rememberAdd(bool value) {
    rememberAddress.value = value;
  }

  void getStreetName() {
    if (allActiveController.value.streetNameList.value.data != null) {
      streetList!.value = allActiveController.value.streetNameList.value.data!
          .where((element) => element.active!)
          .toList();
      streetList!.sort((a, b) => a.geographyName!.compareTo(b.geographyName!));
    }

    update();
  }
/*
  getPostCode(String id) {
    postCode.value=id;
*/ /*    log("id given in method ===>${id}");
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
    }*/ /*
  }*/

/* void getPostCodeList() {
    // log("method called-->");
    if (allActiveController.value.postCodeList.value.data != null) {
      postCodeList!.value = allActiveController.value.postCodeList.value.data!
          .where((element) => element.active!)
          .toList();
    }
    update();
  }*/
}
