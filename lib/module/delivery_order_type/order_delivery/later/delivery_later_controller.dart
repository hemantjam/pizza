import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../local_storage/shared_pref.dart';
import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../utils/calculate_shift_time.dart';
import '../../utils/date_model.dart';
import '../../utils/get_time_interval.dart';
import '../../utils/get_week_list.dart';

class DeliveryLaterController extends GetxController {
  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;

  Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;

  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;

  List<SingleGeographyModel>? streetList = <SingleGeographyModel>[].obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TextEditingController unitController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

  final FocusNode unitFocus = FocusNode();
  final FocusNode streetNumberFocus = FocusNode();

  final RxBool rememberAddress = true.obs;
  RxList<String> timeIntervalList = <String>[].obs;
  final RxBool isStoreOff = false.obs;
  RxList<String> dateList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getShiftDetails();
    getStreetNameList();
    dateController = TextEditingController(
        text: DateFormat('d MMMM yyyy, EEEE').format(DateTime.now()));
    ever(allActiveController.value.streetNameList,
        (callback) => {getStreetNameList()});
    ever(outletShiftDetailsController.value.outletShiftDetailsModel,
        (callback) => {getShiftDetails(), searchDateInList(DateTime.now())});
    getSavedAddress();
    dateList.value = getNext15DaysWithWeekdays()
        .map((element) => DateFormat('d MMMM yyyy, EEEE').format(element))
        .toList();
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

  void getStreetNameList() {
    if (allActiveController.value.streetNameList.value.data != null) {
      streetList = allActiveController.value.streetNameList.value.data!
          .where((element) => element.active!)
          .toList();
    }
    update();
  }

  rememberAdd(bool value) {
    rememberAddress.value = value;
  }

  void getShiftDetails() {
    outletShiftDetailsModel =
        outletShiftDetailsController.value.outletShiftDetailsModel;
    update();
  }

  getSavedAddress() async {
    List<String>? address = await SharedPref.fetchStringList("later");
    if (address != null) {
      unitController.text = address[0];
      streetNumberController.text = address[1];
      streetNameController.text = address[2];
      postCodeController.text = address[3];
    }
    update();
  }

  searchDateInList(DateTime dateTime) {
    dateController.clear();
    isStoreOff.value = true;
    List<int> selectedDate = <int>[
      dateTime.year,
      dateTime.month,
      dateTime.day,
    ];
    if (outletShiftDetailsModel.value.data != null &&
        outletShiftDetailsModel.value.data!.special != null) {
      List<ShiftItem?>? special = outletShiftDetailsModel.value.data!.special!
          .where((element) => element!.orderTypeCode == OrderTypeCode.delivery)
          .toList();
      for (var element in special) {
        if (element!.date == selectedDate.toString()) {
          dateController.text =
              DateFormat('d MMMM yyyy, EEEE').format(dateTime);
          timeIntervalList.value = getTimeIntervals(element, dateTime);
          timeController.text = timeIntervalList.first;
          isStoreOff.value = false;
          return;
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

      if (regular.isNotEmpty &&
          (calculateShiftEndTime(
                  regular.first!.endTime!, regular.first!.cutoffTime!)
              .isBefore(dateTime))) {
        dateController.text = DateFormat('d MMMM yyyy, EEEE').format(dateTime);
        timeIntervalList.value = getTimeIntervals(regular.first!, dateTime);
        if(timeIntervalList.isNotEmpty)timeController.text = timeIntervalList.first;
        isStoreOff.value = false;
        return;
      }
    }

    if (isStoreOff.value && dateTime.day == DateTime.now().day) {
      dateList.removeAt(0);
      searchDateInList(DateTime.now().add(const Duration(days: 1)));
    } else {
      dateController.text = DateFormat('d MMMM yyyy, EEEE').format(dateTime);
    }
  }
}
