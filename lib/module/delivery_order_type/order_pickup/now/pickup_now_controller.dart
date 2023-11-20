import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../geography/all_active_controller.dart';
import '../../../outlet_details/outlet/outlet_controller.dart';
import '../../../outlet_details/outlet/outlet_model.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../utils/calculate_shift_time.dart';
import '../../utils/date_model.dart';

class PickUpNowController extends GetxController {
  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;

  Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;

  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;
  Rx<OutletController> outletController = OutletController().obs;
  Rx<OutletModel> outletModel = OutletModel().obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController outletAddController =
      TextEditingController(text: "77, Hoffmans Rd, NIDDRIE, 3042");
  final RxString outletAddress = "77, Hoffmans Rd, NIDDRIE, 3042".obs;
  RxBool storeOff = false.obs;

  @override
  void onInit() {
    super.onInit();
    getOutletDetails();
    ever(
        outletController.value.outletAddress, (callback) => getOutletDetails());

    super.onInit();
    getShiftDetails();

    ever(outletShiftDetailsController.value.outletShiftDetailsModel,
        (callback) => {getShiftDetails(), searchDateInList(DateTime.now())});
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

  getOutletDetails() {
    outletAddController.text = outletController.value.outletAddress.value;
  }

  Future<void> launchMapWithAddress(String address) async {
    try {
      final query = Uri.encodeComponent(address);
      final url = 'https://www.google.com/maps/search/?api=1&query=$query';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      log("Error: $e");
    }
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
          .where((element) => element!.orderTypeCode == OrderTypeCode.pickUp)
          .toList();
      for (var element in special) {
        DateTime shiftEndTime =
            calculateShiftEndTime(element!.endTime!, element.cutoffTime!);
        if (element.date == selectedDate.toString()) {
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
              element.orderTypeCode == OrderTypeCode.pickUp)
          .toList();
      if (regular.isNotEmpty) {
        for (var element in regular) {
          DateTime shiftEndTime =
              calculateShiftEndTime(element!.endTime!, element.cutoffTime!);

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
