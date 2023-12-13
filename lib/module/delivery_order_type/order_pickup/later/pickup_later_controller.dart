import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pizza/module/outlet_details/outlet/outlet_model.dart';

import '../../../../api/api_response.dart';
import '../../../../api/api_services.dart';
import '../../../../api/end_point.dart';
import '../../../cart/model/order_master/order_master_create_model.dart';
import '../../../cart/model/order_master/order_master_create_payload.dart';
import '../../../outlet_details/outlet/outlet_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../../user/logged_in_user/logged_in_user_model.dart';
import '../../../user/widgets/loader.dart';
import '../../utils/calculate_shift_time.dart';
import '../../utils/date_model.dart';
import '../../utils/get_time_interval.dart';
import '../../utils/get_week_list.dart';

class PickUpLaterController extends GetxController {
  Rx<OutletController> outletController = OutletController().obs;

  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;
  ApiServices apiServices = ApiServices();

  LoggedInUserModel loggedInUserModel = Get.find<LoggedInUserModel>(tag: "login");
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
  RxList<String> dateList =  <String>[].obs;
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
  }  orderMasterCreateApi() async {
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

    payload.orderMstWebRequest!.expressOrder = false;
    payload.orderMstWebRequest!.orderType = "OT02";
    payload.orderMstWebRequest!.userId =
        loggedInUserModel.data?.customerMST?.userMSTId ;
    payload.orderMstWebRequest!.deliveyInstrucation = "";
    payload.orderMstWebRequest!.otherInstrucation = "";
    payload.orderMstWebRequest!.orderStageCode = "DS01";


    ApiResponse? res = await apiServices.postRequest(
        ApiEndPoints.orderMasterCreate,
        data: jsonEncode(payload.toMap()));
    if (res != null) {
      if (res.status) {
        orderMasterCreateModel = OrderMasterCreateModel.fromMap(res!.toJson());
        Get.put(orderMasterCreateModel, permanent: true);
        showCommonLoading(false);        log("order master create success------->");

        Get.back();
      }
    }else {
      Get.isDialogOpen != null && Get.isDialogOpen!
          ? Get.back(closeOverlays: true)
          : null;
    }
    //showCommonLoading(false);
  }

}
