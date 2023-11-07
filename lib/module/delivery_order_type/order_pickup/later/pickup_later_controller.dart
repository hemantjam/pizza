import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pizza/module/outlet_details/outlet/outlet_model.dart';

import '../../../outlet_details/outlet/outlet_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../utils/date_model.dart';
import '../../utils/get_time_interval.dart';

class PickUpLaterController extends GetxController {
  Rx<OutletController> outletController = OutletController().obs;

  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;


  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;
  Rx<OutletModel> outletModel = OutletModel().obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController outletAddController =
      TextEditingController(text: "77, Hoffmans Rd, NIDDRIE, 3042");

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  RxString outletAddress = "77, Hoffmans Rd, NIDDRIE, 3042".obs;
  RxList<String> timeIntervalList = <String>[].obs;
  final RxBool storeOff = false.obs;

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
    outletAddress.value = outletController.value.outletAddress.value;
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

    if (outletShiftDetailsModel.value.data != null &&
        outletShiftDetailsModel.value.data!.special != null) {
      List<ShiftItem?>? special = outletShiftDetailsModel.value.data!.special!
          .where((element) => element!.orderTypeCode == OrderTypeCode.pickUp)
          .toList();
      for (var element in special) {
        if (element!.date == selectedDate.toString()) {
        timeIntervalList.value=  getTimeIntervals(element, dateTime);
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
       timeIntervalList.value= getTimeIntervals(regular.first!, dateTime);
        storeOff.value = false;
      }
    }
  }

}
