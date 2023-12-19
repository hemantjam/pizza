import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pizza/api/api_response.dart';
import 'package:pizza/api/api_services.dart';
import 'package:pizza/api/end_point.dart';
import 'package:pizza/widgets/common_dialog.dart';

import '../model/order_master/order_master_create_model.dart';
import '../model/order_master/order_mst_update_payload.dart';

class CheckOut extends GetxController {
  static final ApiServices _apiServices = ApiServices();

  static cartUpdate(OrderMasterCreateModel orderMasterCreateModel) async {
    OrderMstUpdatePayload payload = OrderMstUpdatePayload();

    ApiResponse? res = await _apiServices.postRequest(
        ApiEndPoints.orderMasterUpdate,
        data: jsonEncode(payload.toJson()));
    if (res != null && res.status) {
      log("---->${res.toJson()}");
    } else {
      showCoomonErrorDialog(title: "error", message: "Something went wrong");
    }
  }
}
