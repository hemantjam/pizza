import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../local_storage/shared_pref.dart';
import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';

class DeliveryNowController extends GetxController {
  final Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController unitController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  final FocusNode unitFocus = FocusNode();
  final FocusNode streetNumberFocus = FocusNode();

  RxList<SingleGeographyModel>? streetList = <SingleGeographyModel>[].obs;
  final RxBool rememberAddress = true.obs;
  RxBool storeOff = false.obs;

  @override
  void onInit() {
    super.onInit();
    getStreetName();
    ever(allActiveController.value.streetNameList,
        (callback) => {getStreetName()});
    getSavedAddress();
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
}
