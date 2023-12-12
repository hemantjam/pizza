import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../api/api_response.dart';
import '../../../../api/api_services.dart';
import '../../../../api/end_point.dart';
import '../../../../local_storage/shared_pref.dart';
import '../../../cart/model/order_master/order_master_create_model.dart';
import '../../../cart/model/order_master/order_master_create_payload.dart';
import '../../../geography/all_active_controller.dart';
import '../../../geography/byType/street_name_model.dart';
import '../../../outlet_details/shift/outlet_shift_details_controller.dart';
import '../../../outlet_details/shift/outlet_shift_details_model.dart';
import '../../../user/logged_in_user/logged_in_user_model.dart';
import '../../../user/widgets/loader.dart';
import '../../utils/calculate_shift_time.dart';
import '../../utils/date_model.dart';

class DeliveryNowController extends GetxController {
  Rx<OutletShiftDetailsController> outletShiftDetailsController =
      Get.find<OutletShiftDetailsController>().obs;
  ApiServices apiServices = ApiServices();

  LoggedInUserModel loggedInUserModel = Get.find<LoggedInUserModel>(tag: "login");
  OrderMasterCreateModel orderMasterCreateModel = OrderMasterCreateModel();

  Rx<AllActiveController> allActiveController =
      Get.find<AllActiveController>().obs;

  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController unitController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  final FocusNode unitFocus = FocusNode();
  final FocusNode streetNumberFocus = FocusNode();

  RxList<SingleGeographyModel>? streetList = <SingleGeographyModel>[].obs;
  final RxBool rememberAddress = true.obs;
  RxBool storeOff = false.obs;

  @override
  void onInit() {
    super.onInit();
    getStreetName();
    ever(allActiveController.value.streetNameList,
        (callback) => {getStreetName()});
    getSavedAddress();
    super.onInit();
    getShiftDetails();

    ever(outletShiftDetailsController.value.outletShiftDetailsModel,
        (callback) => {getShiftDetails(), searchDateInList(DateTime.now())});
    getSavedAddress();
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

  getSavedAddress() async {
    List<String>? address = await SharedPref.fetchStringList("now");
    if (address != null) {
      unitController.text = address[0];
      streetNumberController.text = address[1];
      streetNameController.text = address[2];
      postCodeController.text = address[3];
    }
    update();
  }

  void rememberAdd(bool value) {
    rememberAddress.value = value;
  }

  void getStreetName() {
    if (allActiveController.value.streetNameList.value.data != null) {
      streetList!.value = allActiveController.value.streetNameList.value.data!
          .where((element) => element.active!)
          .toList();
      streetList!.sort((a, b) => a.geographyName!.compareTo(b.geographyName!));
    }
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
    DateTime currentTime = DateTime.now();
    if (outletShiftDetailsModel.value.data != null &&
        outletShiftDetailsModel.value.data!.special != null) {
      List<ShiftItem?>? special = outletShiftDetailsModel.value.data!.special!
          .where((element) => element!.orderTypeCode == OrderTypeCode.delivery)
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
              element.orderTypeCode == OrderTypeCode.delivery)
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
  orderMasterCreateApi() async {
    showCommonLoading(true);

    await initializeDateFormatting('en');
    OrderMasterCreatePayload payload = OrderMasterCreatePayload();
    payload.orderMstWebRequest = OrderMstWebRequest();
   // DateFormat inputFormat = DateFormat('dd MMMM yyyy, EEEE', 'en');
    ///DateTime dateTime = inputFormat.parse(dateController.text);

  //  String timeString = timeController.text;
    DateFormat inputTime = DateFormat.jm();
   // DateTime time = inputTime.parse(timeString);
  //  String formattedTime = DateFormat('HH:mm:ss').format(time);

    /*payload.orderMstWebRequest!.orderDate =
    "${dateTime.year}-${dateTime.month}-${dateTime.day}";*/
   // payload.orderMstWebRequest!.orderTime = formattedTime;
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
        loggedInUserModel.data?.customerMST?.userMSTId ;
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

    ApiResponse? res = await apiServices.postRequest(
        ApiEndPoints.orderMasterCreate,
        data: jsonEncode(payload.toMap()));
    if (res != null) {
      if (res.status) {
        orderMasterCreateModel = OrderMasterCreateModel.fromMap(res!.toJson());
        Get.put(orderMasterCreateModel, permanent: true);
        showCommonLoading(false);
        Get.back();
      }
    }
    showCommonLoading(false);
  }

}
