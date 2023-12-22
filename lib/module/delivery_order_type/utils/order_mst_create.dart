import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/module/user/logged_in_user/logged_in_user_model.dart';

import '../../../api/api_response.dart';
import '../../../api/end_point.dart';
import '../../cart/model/order_master/order_master_create_model.dart';
import '../../cart/model/order_master/order_master_create_payload.dart';
import '../../cart/utils/cart_tracking_model.dart';
import '../../user/widgets/loader.dart';

ApiServices apiServices = ApiServices();

orderMasterCreateApi({
  String? date,
  required String orderTypeCode,
  required bool timedOrder,
  String? time,
  String? streetNumber,
  String? unitNUmber,
  int? pinCode,
  int? gt1,
  int? gt2,
  int? gt3,
}) async {
  showCommonLoading(true);
  LoggedInUserModel loggedInUserModel =
      Get.find<LoggedInUserModel>(tag: "loggedInUserModel");

  await initializeDateFormatting('en');
  OrderMasterCreatePayload payload = OrderMasterCreatePayload();
  payload.orderMstWebRequest = OrderMstWebRequest();
  DateTime? dateTime;
  if (date != null) {
    DateFormat inputFormat = DateFormat('dd MMMM yyyy, EEEE', 'en');
    dateTime = inputFormat.parse(date);
  }
  String? formattedTime;
  if (time != null) {
    String timeString = time;
    DateFormat inputTime = DateFormat.jm();
    DateTime parsedTime = inputTime.parse(timeString);
    formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
  }
  payload.orderMstWebRequest = OrderMstWebRequest();
  payload.orderMstWebRequest?.orderDate = date == null
      ? ""
      : "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}";
  payload.orderMstWebRequest?.orderTime = time == null ? "" : formattedTime;
  payload.orderMstWebRequest?.timedOrder = timedOrder;
  payload.orderMstWebRequest?.active = true;
  payload.orderMstWebRequest?.customerAddressDtl =null;
  payload.orderMstWebRequest?.customerAddressDtl?.active =
      loggedInUserModel.data?.userMST?.active;
  payload.orderMstWebRequest?.customerAddressDtl?.streetNumber = streetNumber;
  payload.orderMstWebRequest?.customerAddressDtl?.unitNumber = unitNUmber;
  payload.orderMstWebRequest?.expressOrder = false;
  payload.orderMstWebRequest?.orderType = orderTypeCode;
  payload.orderMstWebRequest?.userId =
      loggedInUserModel.data?.customerMST?.userMSTId ??
          loggedInUserModel.data?.userMST?.userMSTId;
  payload.orderMstWebRequest?.deliveyInstrucation = "";
  payload.orderMstWebRequest?.otherInstrucation = "";
  payload.orderMstWebRequest?.orderStageCode = "DS01";
  payload.orderMstWebRequest?.customerAddressDtl?.customerMst
          ?.customerFirstName =
      loggedInUserModel.data?.customerMST?.customerFirstName;
  payload.orderMstWebRequest?.customerAddressDtl?.customerMst
          ?.customerLastName =
      loggedInUserModel.data?.customerMST?.customerLastName;

  payload.orderMstWebRequest?.customerAddressDtl?.address1 = unitNUmber;
  payload.orderMstWebRequest?.customerAddressDtl?.address2 = streetNumber;
  payload.orderMstWebRequest?.customerAddressDtl?.pincode = pinCode;
  payload.orderMstWebRequest?.customerAddressDtl?.streetNumber = streetNumber;
  payload.orderMstWebRequest?.customerAddressDtl?.unitNumber = unitNUmber;
  payload.orderMstWebRequest?.customerAddressDtl?.geographyMstId1 = gt1;
  payload.orderMstWebRequest?.customerAddressDtl?.geographyMstId2 = gt2;
  payload.orderMstWebRequest?.customerAddressDtl?.geographyMstId3 = gt3;

  ApiResponse? res = await apiServices.postRequest(
      ApiEndPoints.orderMasterCreate,
      data: jsonEncode(payload.toMap()));

  if (res != null) {
    if (res.status) {
      final orderMasterCreateModel =
          OrderMasterCreateModel.fromMap(res.toJson());
      Get.put<OrderMasterCreateModel>(orderMasterCreateModel,
          permanent: true, tag: "orderMasterCreateModel");
      await cartMasterTracking(orderMasterCreateModel.data?.id ?? "");
    }
  }
  Get.isDialogOpen ?? false ? Get.back() : null;
  Get.back();
}

cartMasterTracking(String id) async {
  ApiResponse? res = await apiServices.postRequest(ApiEndPoints.cartTrackingMST,
      data: {
        "cartTrackingMSTId": null,
        "cartTrackingPage": "MENU_PAGE",
        "orderMSTId": id
      });
  if (res != null && res.status) {
    CartTrackingModel cartTrackingModel =
        CartTrackingModel.fromMap(res.toJson());
    Get.put<CartTrackingModel>(cartTrackingModel,
        permanent: true, tag: "cartTrackingModel");
  }
  return;
}
