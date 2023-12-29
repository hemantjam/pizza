import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/module/user/logged_in_user/logged_in_user_model.dart';

import '../../../api/api_response.dart';
import '../../../api/end_point.dart';
import '../../cart/model/order_master/order_master_create_model.dart';
import '../../cart/model/order_master/order_master_create_payload.dart'
    as OMCP; //// orrder master create model
//// orrder master create model
//// orrder master create model
//// orrder master create model
//// orrder master create model
//// orrder master create model
//// orrder master create model
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
  OMCP.OrderMasterCreatePayload payload = OMCP.OrderMasterCreatePayload();
  payload.orderMstWebRequest = OMCP.OrderMstWebRequest();
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
  payload.orderMstWebRequest = OMCP.OrderMstWebRequest();
  payload.orderMstWebRequest?.orderDate = date == null
      ? ""
      : "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}";
  payload.orderMstWebRequest?.orderTime = time == null ? "" : formattedTime;
  payload.orderMstWebRequest?.timedOrder = timedOrder;
  payload.orderMstWebRequest?.active = true;
  payload.orderMstWebRequest?.customerAddressDtl = OMCP.CustomerAddressDtl(
      active: loggedInUserModel.data?.userMST?.active,

      //customerAddressDtlId: loggedInUserModel.data?.customerMST.id,
      //customerAddressTitle: loggedInUserModel.data?.userMST.tit,
      customerMst: OMCP.CustomerMst(
        active: loggedInUserModel.data?.userMST?.active,
        anniversary: loggedInUserModel.data?.customerMST?.anniversary,
        aggregator: loggedInUserModel.data?.customerMST?.aggregator,
        birthDate: loggedInUserModel.data?.customerMST?.birthDate,
        customerMstId: loggedInUserModel.data?.customerMST?.customerMSTId,
        customerLastName: loggedInUserModel.data?.customerMST?.customerLastName,
        customerGroupMstId:
            loggedInUserModel.data?.customerMST?.customerGroupMSTId,
        customerFirstName:
            loggedInUserModel.data?.customerMST?.customerFirstName,
        customerCode: loggedInUserModel.data?.customerMST?.customerCode,
        //   customerAddressDtlList:
        //      loggedInUserModel.data?.customerMST?.customerAddressDTLList as,
        createdOn: loggedInUserModel.data?.userMST?.createdOn,
        createdBy: loggedInUserModel.data?.customerMST?.userMST?.createdBy,
        emailSubscription:
            loggedInUserModel.data?.customerMST?.emailSubscription,
        // gender: loggedInUserModel.data?.customerMST?.gender,
        //ledgerBalance: loggedInUserModel.data?.customerMST?.ledgerBalance,
        modifiedBy: loggedInUserModel.data?.userMST?.modifiedBy,
        modifiedOn: loggedInUserModel.data?.userMST?.modifiedOn,
        primaryContact: loggedInUserModel.data?.customerMST?.primaryContact,
        primaryEmail: loggedInUserModel.data?.customerMST?.primaryEmail,
        storeInstruction: loggedInUserModel.data?.customerMST?.storeInstruction,
        smsSubscription: loggedInUserModel.data?.customerMST?.smsSubscription,
        userMstId: loggedInUserModel.data?.customerMST?.userMSTId,
      ),
      customerMstId: loggedInUserModel.data?.customerMST?.customerMSTId,
      geographyMstId3: gt1,
      geographyMstId4: gt2,
      geographyMstId5: gt3,
      streetNumber: streetNumber,
      unitNumber: unitNUmber,
      pincode: pinCode);

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
  log("order master create payload----->${payload.toMap()}");

  ApiResponse? res = await apiServices.postRequest(
      ApiEndPoints.orderMasterCreate,
      data: jsonEncode(payload.toMap()));

  if (res != null) {
    if (res.status) {
      final orderMasterCreateModel =
          OrderMasterCreateModel.fromMap(res.toJson());
      log("order master create response----->${orderMasterCreateModel.toMap()}");
      log("------>${res.toJson()}");
      Get.put<OrderMasterCreateModel>(orderMasterCreateModel,
          permanent: true, tag: "orderMasterCreateModel");
      await cartMasterTracking(orderMasterCreateModel.data?.id ?? "");
    }
  }
  Get.isDialogOpen ?? false ? Get.back() : null;
  Get.back();
}

cartMasterTracking(String id) async {
  ApiResponse? res = await apiServices
      .postRequest(ApiEndPoints.cartTrackingMSTCreate, data: {
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

/*
customerMst: OMCP.CustomerMst(
active: loggedInUserModel.data?.userMST?.active,
aggregator: loggedInUserModel.data?.customerMST?.aggregator,
anniversary: loggedInUserModel.data?.customerMST?.anniversary,
birthDate: loggedInUserModel.data?.customerMST?.birthDate,
createdBy: loggedInUserModel.data?.userMST?.createdBy,
createdOn: loggedInUserModel.data?.userMST?.createdOn,
customerCode: loggedInUserModel.data?.customerMST?.customerCode,
customerFirstName: loggedInUserModel.data?.customerMST?.customerFirstName,
customerGroupMstId:
loggedInUserModel.data?.customerMST?.customerGroupMSTId,
customerLastName: loggedInUserModel.data?.customerMST?.customerLastName,
customerMstId: loggedInUserModel.data?.customerMST?.customerMSTId,
emailSubscription: loggedInUserModel.data?.customerMST?.emailSubscription,
ledgerBalance:
int.parse(loggedInUserModel.data?.customerMST?.ledgerBalance ?? "0"),
modifiedBy: loggedInUserModel.data?.userMST?.modifiedBy,
modifiedOn: loggedInUserModel.data?.userMST?.modifiedOn,
primaryContact: loggedInUserModel.data?.customerMST?.primaryContact,
primaryEmail: loggedInUserModel.data?.customerMST?.primaryEmail,
smsSubscription: loggedInUserModel.data?.customerMST?.smsSubscription,
storeInstruction: loggedInUserModel.data?.customerMST?.storeInstruction,
userMstId: loggedInUserModel.data?.customerMST?.userMSTId,
),*/
