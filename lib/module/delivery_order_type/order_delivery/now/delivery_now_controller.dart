import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../local_storage/shared_pref.dart';
import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../utils/calculate_shift_time.dart';
import '../../utils/date_model.dart';

class DeliveryNowController extends GetxController {
  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;

  Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;

  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;

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
    super.onInit();
    getShiftDetails();

    ever(outletShiftDetailsController.value.outletShiftDetailsModel,
        (callback) => {getShiftDetails(), searchDateInList(DateTime.now())});
    getSavedAddress();
  }

  @override
  void onReady() {
    super.onReady();
    DateTime currentDateTime = DateTime.now();
    currentDateTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
    );
    searchDateInList(currentDateTime);
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

  void getShiftDetails() {
    outletShiftDetailsModel =
        outletShiftDetailsController.value.outletShiftDetailsModel;
    update();
  }

  searchDateInList(DateTime dateTime) {
    storeOff.value = true;
    List<int> selectedDate = <int>[
      dateTime.year,
      dateTime.month,
      dateTime.day,
    ];
    DateTime currentTime = DateTime.now();
    if (outletShiftDetailsModel.value.data != null &&
        outletShiftDetailsModel.value.data!.special != null) {
      List<ShiftItem?>? special = outletShiftDetailsModel.value.data!.special!
          .where((element) => element!.orderTypeCode == OrderTypeCode.delivery)
          .toList();
      for (var element in special) {
        DateTime shiftEndTime =
            calculateShiftEndTime(element!.endTime!, element!.cutoffTime!);
        if (element!.date == selectedDate.toString()) {
          storeOff.value = false;
          return;
        }
        if (shiftEndTime.isBefore(currentTime)) {
          storeOff.value = true;
        }
      }
    }

    if (outletShiftDetailsModel.value.data != null &&
        outletShiftDetailsModel.value.data!.regular != null) {
      List<ShiftItem?>? regular = outletShiftDetailsModel.value.data!.regular!
          .where((element) =>
              element!.day == dateTime.weekday &&
              element.orderTypeCode == OrderTypeCode.delivery)
          .toList();
      if (regular.isNotEmpty) {
        for (var element in regular) {
          DateTime shiftEndTime =
              calculateShiftEndTime(element!.endTime!, element!.cutoffTime!);

          if (shiftEndTime.isBefore(currentTime)) {
            storeOff.value = true;
          } else {
            storeOff.value = false;
          }
        }
      }
    }
  }
}
