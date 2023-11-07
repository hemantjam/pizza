import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pizza/module/outlet_details/outlet/outlet_model.dart';

import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../../outlet_details/outlet/outlet_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../date_model.dart';

class PickUpLaterController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getShiftDetails();
    getOutletDetails();
    dateController = TextEditingController(
        text: DateFormat('d MMMM yyyy, EEEE').format(DateTime.now()));
    ever(outletShiftDetailsController.value.outletShiftDetailsModel,
        (callback) => getShiftDetails());
    ever(outletController.value.outletAddress, (callback) {
      getOutletDetails();
    });
  }

  Rx<OutletController> outletController = OutletController().obs;

  Rx<OutletModel> outletModel = OutletModel().obs;

  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;

  Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;

  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;

  RxList<ShiftData?> regularShiftData = <ShiftData?>[].obs;
  List<SingleGeographyModel>? streetList = <SingleGeographyModel>[].obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController outletAddController =
      TextEditingController(text: "77, Hoffmans Rd, NIDDRIE, 3042");
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  RxString outletAddress = "77, Hoffmans Rd, NIDDRIE, 3042".obs;
  RxList<String> timeIntervalList = <String>[].obs;
  final RxBool storeOff = false.obs;

  getOutletDetails() {
    outletAddress.value = outletController.value.outletAddress.value;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    DateTime currentDateTime = DateTime.now();

    // Reset the hours and minutes to midnight.
    currentDateTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
    );
    searchDateInList(currentDateTime);

  }
  void getShiftDetails() {
    outletShiftDetailsModel =
        outletShiftDetailsController.value.outletShiftDetailsModel;
    update();
  }

  List<String> getTimeIntervals(ShiftItem shiftData, DateTime selectedDate) {
    timeIntervalList.clear();
    String startTime = shiftData.startTime ?? "";
    String endTime = shiftData.endTime ?? "";
    int cutoffTimeMinutes = parseTimeToMinutes(shiftData.cutoffTime ?? "");
    int intervalTimeMinutes = parseTimeToMinutes(shiftData.intervalTime ?? "");

    DateTime now = DateTime.now();
    int currentTimeMinutes = now.hour * 60 + now.minute;

    int startTimeMinutes = parseTimeToMinutes(startTime);
    int endTimeMinutes = parseTimeToMinutes(endTime);

    int intervalStartTime = startTimeMinutes + cutoffTimeMinutes;
    int intervalEndTime = endTimeMinutes - cutoffTimeMinutes;

    for (int time = intervalStartTime;
        time <= intervalEndTime;
        time += intervalTimeMinutes) {
      int hours = time ~/ 60;
      int minutes = time % 60;

      DateTime intervalDateTime =
          selectedDate.add(Duration(hours: hours, minutes: minutes));

      if (intervalDateTime.isAfter(now)) {
        String period = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        if (hours == 0) {
          hours = 12;
        }

        String formattedTime =
            '$hours:${minutes.toString().padLeft(2, '0')} $period';
        timeIntervalList.add(formattedTime);
      }
    }

    return timeIntervalList;
  }

  searchDateInList(DateTime dateTime) {
    log("date time--->${dateTime}");
    storeOff.value = true;

    List<int> selectedDate = <int>[
      dateTime.year,
      dateTime.month,
      dateTime.day,
    ];

    if (outletShiftDetailsModel.value.data != null &&
        outletShiftDetailsModel.value.data!.special != null) {
      List<ShiftItem?>? special = outletShiftDetailsModel.value.data!.special!
          .where((element) => element!.orderTypeCode == OrderTypeCode.pickUp)
          .toList();
      for (var element in special) {
        if (element!.date == selectedDate.toString()) {
          getTimeIntervals(element, dateTime);
          storeOff.value = false;
          return;
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
        getTimeIntervals(regular.first!, dateTime);
        storeOff.value = false;
      }
    }
  }

  int parseTimeToMinutes(String time) {
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return hours * 60 + minutes;
  }

  List<DateModel> getNext15DaysWithWeekdays() {
    final List<DateModel> result = [];

    DateTime currentDate = DateTime.now();

    for (int i = 0; i < 14; i++) {
      int dayOfWeek = currentDate.weekday;

      result.add(DateModel(currentDate, dayOfWeek));

      currentDate = currentDate.add(const Duration(days: 1));
    }

    return result;
  }
}
