import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../date_model.dart';

class PickUpLaterController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getShiftDetails();

    ever(outletShiftDetailsController.value.outletShiftDetailsModel,
            (callback) => {getShiftDetails()});
  }
  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;

  Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;

  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;

  RxList<ShiftData?> regularShiftData = <ShiftData?>[].obs;
  List<SingleGeographyModel>? streetList = <SingleGeographyModel>[].obs;


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController outletAddController = TextEditingController();

  final RxString outletAddress = "Outlet Address".obs;
  final RxString date = "Date".obs;
  final RxString time = "Time".obs;
  final RxInt weekDay = 0.obs;
  RxList<String> timeIntervalList = <String>[].obs;
  final RxBool isStoreOff = false.obs;
  void getShiftDetails() {
    outletShiftDetailsModel =
        outletShiftDetailsController.value.outletShiftDetailsModel;
    update();
  }

  getTime(ShiftItem shiftData) {
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

      if (time < currentTimeMinutes) {
        continue;
      }

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

  searchDateInList(DateTime dateTime)
  {
    log("--->method called");
    if (outletShiftDetailsModel.value.data != null) {
      log("--->date is not null");

      if (outletShiftDetailsModel.value.data!.special != null &&
          outletShiftDetailsModel.value.data!.special!.isNotEmpty) {
        /// check in special shift
        List<ShiftItem?>? special = outletShiftDetailsModel.value.data!.special!
            .where(
                (element) => element!.orderTypeCode == OrderTypeCode.delivery)
            .toList();
        List<int> selectedDate = <int>[
          dateTime.year,
          dateTime.month,
          dateTime.day
        ];
        if (special.isNotEmpty) {
          for (var element in special) {
            if (element!.date! == selectedDate.toString()) {
              getTime(element);
            } else {
              isStoreOff.value = true;
            }
          }
        }
      }

      /// check in regular shift
      else if (outletShiftDetailsModel.value.data!.regular != null &&
          outletShiftDetailsModel.value.data!.regular!.isNotEmpty) {
        List<ShiftItem?>? regular = outletShiftDetailsModel.value.data!.regular!
            .where((element) =>
        element!.day == dateTime.day &&
            element.orderTypeCode == OrderTypeCode.delivery)
            .toList();
        if (regular.isNotEmpty) {
          getTime(regular.first!);
        } else {
          isStoreOff.value = true;
        }
      }
    } else {
      log("--->data nulll");
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
