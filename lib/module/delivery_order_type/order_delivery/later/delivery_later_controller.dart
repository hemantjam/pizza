import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/module/cart/model/order_master/order_master_create_payload.dart';
import 'package:pizza/module/user/logged_in_user/logged_in_user_model.dart';
import 'package:pizza/module/user/widgets/loader.dart';

import '../../../../local_storage/shared_pref.dart';
import '../../../cart/model/order_master/order_master_create_model.dart';
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

  LoggedInUserModel loggedInUserModel = LoggedInUserModel();
  OrderMasterCreateModel orderMasterCreateModel = OrderMasterCreateModel();

  ApiServices apiServices = ApiServices();

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
  int? streetNameGeoId;
  int? postCodeGeoId;
  int? subUrbGeoId;

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
        if (timeIntervalList.isNotEmpty) {
          timeController.text = timeIntervalList.first;
        }
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

  orderMasterCreateApi() async {
    loggedInUserModel = Get.find<LoggedInUserModel>(tag: "login");

    showCommonLoading(true);

    await initializeDateFormatting('en');
    OrderMasterCreatePayload payload = OrderMasterCreatePayload();
    payload.orderMstWebRequest = OrderMstWebRequest();
    DateFormat inputFormat = DateFormat('dd MMMM yyyy, EEEE', 'en');
    DateTime dateTime = inputFormat.parse(dateController.text);

    String timeString = timeController.text;
    DateFormat inputTime = DateFormat.jm();
    DateTime time = inputTime.parse(timeString);
    String formattedTime = DateFormat('HH:mm:ss').format(time);

    payload.orderMstWebRequest!.orderDate =
        "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    payload.orderMstWebRequest!.orderTime = formattedTime;
    payload.orderMstWebRequest!.timedOrder = true;
    payload.orderMstWebRequest!.active = true;
    payload.orderMstWebRequest!.customerAddressDtl = CustomerAddressDtl();
    payload.orderMstWebRequest!.customerAddressDtl!.active =
        loggedInUserModel.data?.userMST?.active ?? true;
    payload.orderMstWebRequest!.customerAddressDtl!.streetNumber =
        streetNumberController.text;
    payload.orderMstWebRequest!.customerAddressDtl!.unitNumber =
        unitController.text;
    payload.orderMstWebRequest!.expressOrder = false;
    payload.orderMstWebRequest!.orderType = "OT01";
    payload.orderMstWebRequest!.userId =
        loggedInUserModel.data?.customerMST?.userMSTId;
    payload.orderMstWebRequest!.deliveyInstrucation = "";
    payload.orderMstWebRequest!.otherInstrucation = "";
    payload.orderMstWebRequest!.orderStageCode = "DS01";
    payload.orderMstWebRequest!.customerAddressDtl!.address1 =
        unitController.text;
    payload.orderMstWebRequest!.customerAddressDtl!.address2 =
        streetNumberController.text;
    payload.orderMstWebRequest!.customerAddressDtl!.pincode =
        int.parse(postCodeController.text);
    payload.orderMstWebRequest!.customerAddressDtl!.streetNumber =
        streetNumberController.text;
    payload.orderMstWebRequest!.customerAddressDtl!.unitNumber =
        unitController.text;
    payload.orderMstWebRequest!.customerAddressDtl!.geographyMstId1 =
        streetNameGeoId;
    payload.orderMstWebRequest!.customerAddressDtl!.geographyMstId2 =
        subUrbGeoId;
    payload.orderMstWebRequest!.customerAddressDtl!.geographyMstId3 =
        postCodeGeoId;

    ApiResponse? res = await apiServices.postRequest(
        ApiEndPoints.orderMasterCreate,
        data: jsonEncode(payload.toMap()));
    if (res != null) {
      if (res.status) {
        orderMasterCreateModel = OrderMasterCreateModel.fromMap(res.toJson());
        Get.put(orderMasterCreateModel, permanent: true);
        log("order master create success------->");
        showCommonLoading(false);
        //Get.back();
      }
    } else {
      Get.isDialogOpen != null && Get.isDialogOpen!
          ? Get.back(closeOverlays: true)
          : null;
    }
  }
}
