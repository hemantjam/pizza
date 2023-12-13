import 'dart:developer';

import 'package:get/get.dart';

import '../../../../api/api_response.dart';
import '../../../../api/api_services.dart';
import '../../../../api/end_point.dart';
import 'outlet_shift_details_model.dart';

class OutletShiftDetailsController extends GetxController {
  ApiServices apiClient = ApiServices();
  Rx<OutletShiftDetailsModel> outletShiftDetailsModel =
      OutletShiftDetailsModel().obs;

  @override
  void onReady() {
    getShiftDetails();
    super.onReady();
  }

  void getShiftDetails() async {
    ApiResponse? res =
        await apiClient.getRequest(ApiEndPoints.outletShiftDetails);
   // log("--shift data${res!.toJson()}");
    if (res != null && res.status) {
      outletShiftDetailsModel.value =
          OutletShiftDetailsModel.fromJson(res.toJson());
    }
    update();
  }
}
