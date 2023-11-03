import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../../outlet_details/outlet_shift_details_controller.dart';
import '../../../outlet_details/outlet_shift_details_model.dart';
import '../../date_model.dart';

class DeliveryLaterController extends GetxController {
  OutletShiftDetailsController outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>();

  Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;

  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;

  RxList<ShiftData?> regularShiftData = <ShiftData?>[].obs;
  List<SingleGeographyModel>? streetList = <SingleGeographyModel>[].obs;
  List<SingleGeographyModel>? postCodeList = <SingleGeographyModel>[].obs;

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
  final RxBool isDateExpand = false.obs;
  final RxBool isTimeExpand = false.obs;
  final RxBool isStreetExpand = false.obs;
  final RxString streetName = "Street Name".obs;
  final RxString postCode = "Post Code".obs;
  final RxString date = "Date".obs;
  final RxString time = "Time".obs;
  final RxInt weekDay = 0.obs;
  RxList timeIntervalList = [].obs;
  final RxBool isStoreOff = false.obs;

  @override
  void onInit() {
    super.onInit();
    getShiftDetails();
    getStreetNameList();
    getPostCodeList();
    ever(allActiveController.value.streetNameList,
        (callback) => {getStreetNameList()});
    ever(allActiveController.value.postCodeList,
        (callback) => {getPostCodeList()});
  }

  @override
  void onReady() {
    super.onReady();
    getStreetNameList();
    getPostCodeList();
  }

  void getStreetNameList() {
    if (allActiveController.value.streetNameList.value.data != null) {
      streetList = allActiveController.value.streetNameList.value.data!
          .where((element) => element.active!)
          .toList();
    }
    update();
  }

  void getPostCodeList() {
    if (allActiveController.value.postCodeList.value.data != null) {
      postCodeList = allActiveController.value.postCodeList.value.data!
          .where((element) => element.active!)
          .toList();
    }
    update();
  }

//TODO write logic to get postcode
  void getPostCode(dynamic id) {
    postCode.value = id.toString();
  }

  void toggleDateExpand() {
    isDateExpand.value = !isDateExpand.value;
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

  getTime(ShiftItem shiftData) {
    String startTime = shiftData.startTime ?? "";
    String endTime = shiftData.endTime ?? "";
    int cutoffTimeMinutes = parseTimeToMinutes(shiftData.cutoffTime ?? "");
    int intervalTimeMinutes = parseTimeToMinutes(shiftData.intervalTime ?? "");

    // List<String> timeIntervals = [];

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

    // return timeIntervals;
  }

  /// TODO working
  getTimerInterval(DateTime date) {
    if (outletShiftDetailsModel.value.data != null) {
      log("1st if--->");
      if (outletShiftDetailsModel.value.data!.special != null &&
          outletShiftDetailsModel.value.data!.special!.isNotEmpty) {
        log("2nd if--->");
        List<ShiftItem?> specialShiftData = outletShiftDetailsModel
            .value.data!.special!
            .where((element) =>
                element!.orderTypeCode == OrderTypeCode.pickUp
                /*element.day == date.weekday*/)
            .toList();
        if (specialShiftData.isNotEmpty) {
          log("3rd if--->");
          if (!specialShiftData.first!.off!) {
            log("4th if--->");
            getTime(specialShiftData.first!);
          } else {
            isStoreOff.value = true;
          }
          log("data---->${regularShiftData.length}");
        }
      } else if (outletShiftDetailsModel.value.data!.regular != null &&
          outletShiftDetailsModel.value.data!.regular!.isNotEmpty) {
        log("5st if--->");
        List<ShiftItem?> regularShiftData = outletShiftDetailsModel
            .value.data!.regular!
            .where((element) =>
                element!.orderTypeCode == OrderTypeCode.delivery &&
                element.day == date.weekday)
            .toList();

        if (regularShiftData.isNotEmpty) {
          log("6th if--->");
          if (!regularShiftData.first!.off!) {
            log("7th if--->");
            getTime(regularShiftData.first!);
          } else {
            isStoreOff.value = true;
          }
        }
      }
    }else{
      log("shift data empty");
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
      /*String formattedDate =
          DateFormat('d MMMM yyyy, EEEE').format(currentDate);*/
      result.add(DateModel(currentDate, dayOfWeek));

      currentDate = currentDate.add(const Duration(days: 1));
    }

    return result;
  }
}
