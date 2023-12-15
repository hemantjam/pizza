import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/widgets/common_dialog.dart';

import '../../user/logged_in_user/logged_in_user_model.dart';
import '../model/order_master/order_master_create_model.dart';
import '../model/order_master/order_master_create_payload.dart';

class CheckOut extends GetxController {
  static final ApiServices _apiServices = ApiServices();

  static cartUpdate(OrderMasterCreateModel orderMasterCreateModel) async {
    LoggedInUserModel loggedInUserModel =
        Get.find<LoggedInUserModel>(tag: "loggedInUserModel");
    OrderMasterCreatePayload payload = OrderMasterCreatePayload();
    payload.orderMstWebRequest = OrderMstWebRequest();
    payload.orderMstWebRequest = OrderMstWebRequest();
    /* payload.orderMstWebRequest!.orderDate = date == null
        ? ""
        : "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}";
    payload.orderMstWebRequest!.orderTime = time == null ? "" : formattedTime;
   */
    payload.orderMstWebRequest?.id = orderMasterCreateModel.data?.id;
    payload.orderMstWebRequest!.timedOrder = true;
    payload.orderMstWebRequest!.active = true;
    payload.orderMstWebRequest!.customerAddressDtl = CustomerAddressDtl();
    payload.orderMstWebRequest!.customerAddressDtl!.active =
        loggedInUserModel.data?.userMST?.active;
    //  payload.orderMstWebRequest!.customerAddressDtl!.streetNumber = streetNumber;
    // payload.orderMstWebRequest!.customerAddressDtl!.unitNumber = unitNUmber;
    payload.orderMstWebRequest!.expressOrder = false;
    payload.orderMstWebRequest!.orderType =
        orderMasterCreateModel.data?.orderType;
    payload.orderMstWebRequest!.userId =
        loggedInUserModel.data?.customerMST?.userMSTId ??
            loggedInUserModel.data?.userMST?.userMSTId;
    payload.orderMstWebRequest!.deliveyInstrucation = "";
    payload.orderMstWebRequest!.otherInstrucation = "";
    payload.orderMstWebRequest!.orderStageCode = "DS01";
    payload.orderMstWebRequest!.customerAddressDtl!.customerMst
            ?.customerFirstName =
        loggedInUserModel.data?.customerMST?.customerFirstName;
    payload.orderMstWebRequest!.customerAddressDtl!.customerMst
            ?.customerLastName =
        loggedInUserModel.data?.customerMST?.customerLastName;

    /* payload.orderMstWebRequest!.customerAddressDtl!.address1 = unitNUmber;
    payload.orderMstWebRequest!.customerAddressDtl!.address2 = streetNumber;
    payload.orderMstWebRequest!.customerAddressDtl!.pincode = pinCode;
    payload.orderMstWebRequest!.customerAddressDtl!.streetNumber = streetNumber;
    payload.orderMstWebRequest!.customerAddressDtl!.unitNumber = unitNUmber;
    payload.orderMstWebRequest!.customerAddressDtl!.geographyMstId1 = gt1;
    payload.orderMstWebRequest!.customerAddressDtl!.geographyMstId2 = gt2;
    payload.orderMstWebRequest!.customerAddressDtl!.geographyMstId3 = gt3;*/

    ApiResponse? res = await _apiServices.postRequest(
        ApiEndPoints.orderMasterUpdate,
        data: jsonEncode(payload.toMap()));
    if (res != null && res.status) {
      log("---->${res.toJson()}");
    } else {
      showCoomonErrorDialog(title: "error", message: "Something went wrong");
    }
  }
}
