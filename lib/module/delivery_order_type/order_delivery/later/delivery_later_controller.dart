import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../outlet_details/outlet_shift_details_controller.dart';
import '../../../outlet_details/outlet_shift_details_model.dart';

class DeliveryLaterController extends GetxController {
  OutletShiftDetailsController outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>();

  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TextEditingController unitController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

  final FocusNode unitFocus = FocusNode();
  final FocusNode streetNumberFocus = FocusNode();
  final FocusNode streetNameFocus = FocusNode();
  final FocusNode postCodeFocus = FocusNode();

  final RxBool rememberAddress = false.obs;

  final RxBool isDataExpand = false.obs;
  final RxBool isTimeExpand = false.obs;
  final RxBool isStreetExpand = false.obs;
  final RxString streetName = "Street Name".obs;
  final RxString date = "Date".obs;
  final RxString time = "Time".obs;

  @override
  void onReady() {
    super.onReady();
    getShiftDetails();
  }

  void toggleDateExpand() {
    isDataExpand.value = !isDataExpand.value;
  }

  void toggleStreet() {
    isStreetExpand.value = !isStreetExpand.value;
  }

  void toggleTimeExpand() {
    isTimeExpand.value = !isTimeExpand.value;
  }

  rememberAdd(bool value) {
    rememberAddress.value = value;
  }

  void getShiftDetails() {
    outletShiftDetailsModel =
        outletShiftDetailsController.outletShiftDetailsModel;
    update();
  }

  Widget getTime(ShiftData shiftData) {
    String startTime = shiftData.startTime ?? "";
    String endTime = shiftData.endTime ?? "";

    String cutoffTime = shiftData.cutoffTime ?? "";
    String intervalTime = shiftData.intervalTime ?? "";
    List<String> timeIntervals = [];

    // Get the current time in 24-hour format
    DateTime now = DateTime.now();
    String currentTime = "${now.hour}:${now.minute}";

    // Convert start time and cutoff time to DateTime objects
    DateTime start = DateTime.parse("2000-01-01 $startTime");
    DateTime cutoff = DateTime.parse("2000-01-01 $cutoffTime");

    // Add intervals based on the start time and interval time
    while (start.isBefore(cutoff)) {
      // Format the time in 24-hour format
      String formattedTime = "${start.hour}:${start.minute}";

      // Check if it's not a past time and not greater than the end time
      if (formattedTime.compareTo(currentTime) > 0 &&
          formattedTime.compareTo(endTime) < 0) {
        timeIntervals.add(formattedTime);
      }

      // Add interval time to the current time
      start =
          start.add(Duration(minutes: int.parse(intervalTime.split(':')[1])));
    }

    return ListView(
      children: timeIntervals.map((time) => Text(time)).toList(),
    );
  }
}
