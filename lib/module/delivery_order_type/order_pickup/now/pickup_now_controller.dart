import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../api/api_services.dart';
import '../../../cart/model/order_master/order_master_create_model.dart';
import '../../../geography/all_active_controller.dart';
import '../../../outlet_details/outlet/outlet_controller.dart';
import '../../../outlet_details/outlet/outlet_model.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../utils/calculate_shift_time.dart';
import '../../utils/date_model.dart';
import '../../utils/order_mst_create.dart';

class PickUpNowController extends GetxController {
  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;

  Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;
  ApiServices apiServices = ApiServices();
/*
  LoggedInUserModel loggedInUserModel =
      Get.find<LoggedInUserModel>(tag: "loggedInModel");*/
  OrderMasterCreateModel orderMasterCreateModel = OrderMasterCreateModel();

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
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      log(e.toString());
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
  orderCreateApi() {
    orderMasterCreateApi(
        orderTypeCode: "OT02",
       // time: timeController.text,
       // date: dateController.text
    );
  }
 /* orderMasterCreateApi() async {
    showCommonLoading(true);

    await initializeDateFormatting('en');
    OrderMasterCreatePayload payload = OrderMasterCreatePayload();
    payload.orderMstWebRequest = OrderMstWebRequest();
    payload.orderMstWebRequest!.timedOrder = true;
    payload.orderMstWebRequest!.active = true;
    payload.orderMstWebRequest!.customerAddressDtl = CustomerAddressDtl();
    payload.orderMstWebRequest!.customerAddressDtl!.active =
        loggedInUserModel.data?.userMST?.active ?? true;
    payload.orderMstWebRequest!.expressOrder = false;
    payload.orderMstWebRequest!.orderType = "OT02";
    payload.orderMstWebRequest!.userId =
        loggedInUserModel.data?.customerMST?.userMSTId;
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
        showCommonLoading(false);
        log("order master create success------->");
        Get.back();
      }
    } else {
      Get.isDialogOpen != null && Get.isDialogOpen!
          ? Get.back(closeOverlays: true)
          : null;
    }
    // showCommonLoading(false);
  }*/
}
