import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pizza/module/outlet_details/outlet/outlet_model.dart';

import '../../../../api/api_services.dart';
import '../../../cart/model/order_master/order_master_create_model.dart';
import '../../../outlet_details/outlet/outlet_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../utils/calculate_shift_time.dart';
import '../../utils/date_model.dart';
import '../../utils/get_time_interval.dart';
import '../../utils/get_week_list.dart';
import '../../utils/order_mst_create.dart';

class PickUpLaterController extends GetxController {
  Rx<OutletController> outletController = OutletController().obs;

  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;
  ApiServices apiServices = ApiServices();

/*
  LoggedInUserModel loggedInUserModel =
      Get.find<LoggedInUserModel>(tag: "loggedInModel");*/
  OrderMasterCreateModel orderMasterCreateModel = OrderMasterCreateModel();

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
  final RxBool isStoreOff = false.obs;
  RxList<String> dateList = <String>[].obs;

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

  getOutletDetails() {
    outletAddress.value = outletController.value.outletAddress.value;
    update();
  }

  void getShiftDetails() {
    outletShiftDetailsModel =
        outletShiftDetailsController.value.outletShiftDetailsModel;
    update();
  }

  /*searchDateInList(DateTime dateTime) {
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
  }*/
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
          .where((element) => element!.orderTypeCode == OrderTypeCode.pickUp)
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
              element.orderTypeCode == OrderTypeCode.pickUp)
          .toList();

      if (regular.isNotEmpty &&
          (calculateShiftEndTime(
                  regular.first!.endTime!, regular.first!.cutoffTime!)
              .isBefore(dateTime))) {
        dateController.text = DateFormat('d MMMM yyyy, EEEE').format(dateTime);
        timeIntervalList.value = getTimeIntervals(regular.first!, dateTime);
        timeController.text = timeIntervalList.first;
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

  orderCreateApi() {
    orderMasterCreateApi(
        orderTypeCode: "OT02",
        time: timeController.text,
        date: dateController.text);
  }
}
